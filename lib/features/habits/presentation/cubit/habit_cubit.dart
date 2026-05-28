import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/get_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/update_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_state.dart';
import 'package:uuid/uuid.dart';

class HabitCubit extends Cubit<HabitState> {
  static const Duration _apiDelay = Duration(seconds: 2);

  final GetHabitUseCase _getHabitUseCase;
  final InsertHabitUseCase _insertHabitUseCase;
  final UpdateHabitUseCase _updateHabitUseCase;
  final DeleteHabitUseCase _deleteHabitUseCase;

  HabitCubit(
    this._getHabitUseCase,
    this._insertHabitUseCase,
    this._updateHabitUseCase,
    this._deleteHabitUseCase,
  ) : super(const HabitState());

  Future<void> getHabits({bool silent = false}) async {
    if (!silent) {
      if (state.habits.isEmpty) {
        emit(
          state.copyWith(
            listStatus: HabitListStatus.loading,
            errorMessage: null,
            actionErrorMessage: null,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isRefreshing: true,
            errorMessage: null,
            actionErrorMessage: null,
          ),
        );
      }
    }

    try {
      await Future.delayed(_apiDelay);
      final habits = await _getHabitUseCase();
      emit(
        state.copyWith(
          listStatus: HabitListStatus.loaded,
          habits: habits,
          errorMessage: null,
          deletingId: null,
          isRefreshing: false,
        ),
      );
    } catch (e) {
      if (state.habits.isEmpty) {
        emit(
          state.copyWith(
            listStatus: HabitListStatus.error,
            errorMessage: e.toString(),
            isRefreshing: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isRefreshing: false,
            actionErrorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> insertHabit(String title) async {
    emit(
      state.copyWith(
        isSaving: true,
        actionErrorMessage: null,
      ),
    );

    try {
      final newHabit = Habit(
        id: Uuid().v4(),
        title: title,
        createdAt: DateTime.now(),
      );

      await Future.delayed(_apiDelay);
      await _insertHabitUseCase(newHabit);
      await getHabits(silent: true);
      emit(state.copyWith(isSaving: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSaving: false,
          actionErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateHabit(Habit habit) async {
    try {
      await Future.delayed(_apiDelay);
      await _updateHabitUseCase(habit);
      await getHabits(silent: true);
    } catch (e) {
      emit(state.copyWith(actionErrorMessage: e.toString()));
    }
  }

  Future<void> deleteHabit(String id) async {
    emit(
      state.copyWith(
        deletingId: id,
        actionErrorMessage: null,
      ),
    );

    try {
      await Future.delayed(_apiDelay);
      await _deleteHabitUseCase(id);
      await getHabits(silent: true);
    } catch (e) {
      emit(
        state.copyWith(
          deletingId: null,
          actionErrorMessage: e.toString(),
        ),
      );
    }
  }
}

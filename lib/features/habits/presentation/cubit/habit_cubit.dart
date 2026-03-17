import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/get_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/insert_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/update_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_state.dart';
import 'package:uuid/uuid.dart';

class HabitCubit extends Cubit<HabitState> {
  final GetHabitUseCase _getHabitUseCase;
  final InsertHabitUseCase _insertHabitUseCase;
  final UpdateHabitUseCase _updateHabitUseCase;
  final DeleteHabitUseCase _deleteHabitUseCase;

  HabitCubit(
    this._getHabitUseCase,
    this._insertHabitUseCase,
    this._updateHabitUseCase,
    this._deleteHabitUseCase,
  ) : super(const HabitInitial());

  Future<void> getHabits() async {
    emit(const HabitLoading());

    try {
      final habits = await _getHabitUseCase();
      emit(HabitLoaded(habits: habits));
    } catch (e) {
      emit(HabitError(message: e.toString()));
    }
  }

  Future<void> insertHabit(String title) async {
    try {
      final newHabit = Habit(
        id: Uuid().v4(),
        title: title,
        createdAt: DateTime.now(),
      );

      await _insertHabitUseCase(newHabit);
      await getHabits();
    } catch (e) {
      emit(HabitError(message: e.toString()));
    }
  }

  Future<void> updateHabit(Habit habit) async {
    try {
      await _updateHabitUseCase(habit);
      await getHabits();
    } catch (e) {
      emit(HabitError(message: e.toString()));
    }
  }

  Future<void> deleteHabit(String id) async {
    try {
      await _deleteHabitUseCase(id);
      await getHabits();
    } catch (e) {
      emit(HabitError(message: e.toString()));
    }
  }
}

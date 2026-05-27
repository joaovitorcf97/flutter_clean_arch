import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/delete_habit_state.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/delete_habit_usecase.dart';

class DeleteHabitCubit extends Cubit<DeleteHabitState> {
  final DeleteHabitUseCase _deleteHabitUseCase;

  DeleteHabitCubit(this._deleteHabitUseCase) : super(DeleteHabitInitial());

  Future<void> deleteHabit(String id) async {
    emit(DeleteHabitLoading(id: id));

    try {
      await Future.delayed(const Duration(seconds: 2));
      await _deleteHabitUseCase(id);
      emit(DeleteHabitSuccess());
    } catch (e) {
      emit(DeleteHabitError(message: e.toString()));
    }
  }
}

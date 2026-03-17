import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/domain/repositories/habit_repository.dart';

class UpdateHabitUseCase {
  final HabitRepository _repository;

  const UpdateHabitUseCase(this._repository);

  Future<void> call(Habit habit) async {
    await _repository.update(habit);
  }
}

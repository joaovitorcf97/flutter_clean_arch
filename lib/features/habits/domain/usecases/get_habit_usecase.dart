import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/domain/repositories/habit_repository.dart';

class GetHabitUseCase {
  final HabitRepository _repository;

  const GetHabitUseCase(this._repository);

  Future<List<Habit>> call() async {
    return await _repository.get();
  }
}

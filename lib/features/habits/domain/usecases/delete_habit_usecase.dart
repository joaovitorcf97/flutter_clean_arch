import 'package:flutter_clean_arch/features/habits/domain/repositories/habit_repository.dart';

class DeleteHabitUseCase {
  final HabitRepository _repository;

  const DeleteHabitUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.delete(id);
  }
}

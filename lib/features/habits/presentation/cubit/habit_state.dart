import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';

abstract class HabitState {
  const HabitState();
}

class HabitInitial extends HabitState {
  const HabitInitial();
}

class HabitLoading extends HabitState {
  const HabitLoading();
}

class HabitLoaded extends HabitState {
  final List<Habit> habits;

  const HabitLoaded({required this.habits});
}

class HabitError extends HabitState {
  final String message;

  const HabitError({required this.message});
}

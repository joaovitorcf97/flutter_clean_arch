abstract class DeleteHabitState {}

class DeleteHabitInitial extends DeleteHabitState {}

class DeleteHabitLoading extends DeleteHabitState {
  final String id;

  DeleteHabitLoading({required this.id});
}

class DeleteHabitSuccess extends DeleteHabitState {}

class DeleteHabitError extends DeleteHabitState {
  final String message;

  DeleteHabitError({required this.message});
}

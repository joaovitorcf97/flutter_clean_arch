import 'package:equatable/equatable.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';

enum HabitListStatus { initial, loading, loaded, error }

class HabitState extends Equatable {
  static const Object _unset = Object();

  const HabitState({
    this.listStatus = HabitListStatus.initial,
    this.habits = const [],
    this.errorMessage,
    this.actionErrorMessage,
    this.deletingId,
    this.isSaving = false,
    this.isRefreshing = false,
  });

  final HabitListStatus listStatus;
  final List<Habit> habits;
  final String? errorMessage;
  final String? actionErrorMessage;
  final String? deletingId;
  final bool isSaving;
  final bool isRefreshing;

  bool get showFullScreenLoading =>
      listStatus == HabitListStatus.loading && habits.isEmpty;

  bool get showFullScreenError =>
      listStatus == HabitListStatus.error && habits.isEmpty;

  HabitState copyWith({
    HabitListStatus? listStatus,
    List<Habit>? habits,
    Object? errorMessage = _unset,
    Object? actionErrorMessage = _unset,
    Object? deletingId = _unset,
    bool? isSaving,
    bool? isRefreshing,
  }) {
    return HabitState(
      listStatus: listStatus ?? this.listStatus,
      habits: habits ?? this.habits,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
      actionErrorMessage: identical(actionErrorMessage, _unset)
          ? this.actionErrorMessage
          : actionErrorMessage as String?,
      deletingId: identical(deletingId, _unset)
          ? this.deletingId
          : deletingId as String?,
      isSaving: isSaving ?? this.isSaving,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    listStatus,
    habits,
    errorMessage,
    actionErrorMessage,
    deletingId,
    isSaving,
    isRefreshing,
  ];
}

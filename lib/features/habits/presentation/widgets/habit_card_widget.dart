import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_state.dart';

class HabitCardWidget extends StatelessWidget {
  final Habit habit;

  const HabitCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final habitCubit = sl<HabitCubit>();

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: BlocBuilder<HabitCubit, HabitState>(
          bloc: habitCubit,
          buildWhen: (previous, current) =>
              previous.deletingId != current.deletingId,
          builder: (context, state) {
            final isDeleting = state.deletingId == habit.id;

            return IconButton(
              onPressed: isDeleting
                  ? null
                  : () => habitCubit.deleteHabit(habit.id),
              icon: isDeleting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete),
            );
          },
        ),
      ),
    );
  }
}

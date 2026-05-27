import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_cubit.dart';

class HabitCardWidget extends StatelessWidget {
  final Habit habit;

  const HabitCardWidget({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final HabitCubit cubit = sl<HabitCubit>();

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: Column(
          children: [
            IconButton(
              onPressed: () {
                cubit.deleteHabit(habit.id);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

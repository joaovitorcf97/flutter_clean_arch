import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/delete_habit_cubit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/delete_habit_state.dart';

class HabitCardWidget extends StatelessWidget {
  final Habit habit;
  final void Function() onDelete;

  const HabitCardWidget({
    super.key,
    required this.habit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final DeleteHabitCubit cubit = DeleteHabitCubit(sl<DeleteHabitUseCase>());

    return Card(
      child: ListTile(
        title: Text(habit.title),
        trailing: Column(
          children: [
            IconButton(
              onPressed: () async {
                await cubit.deleteHabit(habit.id);
              },
              icon: BlocConsumer<DeleteHabitCubit, DeleteHabitState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is DeleteHabitSuccess) {
                    onDelete();
                  }

                  if (state is DeleteHabitError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is DeleteHabitLoading) {
                    if (state.id == habit.id) {
                      return const CircularProgressIndicator();
                    }
                  }
                  return const Icon(Icons.delete);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

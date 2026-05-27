import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_state.dart';
import 'package:flutter_clean_arch/features/habits/presentation/widgets/empty_habit_view_widget.dart';
import 'package:flutter_clean_arch/features/habits/presentation/widgets/error_habits_view_widget.dart';
import 'package:flutter_clean_arch/features/habits/presentation/widgets/habits_form_dialog.dart';
import 'package:flutter_clean_arch/features/habits/presentation/widgets/list_habits_widget.dart';
import 'package:flutter_clean_arch/features/habits/presentation/widgets/loading_habits_view_widget.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  final HabitCubit _habitCubit = sl<HabitCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _habitCubit.getHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: BlocConsumer<HabitCubit, HabitState>(
        bloc: _habitCubit,
        builder: (context, state) {
          switch (state) {
            case HabitInitial() || HabitLoading():
              return const LoadingHabitsViewWidget();
            case HabitLoaded():
              if (state.habits.isEmpty) {
                return const EmptyHabitViewWidget();
              }
              return ListHabitsWidget(habits: state.habits);
            case HabitError():
              return ErrorHabitsViewWidget(message: state.message);
            default:
              return const SizedBox.shrink();
          }
        },
        listener: (context, state) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const HabitsFormDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

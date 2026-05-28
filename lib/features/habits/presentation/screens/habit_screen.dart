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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _habitCubit.getHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: BlocConsumer<HabitCubit, HabitState>(
        bloc: _habitCubit,
        listenWhen: (previous, current) =>
            previous.actionErrorMessage != current.actionErrorMessage &&
            current.actionErrorMessage != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.actionErrorMessage!)),
          );
        },
        builder: (context, state) {
          if (state.showFullScreenLoading) {
            return const LoadingHabitsViewWidget();
          }

          if (state.showFullScreenError) {
            return ErrorHabitsViewWidget(message: state.errorMessage!);
          }

          if (state.habits.isEmpty) {
            return const EmptyHabitViewWidget();
          }

          return Stack(
            children: [
              ListHabitsWidget(habits: state.habits),
              if (state.isRefreshing)
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(),
                ),
            ],
          );
        },
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

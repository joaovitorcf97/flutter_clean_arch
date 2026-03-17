import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_cubit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/cubit/habit_state.dart';

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
              return const Center(child: CircularProgressIndicator());
            case HabitLoaded():
              return ListView.builder(
                itemCount: state.habits.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(state.habits[index].title));
                },
              );
            case HabitError():
              return Center(child: Text(state.message));
            default:
              return const SizedBox.shrink();
          }
        },
        listener: (context, state) {
          if (state is HabitError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';
import 'package:flutter_clean_arch/features/habits/presentation/widgets/habit_card_widget.dart';

class ListHabitsWidget extends StatelessWidget {
  final List<Habit> habits;

  const ListHabitsWidget({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        return HabitCardWidget(habit: habits[index]);
      },
    );
  }
}

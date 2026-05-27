import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/features/habits/domain/entities/habit.dart';

class ListHabitsWidget extends StatelessWidget {
  final List<Habit> habits;

  const ListHabitsWidget({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(habits[index].title));
      },
    );
  }
}

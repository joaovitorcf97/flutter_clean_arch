import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/features/habits/presentation/screens/habit_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Arch',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HabitScreen(),
    );
  }
}

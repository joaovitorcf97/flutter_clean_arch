import 'package:flutter_clean_arch/core/database/app_database.dart';
import 'package:flutter_clean_arch/core/database/tables/habits_table.dart';
import 'package:flutter_clean_arch/features/habits/data/datasource/habit_local_datasource.dart';
import 'package:flutter_clean_arch/features/habits/data/models/habit_model.dart';
import 'package:sqflite/sqflite.dart';

class HabitLocalDatasourceImpl implements HabitLocalDatasource {
  Future<Database> get _database async => await AppDatabase.instance;

  @override
  Future<List<HabitModel>> getHabits() async {
    final db = await _database;
    final List<Map<String, dynamic>> habitsMaps = await db.query(
      habitsTableName,
    );
    return habitsMaps.map(HabitModel.fromMap).toList();
  }

  @override
  Future<void> insertHabit(HabitModel habit) async {
    final db = await _database;
    await db.insert(
      habitsTableName,
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateHabit(HabitModel habit) async {
    final db = await _database;
    await db.update(
      habitsTableName,
      habit.toMap(),
      where: '$habitsTableId = ?',
      whereArgs: [habit.id],
    );
  }

  @override
  Future<void> deleteHabit(String id) async {
    final db = await _database;
    await db.delete(
      habitsTableName,
      where: '$habitsTableId = ?',
      whereArgs: [id],
    );
  }
}

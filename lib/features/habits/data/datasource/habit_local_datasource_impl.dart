import 'package:flutter_clean_arch/core/database/app_database.dart';
import 'package:flutter_clean_arch/core/database/tables/habits_table.dart';
import 'package:flutter_clean_arch/features/habits/data/datasource/habit_local_datasource.dart';
import 'package:sqflite/sqflite.dart';

class HabitLocalDatasourceImpl implements HabitLocalDatasource {
  Future<Database> get _database async => await AppDatabase.instance;

  @override
  Future<List<Map<String, dynamic>>> getHabits() async {
    final db = await _database;
    return await db.query(habitsTableName);
  }

  @override
  Future<void> insertHabit(Map<String, dynamic> habit) async {
    final db = await _database;
    await db.insert(
      habitsTableName,
      habit,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateHabit(Map<String, dynamic> habit) async {
    final db = await _database;
    await db.update(
      habitsTableName,
      habit,
      where: '$habitsTableId = ?',
      whereArgs: [habit[habitsTableId]],
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

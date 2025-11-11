import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../../modele/task_model.dart';
import '../../utils/constants.dart';

/// Data Access Object for Task table
/// Handles all database operations related to tasks
class TaskDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Insert a new task into the database
  /// Returns the task ID of the inserted task
  Future<int> insert(Task task) async {
    try {
      final db = await _dbHelper.database;
      return await db.insert(
        AppConstants.tableTasks,
        task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }


  /// Get a task by ID
  /// Returns Task object if found, null otherwise
  Future<Task?> getTaskById(int id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableTasks,
        where: '${AppConstants.columnTaskId} = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) return null;
      return Task.fromMap(maps.first);
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Update a task
  /// Returns number of rows affected (should be 1)
  Future<int> update(Task task) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        AppConstants.tableTasks,
        task.toMap(),
        where: '${AppConstants.columnTaskId} = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Delete a task by ID
  /// Returns number of rows affected (should be 1)
  Future<int> delete(int id) async {
    try {
      final db = await _dbHelper.database;
      return await db.delete(
        AppConstants.tableTasks,
        where: '${AppConstants.columnTaskId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Toggle task completion status
  /// Returns number of rows affected (should be 1)
  Future<int> toggleComplete(int id, bool isCompleted) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        AppConstants.tableTasks,
        {AppConstants.columnTaskIsCompleted: isCompleted ? 1 : 0},
        where: '${AppConstants.columnTaskId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  // Count tasks (for total display)
  Future<int> countTasks({int? userId}) async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      userId != null
          ? 'SELECT COUNT(*) FROM tasks WHERE user_id = ?'
          : 'SELECT COUNT(*) FROM tasks',
      userId != null ? [userId] : [],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

}
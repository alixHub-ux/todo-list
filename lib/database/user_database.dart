import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../../modele/user_model.dart';
import '../../utils/constants.dart';

/// Data Access Object for User table
/// Handles all database operations related to users
class UserDao {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Insert a new user into the database
  /// Returns the user ID of the inserted user
  /// Throws exception if email already exists
  Future<int> insert(User user) async {
    try {
      final db = await _dbHelper.database;
      return await db.insert(
        AppConstants.tableUsers,
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
    } catch (e) {
      // Check if it's a unique constraint violation
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw Exception(AppConstants.erreurEmailExiste);
      }
      throw Exception('${AppConstants.erreurInscription}: $e');
    }
  }

  /// Get a user by email
  /// Returns User object if found, null otherwise
  Future<User?> getUserByEmail(String email) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableUsers,
        where: '${AppConstants.columnUserEmail} = ?',
        whereArgs: [email],
        limit: 1,
      );

      if (maps.isEmpty) return null;
      return User.fromMap(maps.first);
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Get a user by ID
  /// Returns User object if found, null otherwise
  Future<User?> getUserById(int id) async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableUsers,
        where: '${AppConstants.columnUserId} = ?',
        whereArgs: [id],
        limit: 1,
      );

      if (maps.isEmpty) return null;
      return User.fromMap(maps.first);
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Check if an email already exists in the database
  /// Returns true if email exists, false otherwise
  Future<bool> emailExists(String email) async {
    try {
      final user = await getUserByEmail(email);
      return user != null;
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Authenticate user with email and password
  /// Returns User object if credentials are valid, null otherwise
  Future<User?> authenticate(String email, String password) async {
    try {
      final user = await getUserByEmail(email);
      
      if (user == null) return null;
      
      // Compare passwords (in production, use hashed passwords)
      if (user.password == password) {
        return user;
      }
      
      return null;
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexion}: $e');
    }
  }

  /// Update user information
  /// Returns number of rows affected (should be 1)
  Future<int> update(User user) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        AppConstants.tableUsers,
        user.toMap(),
        where: '${AppConstants.columnUserId} = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Delete a user by ID
  /// Returns number of rows affected (should be 1)
  /// Also deletes all tasks associated with this user (CASCADE)
  Future<int> delete(int id) async {
    try {
      final db = await _dbHelper.database;
      return await db.delete(
        AppConstants.tableUsers,
        where: '${AppConstants.columnUserId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Get all users (useful for admin purposes)
  /// Returns list of all users
  Future<List<User>> getAllUsers() async {
    try {
      final db = await _dbHelper.database;
      final maps = await db.query(
        AppConstants.tableUsers,
        orderBy: '${AppConstants.columnUserCreatedAt} DESC',
      );

      return maps.map((map) => User.fromMap(map)).toList();
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Get total number of users
  /// Returns count of users
  Future<int> getUserCount() async {
    try {
      final db = await _dbHelper.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.tableUsers}'
      );
      
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Update user password
  /// Returns number of rows affected (should be 1)
  Future<int> updatePassword(int userId, String newPassword) async {
    try {
      final db = await _dbHelper.database;
      return await db.update(
        AppConstants.tableUsers,
        {AppConstants.columnUserPassword: newPassword},
        where: '${AppConstants.columnUserId} = ?',
        whereArgs: [userId],
      );
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }

  /// Check if user exists by ID
  /// Returns true if user exists, false otherwise
  Future<bool> userExists(int id) async {
    try {
      final user = await getUserById(id);
      return user != null;
    } catch (e) {
      throw Exception('${AppConstants.erreurConnexionBD}: $e');
    }
  }
}
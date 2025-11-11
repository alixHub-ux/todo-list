import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';

/// Singleton class for managing SQLite database
/// Handles database creation, initialization, and access
class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Database instance
  static Database? _database;

  // Private constructor
  DatabaseHelper._init();

  /// Get database instance
  /// Creates database if it doesn't exist
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(AppConstants.databaseName);
    return _database!;
  }

  /// Initialize database
  /// Creates the database file and opens it
  Future<Database> _initDB(String filePath) async {
    // Get the default database location
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Open the database
    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _createDB,
    );
  }

  /// Create database tables
  /// Called when database is created for the first time
  Future _createDB(Database db, int version) async {
    // Create Users table
    await db.execute('''
      CREATE TABLE ${AppConstants.tableUsers} (
        ${AppConstants.columnUserId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppConstants.columnUserEmail} TEXT UNIQUE NOT NULL,
        ${AppConstants.columnUserPassword} TEXT NOT NULL,
        ${AppConstants.columnUserCreatedAt} INTEGER NOT NULL
      )
    ''');

    // Create Tasks table with foreign key to Users
    await db.execute('''
      CREATE TABLE ${AppConstants.tableTasks} (
        ${AppConstants.columnTaskId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppConstants.columnTaskUserId} INTEGER NOT NULL,
        ${AppConstants.columnTaskName} TEXT NOT NULL,
        ${AppConstants.columnTaskDate} INTEGER NOT NULL,
        ${AppConstants.columnTaskIsCompleted} INTEGER DEFAULT 0,
        ${AppConstants.columnTaskCreatedAt} INTEGER NOT NULL,
        FOREIGN KEY (${AppConstants.columnTaskUserId}) 
          REFERENCES ${AppConstants.tableUsers} (${AppConstants.columnUserId}) 
          ON DELETE CASCADE
      )
    ''');

    // Create index on user_id for faster queries
    await db.execute('''
      CREATE INDEX idx_tasks_user_id 
      ON ${AppConstants.tableTasks} (${AppConstants.columnTaskUserId})
    ''');

    // Create index on is_completed for filtering
    await db.execute('''
      CREATE INDEX idx_tasks_completed 
      ON ${AppConstants.tableTasks} (${AppConstants.columnTaskIsCompleted})
    ''');
  }

  /// Close database connection
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  /// Delete database (useful for testing or clearing all data)
  Future deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }

  /// Check if database exists
  Future<bool> databaseExists() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);
    return await databaseFactory.databaseExists(path);
  }
}
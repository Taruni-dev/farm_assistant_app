// lib/database/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as developer;

class DBHelper {
  // Singleton instance
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        mobile TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertUser(String name, String mobile, String password) async {
    final db = await instance.database;
    await db.insert(
      'users',
      {'name': name, 'mobile': mobile, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    developer.log('Inserted user: $name with password: $password');
  }

  Future<bool> userExists(String name) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'name = ?',
      whereArgs: [name],
    );
    developer.log('User exists check for $name: ${result.isNotEmpty}');
    return result.isNotEmpty;
  }

  Future<String?> getPasswordByName(String name) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    if (result.isNotEmpty) {
      developer.log('Password fetched for $name');
      return result.first['password'] as String;
    }
    developer.log('No password found for $name');
    return null;
  }

  Future<bool> validateUser(String name, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
      limit: 1,
    );
    developer.log('Login validation for $name: ${result.isNotEmpty}');
    return result.isNotEmpty;
  }

  Future<int> updatePassword(String name, String newPassword) async {
    final db = await instance.database;
    final updatedCount = await db.update(
      'users',
      {'password': newPassword},
      where: 'name = ?',
      whereArgs: [name],
    );
    developer.log('Password updated for $name, rows affected: $updatedCount');
    return updatedCount;
  }
}

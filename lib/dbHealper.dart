import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'employees.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // Create tables or define your database schema here
    await db.execute(
        'CREATE TABLE employees_data(id INTEGER PRIMARY KEY, firstname TEXT,lastname TEXT,email TEXT)');
  }

  Future<int> saveData(Map<String, dynamic> data) async {
    var dbClient = await db;
    return await dbClient.insert('employees_data', data);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    var dbClient = await db;
    return await dbClient.query('employees_data');
  }
}

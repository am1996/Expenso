import 'package:flutter/material.dart';
import 'package:myapp/models/expense.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DB {
  static const _databaseName = 'expenses.db';
  static const _databaseVersion = 1;
  static const _tablename = "expenses";

  static Future<Database>? _database;

  static Future<Database> get database async {
    return _database ??
        openDatabase(
          path.join(await getDatabasesPath(), _databaseName),
          version: _databaseVersion,
          onCreate: _onCreate,
        );
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tablename (
        ID TEXT,
        TITLE TEXT,
        CATEGORY TEXT,
        CREATED_AT TEXT
      )
    ''');
  }

  Future<int> insertOne(Expense e) async {
    final db = await database;
    final result = db.insert(_tablename, e.toMap());
    return result;
  }

  Future<String> getNotes() async {
    final db = await database;
    final results = await db.query("SELECT * FROM $_tablename");
    debugPrint(results.toString());
    return results.toString();
  }
}

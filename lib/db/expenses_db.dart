import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import "package:sqflite/sqflite.dart";

import '../models/expense.dart';

class DB {
  static const _databaseName = 'expenses.db';
  static const _databaseVersion = 1;
  static const _tableName = "expenses";

  static Future<Database>? _database;

  static Future<Database> get database async {
    String p = path.join(await getDatabasesPath(), _databaseName);
    return _database ??
        openDatabase(
          p,
          version: _databaseVersion,
          onCreate: _onCreate,
        );
  }

  static void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        ID TEXT,
        TITLE TEXT,
        CATEGORY TEXT,
        CREATED_AT TEXT
      )
    ''');
  }

  Future<int> insertOne(Expense e) async {
    final db = await database;
    final result = db.insert(_tableName, e.toMap());
    return result;
  }

  Future<String> getNotes() async {
    final db = await database;
    final results = await db.query("SELECT * FROM $_tableName");
    debugPrint(results.toString());
    return results.toString();
  }
}

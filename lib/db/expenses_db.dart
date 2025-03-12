import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import '../models/expense.dart';

class DB {
  static const _databaseName = 'expenses.db';
  static const _databaseVersion = 1;
  static const _tableName = "expenses";
  static Database? _database;

  // Get the database instance (singleton)
  static Future<Database> get database async {
    if (_database != null) {
      return _database!; // Return the existing database instance if already initialized
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    // Get the database file path
    String path = join(await getDatabasesPath(), _databaseName);

    // Open the database, create if it doesn't exist
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate, // Define the table creation logic here
    );
  }

  // Define the table creation logic
  static Future<void> _onCreate(Database db, int version) async {
    // Create the 'expenses' table (or 'transactions' based on your app's design)
    await db.execute('''
      CREATE TABLE expenses (
        id TEXT,
        name TEXT,
        amount REAL,
        currency TEXT,
        paymentMethod TEXT,
        date TEXT,
        time TEXT,
        createdAt TEXT
      )
    ''');
  }
  static Future<List<Expense>> searchDB(String searched,String query) async{
    final db = await database;
    final maps =  await db.query('expenses',where:"$searched LIKE ?",whereArgs: ['%$query%'] );
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }
  Future<String> getDBPath() async {
    String p = path.join(await getDatabasesPath(), _databaseName);
    return p;
  }

  void dropTable() async {
    final db = await database;
    await db.execute("DROP TABLE $_tableName");
  }
  static Future<int> deleteExpense(Expense e) async{
    final db = await database;
    return await db.delete(_tableName,where: 'id = ?',whereArgs: [e.id]);
  }
  static Future<int> insertExpense(Expense e) async {
    final db = await database;
    return await db.insert(
      _tableName,
      e.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if exists
    );
  }

  // Get all transactions from the database
  static Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }
}

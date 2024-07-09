import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'testDatabase');
    return await openDatabase(
      path,
      version: 2,
      onCreate: onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('ALTER TABLE education ADD COLUMN experiance INTEGER');
      },
    );
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE first(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  age INTEGER)
''');
    await db.execute('''
CREATE TABLE education(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userId INTEGER,
  jobTitle TEXT,
  salary REAL,
  experiance INTEGER
  FOREIGN KEY (userId) REFERENCES first (id) ON DELETE CASCADE
)
''');
  }

  Future<int> addData(Map<String, dynamic> rawData) async {
    final db = await database;
    return await db.insert('first', {
      'name': rawData['name'],
      'age': rawData['age'],
    });
  }

  Future<int> addEducation(Map<String, dynamic> rawData) async {
    final db = await database;
    return await db.insert('education', {
      'userId': rawData['userId'],
      'jobTitle': rawData['jobTitle'],
      'salary': rawData['salary'],
      'experiance': rawData['experiance']
    });
  }

  Future<List<Map<String, dynamic>>> getEducation() async {
    final db = await database;
    return await db.query('education',
        columns: ['id', 'userId', 'jobTitle', 'salary', 'experiance']);
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final db = await database;
    return await db.query('first', columns: ['name', 'age', 'id']);
  }

  Future<List<Map<String, dynamic>>> getUserData(int id) async {
    final db = await database;
    List<Map<String, dynamic>> userEducation =
        await db.query('education', where: 'userId = ?', whereArgs: [id]);
    return userEducation;
  }

  Future deleteData(userId) async {
    final db = await database;
    return await db
        .delete('education', where: 'userId = ?', whereArgs: [userId]);
  }
}

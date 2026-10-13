import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final instance = AppDatabase._();
  Database? _db;
  Future<Database> get database async => _db ??= await _open();
  Future<Database> _open() async {
    final path = p.join(await getDatabasesPath(), 'taskflow.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT NOT NULL DEFAULT '',notes TEXT NOT NULL DEFAULT '',category TEXT NOT NULL DEFAULT 'عام',priority INTEGER NOT NULL DEFAULT 1,due_at TEXT,reminder_at TEXT,completed INTEGER NOT NULL DEFAULT 0,created_at TEXT NOT NULL)");
      await db.execute("CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL UNIQUE,color INTEGER NOT NULL)");
      await db.insert('categories', {'name':'عام','color':4280391411});
    }, onUpgrade: (db, oldVersion, newVersion) async { if(oldVersion < 1) { await db.execute('CREATE TABLE IF NOT EXISTS categories(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL UNIQUE,color INTEGER NOT NULL)'); } });
  }
}

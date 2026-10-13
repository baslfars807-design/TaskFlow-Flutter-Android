import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../core/database/app_database.dart';
import '../models/task.dart';

class TaskRepository {
  final AppDatabase _database = AppDatabase.instance;
  Future<List<TaskItem>> all() async { final db=await _database.database; final rows=await db.query('tasks',orderBy:'completed ASC, due_at IS NULL, due_at ASC, created_at DESC'); return rows.map(TaskItem.fromMap).toList(); }
  Future<int> save(TaskItem task) async { final db=await _database.database; if(task.id==null) return db.insert('tasks',task.toMap()..remove('id')); return db.update('tasks',task.toMap()..remove('id'),where:'id=?',whereArgs:[task.id]); }
  Future<void> delete(int id) async { final db=await _database.database; await db.delete('tasks',where:'id=?',whereArgs:[id]); }
  Future<void> clear() async { final db=await _database.database; await db.delete('tasks'); await db.delete('categories',where:'name != ?',whereArgs:['عام']); }
  Future<List<Map<String,Object?>>> categories() async => (await (await _database.database).query('categories',orderBy:'name')).toList();
  Future<void> addCategory(String name,int color) async { final db=await _database.database; await db.insert('categories',{'name':name.trim(),'color':color},conflictAlgorithm:ConflictAlgorithm.abort); }
  Future<String> exportJson() async { final db=await _database.database; final tasks=await db.query('tasks'); final cats=await db.query('categories'); return const JsonEncoder.withIndent('  ').convert({'format':'taskflow','version':1,'tasks':tasks,'categories':cats}); }
  Future<int> importJson(String content) async {
    final decoded=jsonDecode(content); if(decoded is! Map || decoded['format']!='taskflow' || decoded['version']!=1 || decoded['tasks'] is! List || decoded['categories'] is! List) throw const FormatException('ملف TaskFlow غير صالح أو إصداره غير مدعوم');
    final tasks=(decoded['tasks'] as List); final cats=(decoded['categories'] as List);
    for(final t in tasks){ if(t is! Map || t['title'] is! String || (t['title'] as String).trim().isEmpty || t['created_at'] is! String || t['priority'] is! int || (t['priority'] as int)<0 || (t['priority'] as int)>2) throw const FormatException('توجد مهمة غير صالحة داخل الملف'); DateTime.parse(t['created_at'] as String); if(t['due_at']!=null) DateTime.parse(t['due_at'] as String); }
    for(final c in cats){if(c is! Map || c['name'] is! String || c['color'] is! int) throw const FormatException('توجد فئة غير صالحة داخل الملف');}
    final db=await _database.database; return db.transaction((txn) async { for(final c in cats){ await txn.insert('categories',{'name':c['name'],'color':c['color']},conflictAlgorithm:ConflictAlgorithm.ignore); } int n=0; for(final raw in tasks){ final m=Map<String,Object?>.from(raw as Map); m.remove('id'); await txn.insert('tasks',m); n++; } return n; });
  }
}

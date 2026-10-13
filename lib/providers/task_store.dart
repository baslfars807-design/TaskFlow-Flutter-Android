import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../services/notification_service.dart';

class TaskStore extends ChangeNotifier {
  final TaskRepository repository=TaskRepository(); List<TaskItem> tasks=[]; bool loading=true; String search=''; int? priorityFilter; String? categoryFilter; String sort='date';
  Future<void> load() async {loading=true;notifyListeners();tasks=await repository.all();loading=false;notifyListeners();}
  Future<void> save(TaskItem task) async {await repository.save(task);await load();final saved=tasks.firstWhere((t)=>t.id==task.id || (task.id==null && t.title==task.title && t.createdAt==task.createdAt));if(saved.reminderAt!=null && !saved.completed){await NotificationService.instance.schedule(saved);}else if(saved.id!=null){await NotificationService.instance.cancel(saved.id!);}}
  Future<void> remove(TaskItem task) async {if(task.id!=null){await repository.delete(task.id!);await NotificationService.instance.cancel(task.id!);}await load();}
  Future<void> toggle(TaskItem task) async {final updated=task.copyWith(completed:!task.completed);await repository.save(updated);if(updated.id!=null){if(updated.completed) await NotificationService.instance.cancel(updated.id!);else await NotificationService.instance.schedule(updated);}await load();}
  List<TaskItem> get filtered {final q=search.trim().toLowerCase();var list=tasks.where((t){if(q.isNotEmpty && !('${t.title} ${t.description} ${t.notes}'.toLowerCase().contains(q)))return false;if(priorityFilter!=null&&t.priority!=priorityFilter)return false;if(categoryFilter!=null&&t.category!=categoryFilter)return false;return true;}).toList();list.sort((a,b){if(sort=='priority')return b.priority.compareTo(a.priority);if(sort=='created')return b.createdAt.compareTo(a.createdAt);final ad=a.dueAt,bd=b.dueAt;if(ad==null&&bd==null)return b.createdAt.compareTo(a.createdAt);if(ad==null)return 1;if(bd==null)return -1;return ad.compareTo(bd);});return list;}
  List<TaskItem> get today => filtered.where((t)=>!t.completed&&t.dueAt!=null&&_sameDay(t.dueAt!,DateTime.now())).toList();
  List<TaskItem> get overdue => filtered.where((t)=>!t.completed&&t.dueAt!=null&&t.dueAt!.isBefore(DateTime(now.year,now.month,now.day))).toList();
  List<TaskItem> get upcoming => filtered.where((t)=>!t.completed&&t.dueAt!=null&&t.dueAt!.isAfter(DateTime(now.year,now.month,now.day))).toList();
  List<TaskItem> get completed => filtered.where((t)=>t.completed).toList();
  int get doneCount=>tasks.where((t)=>t.completed).length; int get openCount=>tasks.length-doneCount; double get progress=>tasks.isEmpty?0:doneCount/tasks.length;
  bool _sameDay(DateTime a,DateTime b)=>a.year==b.year&&a.month==b.month&&a.day==b.day;
}

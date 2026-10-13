class TaskItem {
  final int? id;
  final String title, description, notes, category;
  final int priority;
  final DateTime? dueAt, reminderAt;
  final bool completed;
  final DateTime createdAt;
  const TaskItem({this.id, required this.title, this.description = '', this.notes = '', this.category = 'عام', this.priority = 1, this.dueAt, this.reminderAt, this.completed = false, required this.createdAt});
  TaskItem copyWith({int? id, String? title, String? description, String? notes, String? category, int? priority, DateTime? dueAt, DateTime? reminderAt, bool? completed, bool clearDue = false, bool clearReminder = false}) => TaskItem(id:id ?? this.id,title:title ?? this.title,description:description ?? this.description,notes:notes ?? this.notes,category:category ?? this.category,priority:priority ?? this.priority,dueAt:clearDue?null:(dueAt ?? this.dueAt),reminderAt:clearReminder?null:(reminderAt ?? this.reminderAt),completed:completed ?? this.completed,createdAt:createdAt);
  Map<String,Object?> toMap() => {'id':id,'title':title,'description':description,'notes':notes,'category':category,'priority':priority,'due_at':dueAt?.toIso8601String(),'reminder_at':reminderAt?.toIso8601String(),'completed':completed?1:0,'created_at':createdAt.toIso8601String()};
  factory TaskItem.fromMap(Map<String,Object?> m) => TaskItem(id:m['id'] as int?,title:m['title'] as String,description:(m['description'] as String?)??'',notes:(m['notes'] as String?)??'',category:(m['category'] as String?)??'عام',priority:(m['priority'] as int?)??1,dueAt:m['due_at']==null?null:DateTime.parse(m['due_at'] as String),reminderAt:m['reminder_at']==null?null:DateTime.parse(m['reminder_at'] as String),completed:(m['completed'] as int? ?? 0)==1,createdAt:DateTime.parse(m['created_at'] as String));
}

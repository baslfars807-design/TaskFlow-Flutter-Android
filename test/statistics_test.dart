import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/models/task.dart';
void main(){test('completion counts and progress are derived from tasks',(){final tasks=[TaskItem(title:'A',completed:true,createdAt:DateTime(2026)),TaskItem(title:'B',createdAt:DateTime(2026)),TaskItem(title:'C',completed:true,createdAt:DateTime(2026))];final done=tasks.where((t)=>t.completed).length;expect(done,2);expect(tasks.length-done,1);expect(done/tasks.length,closeTo(2/3,0.001));});}

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import '../models/task.dart';

class NotificationService {
  NotificationService._(); static final instance=NotificationService._();
  final FlutterLocalNotificationsPlugin _plugin=FlutterLocalNotificationsPlugin();
  Future<void> initialize() async { tzdata.initializeTimeZones(); const android=AndroidInitializationSettings('@mipmap/ic_launcher'); await _plugin.initialize(const InitializationSettings(android:android)); }
  Future<bool> requestPermission() async { final android=_plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>(); return await android?.requestNotificationsPermission() ?? false; }
  Future<void> schedule(TaskItem task) async { if(task.id==null || task.reminderAt==null || task.completed) return; final at=task.reminderAt!; if(!at.isAfter(DateTime.now())) {await cancel(task.id!);return;} await _plugin.zonedSchedule(task.id!,task.title,task.description.isEmpty?'موعد تذكير المهمة':task.description,tz.TZDateTime.from(at,tz.local),const NotificationDetails(android:AndroidNotificationDetails('task_reminders','تذكيرات المهام',channelDescription:'تذكيرات مهام TaskFlow',importance:Importance.high,priority:Priority.high)),androidScheduleMode:AndroidScheduleMode.inexactAllowWhileIdle,payload:task.id.toString()); }
  Future<void> cancel(int id) async => _plugin.cancel(id);
  Future<void> cancelAll() async => _plugin.cancelAll();
}

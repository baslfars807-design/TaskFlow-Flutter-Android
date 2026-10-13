import 'package:flutter/material.dart';
import 'app.dart';
import 'core/database/app_database.dart';
import 'services/preferences_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;
  await PreferencesService.instance.load();
  await NotificationService.instance.initialize();
  runApp(const TaskFlowApp());
}
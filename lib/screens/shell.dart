import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_store.dart';
import 'home/home_screen.dart';
import 'tasks/tasks_screen.dart';
import 'calendar/calendar_screen.dart';
import 'statistics/statistics_screen.dart';
import 'settings/settings_screen.dart';
import 'tasks/task_editor.dart';

class AppShell extends StatefulWidget {const AppShell({super.key});@override State<AppShell> createState()=>_AppShellState();}
class _AppShellState extends State<AppShell>{int index=0;final pages=const [HomeScreen(),TasksScreen(),CalendarScreen(),StatisticsScreen(),SettingsScreen()];@override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:IndexedStack(index:index,children:pages)),floatingActionButton:index==4?null:FloatingActionButton(onPressed:()=>showTaskEditor(context),child:const Icon(Icons.add_rounded)),bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),destinations:const [NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home_rounded),label:'الرئيسية'),NavigationDestination(icon:Icon(Icons.checklist_rounded),label:'مهامي'),NavigationDestination(icon:Icon(Icons.calendar_month_outlined),label:'التقويم'),NavigationDestination(icon:Icon(Icons.insights_outlined),label:'الإحصائيات'),NavigationDestination(icon:Icon(Icons.settings_outlined),label:'الإعدادات')]));}

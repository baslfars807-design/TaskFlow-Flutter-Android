import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/task_store.dart';
import 'services/preferences_service.dart';
import 'core/theme/app_theme.dart';
import 'screens/shell.dart';

class TaskFlowApp extends StatelessWidget { const TaskFlowApp({super.key}); @override Widget build(BuildContext context)=>MultiProvider(providers:[ChangeNotifierProvider.value(value:PreferencesService.instance),ChangeNotifierProvider(create:(_)=>TaskStore()..load())],child:Consumer<PreferencesService>(builder:(context,p,_)=>MaterialApp(title:'TaskFlow',debugShowCheckedModeBanner:false,theme:AppTheme.light,darkTheme:AppTheme.dark,themeMode:p.themeMode,locale:p.locale,supportedLocales:const [Locale('ar'),Locale('en')],localizationsDelegates:GlobalMaterialLocalizations.delegates, builder:(context,child)=>AnimatedTheme(data:Theme.of(context),duration:const Duration(milliseconds:250),child:Directionality(textDirection:p.locale.languageCode=='ar'?TextDirection.rtl:TextDirection.ltr,child:child??const SizedBox())),home:const AppShell()))); }

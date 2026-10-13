import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  PreferencesService._(); static final instance=PreferencesService._();
  ThemeMode themeMode=ThemeMode.system; Locale locale=const Locale('ar'); bool notificationsEnabled=true; int weekStart=6;
  late SharedPreferences _prefs;
  Future<void> load() async { _prefs=await SharedPreferences.getInstance(); final t=_prefs.getString('theme')??'system'; themeMode=t=='light'?ThemeMode.light:t=='dark'?ThemeMode.dark:ThemeMode.system; locale=Locale(_prefs.getString('locale')??'ar'); notificationsEnabled=_prefs.getBool('notifications')??true; weekStart=_prefs.getInt('weekStart')??6; }
  Future<void> setTheme(ThemeMode v) async {themeMode=v;await _prefs.setString('theme',v.name);notifyListeners();}
  Future<void> setLocale(String v) async {locale=Locale(v);await _prefs.setString('locale',v);notifyListeners();}
  Future<void> setNotifications(bool v) async {notificationsEnabled=v;await _prefs.setBool('notifications',v);notifyListeners();}
  Future<void> setWeekStart(int v) async {weekStart=v;await _prefs.setInt('weekStart',v);notifyListeners();}
}

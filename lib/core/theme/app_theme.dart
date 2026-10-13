import 'package:flutter/material.dart';
class AppTheme {
 static const seed=Color(0xFF5B61D6);
 static ThemeData get light=>ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:seed,brightness:Brightness.light),scaffoldBackgroundColor:const Color(0xFFF7F7FC),cardTheme:CardThemeData(color:Colors.white,elevation:0,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),inputDecorationTheme:InputDecorationTheme(border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none),filled:true,fillColor:const Color(0xFFF0F1F8)));
 static ThemeData get dark=>ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:seed,brightness:Brightness.dark),scaffoldBackgroundColor:const Color(0xFF11121A),cardTheme:CardThemeData(elevation:0,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),inputDecorationTheme:InputDecorationTheme(border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:BorderSide.none),filled:true));
}

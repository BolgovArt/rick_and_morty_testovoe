import 'package:flutter/material.dart';

class AppTheme {
    static final light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.lightGreen.shade800, // Основной цвет (включая AppBar)
      onPrimary: Colors.black, // Цвет текста/иконок на primary
      surface: Colors.lime.shade50,   // Фон Scaffold
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.lime.shade100
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.lime.shade100
    )
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.cyan,
      onPrimary: Colors.white,
      surface: Colors.grey.shade800,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade900
    )
  );
}


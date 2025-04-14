import 'package:flutter/material.dart';

class AppTheme {
    static final light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.lightGreen.shade800, // Основной цвет (включая AppBar)
      onPrimary: Colors.black, // Цвет текста/иконок на primary
      surface: Colors.lime.shade100,   // Фон Scaffold
      primaryContainer: Colors.lime.shade50,
      secondary: Colors.pink,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.lime.shade200
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.lime.shade200
    )
  );

  static final dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.cyan,
      onPrimary: Colors.white,
      surface: Colors.grey.shade800,
      primaryContainer: const Color.fromARGB(255, 39, 48, 48),
      secondary: Colors.tealAccent
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade900
    )
  );
}


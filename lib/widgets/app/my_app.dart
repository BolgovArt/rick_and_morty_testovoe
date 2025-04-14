import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final Widget home;
  const MyApp({super.key, required this.theme, required this.home});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = context.watch<ThemeProvider>(); //! вариант 3
    return MaterialApp(
      theme: theme,
      // theme: themeProvider, //! вариант 3
      home: home,
    );
  }
}
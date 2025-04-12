import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/ui/theme/theme_provider.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/main_screen_widget.dart';

// а вот без GetIt MyApp был stl и норм работал
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

final ThemeProvider _themeProvider = getIt<ThemeProvider>();

  @override
  void initState() {
    super.initState();
    _themeProvider.addListener(_updateTheme);
  }

  @override
  void dispose() {
    _themeProvider.removeListener(_updateTheme);
    super.dispose();
  }

  void _updateTheme() => setState(() {});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: _themeProvider.theme,
        home: const MainScreenWidget(),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/ui/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  ThemeData _theme;

  static const _themeKey = 'is_dark';

  ThemeProvider(this._prefs) : _theme = _prefs.getBool(_themeKey) ?? false 
      ? AppTheme.dark 
      : AppTheme.light;

  ThemeData get theme => _theme;

  void toggleTheme() {
    _theme = _theme == AppTheme.dark 
        ? AppTheme.light 
        : AppTheme.dark;
        
    _prefs.setBool(_themeKey, _theme == AppTheme.dark);
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/ui/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  ThemeData _theme;

  static const _themeKey = 'is_dark';

  ThemeProvider(this.sharedPreferences) : _theme = sharedPreferences.getBool(_themeKey) ?? false 
      ? AppTheme.dark 
      : AppTheme.light;

  ThemeData get theme => _theme;

  void toggleTheme() { // при любом вызове toggleTheme() будет перерисовываться весь myApp (капитан очевидность). 
  // Если появятся новые поля с notifylisteners() весь myApp тоже перерисуется, тут надо быть осторожным 
  // ИЛИ использовать в варианте 1 файла service_locator.dart вместо context.watch<ThemeProvider>() использовать
  
  // final currentTheme = context.select<ThemeProvider, ThemeData>( 
  //  (themeProvider) => themeProvider.theme
  // );
  // return MyApp(theme: currentTheme);

//  гипотетическая проблема с новыми notifylisteners() полями:

//  double _fontSize = 14;
//  
//  void increaseFontSize() {
//    _fontSize += 1;
//    notifyListeners(); // Вызов уведомления
//  }

// Этот код к ThemeData не имеет никакого отношение, но весь MyApp перерисует

    _theme = _theme == AppTheme.dark 
        ? AppTheme.light 
        : AppTheme.dark;
        
    sharedPreferences.setBool(_themeKey, _theme == AppTheme.dark);
    notifyListeners();
  }
}
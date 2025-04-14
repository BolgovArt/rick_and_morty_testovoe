import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/theme_provider.dart';

class MainScreenModel extends ChangeNotifier{ //! или миксину with ????
  final ThemeProvider themeProvider;
  final ScreenFactory screenFactory;
  
  int _currentTabIndex = 0;

  MainScreenModel({
    required this.screenFactory, 
    required this.themeProvider
  });

  int get currentTabIndex => _currentTabIndex;
  
  void onSelectTab(int index) {
    if (_currentTabIndex == index) return; // не будем обновлять state, если вкладка уже выбрана
      _currentTabIndex = index;
      notifyListeners();
  }

  void toggleTheme() {
    themeProvider.toggleTheme();
  }
}
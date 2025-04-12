import 'package:flutter/material.dart';

class MainScreenModel extends ChangeNotifier{ // или миксину with ????
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;
  void onSelectTab(int index) {
    if (_currentTabIndex == index) return; // не будем обновлять state, если вкладка уже выбрана
      _currentTabIndex = index;
      notifyListeners();
  }
}
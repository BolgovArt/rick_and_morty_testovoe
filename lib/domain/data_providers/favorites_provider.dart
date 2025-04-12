
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// lib/providers/favorites_provider.dart
// FavoritesProvider отвечает за управление списком избранных персонажей.
// Избранные сохраняются в SharedPreferences в виде списка JSON-строк.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  final String favoritesKey = 'favorites';

  FavoritesProvider({required this.sharedPreferences}) {
    loadFavorites(); // Загружаем избранное при инициализации.
  }

  List<Character> _favorites = [];
  List<Character> get favorites => _favorites;

  // Загружаем избранные персонажи из SharedPreferences
  void loadFavorites() {
    final List<String>? jsonList = sharedPreferences.getStringList(favoritesKey);
    if (jsonList != null) {
      _favorites = jsonList
          .map((jsonStr) => Character.fromJson(json.decode(jsonStr)))
          .toList();
      notifyListeners();
    }
  }

  // Сохранение списка избранных в SharedPreferences
  Future<void> _saveFavorites() async {
    final List<String> jsonList =
        _favorites.map((character) => json.encode(character.toJson())).toList();
    await sharedPreferences.setStringList(favoritesKey, jsonList);
  }

  // Добавление персонажа в избранное
  Future<void> addFavorite(Character character) async {
    if (!_favorites.any((c) => c.id == character.id)) {
      _favorites.add(character);
      await _saveFavorites();
      notifyListeners();
    }
  }

  // Удаление персонажа из избранного
  Future<void> removeFavorite(Character character) async {
    _favorites.removeWhere((c) => c.id == character.id);
    await _saveFavorites();
    notifyListeners();
  }

  // Проверка, находится ли персонаж в избранном
  bool isFavorite(Character character) {
    return _favorites.any((c) => c.id == character.id);
  }
}
import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';

class FavoriteListModel extends ChangeNotifier{
  final FavoritesProvider _favoritesProvider; 
  List<Character> get favorites => _favoritesProvider.favorites;

  FavoriteListModel(this._favoritesProvider);

  void removeFavorite(Character character) {
    _favoritesProvider.removeFavorite(character);
    notifyListeners();
  }

  List<Character> sortedFavorites() {
    final sortedList = List<Character>.from(favorites); // создает новый список на основе существующего, чтобы не изменять оригинальный список: favorites  - исходный список избранных персонажей 
    sortedList.sort((a, b) => a.name.compareTo(b.name)); // .sort возвращает void, поэтому сортируем на месте
    return sortedList; // и выдаем его
  }
}
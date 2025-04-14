import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';
import 'package:rick_and_morty_testovoe/domain/services/storage_service.dart';
import '../services/api_service.dart';

class CharacterProvider with ChangeNotifier {
  final ApiService apiService;
  final StorageService storageService;

  CharacterProvider({required this.apiService, required this.storageService}) {
    loadCharactersFromStorage(); // Загружаем данные из кэша при инициализации.
    loadNextPage(); // Загружаем первую страницу с API.
  }

  List<Character> _characters = [];
  int _currentPage = 1;
  bool _isLoadingInProgress = false;

  List<Character> get characters => _characters;
  bool get isLoadingProgress => _isLoadingInProgress;

  // Загружаем персонажей из кэша, если они уже сохранены.
  void loadCharactersFromStorage() {
    final storage = storageService.getCachedCharacters();
    if (storage.isNotEmpty) {
      _characters = storage;
      notifyListeners();
    }
  }

  // Загружаем следующую страницу с API (с пагинацией)
  Future<void> loadNextPage() async {
    if (_isLoadingInProgress) return; // !
    _isLoadingInProgress = true;
    notifyListeners(); // !
    try {
      final newCharacters = await apiService.fetchCharacters(_currentPage);
      _characters.addAll(newCharacters);
      // Кэширование полученных данных
      await storageService.cacheCharacters(_characters);
      _currentPage++;
    } catch (e) {
      // Обработка ошибки (можно добавить вывод ошибки пользователю)
      debugPrint(e.toString()); // !
    }
    _isLoadingInProgress = false;
    notifyListeners();
  }

  // Обновление данных (pull-to-refresh)
  Future<void> reset() async {
    _characters.clear();
    _currentPage = 1;
    await loadNextPage();
  }
}

// character_provider.dart отвечает за получение списка персонажей с API с поддержкой пагинации,
// а также за кэширование полученных данных для оффлайн-режима.
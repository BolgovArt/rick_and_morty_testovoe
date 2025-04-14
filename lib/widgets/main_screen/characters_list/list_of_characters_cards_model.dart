import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/character_provider.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';

class ListOfCharactersCardsModel extends ChangeNotifier {
  final CharacterProvider characterProvider;
  final FavoritesProvider favoritesProvider;
  final ScrollController scrollController = ScrollController();

  ListOfCharactersCardsModel({
    required this.characterProvider,
    required this.favoritesProvider,
  }) {
    _init();
  }

  bool get isLoadingProgress => characterProvider.isLoadingProgress;
  //
  List<Character> get characters => characterProvider.characters;
  //
  bool isFavorite(Character character) => favoritesProvider.isFavorite(character);

  void _init() {
    scrollController.addListener(_handleScroll);
    if (characterProvider.characters.isEmpty) {
      characterProvider.loadNextPage();
    }
  }
// 
  void toggleFavorite(Character character) {
    isFavorite(character)
        ? favoritesProvider.removeFavorite(character)
        : favoritesProvider.addFavorite(character);
    
    notifyListeners();
  }

  void _handleScroll() {
    if (_shouldLoadNextPage) {
      characterProvider.loadNextPage();
    }
  }

  bool get _shouldLoadNextPage =>
      scrollController.position.pixels == scrollController.position.maxScrollExtent &&
      !isLoadingProgress;

  @override
  void dispose() {
    scrollController
      ..removeListener(_handleScroll)
      ..dispose();
    super.dispose();
  }
}
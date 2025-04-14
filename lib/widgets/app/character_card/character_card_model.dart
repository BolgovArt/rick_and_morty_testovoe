// import 'package:flutter/material.dart';
// import 'package:rick_and_morty_testovoe/domain/data_providers/character_provider.dart';
// import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
// import 'package:rick_and_morty_testovoe/domain/entity/character.dart';

// class CharacterCardModel extends ChangeNotifier{
//   final CharacterProvider _characterProvider;
//   final FavoritesProvider _favoritesProvider;

//   CharacterCardModel({
//     required CharacterProvider characterProvider, 
//     required FavoritesProvider favoritesProvider
//     }) : _characterProvider = characterProvider, // !
//     _favoritesProvider = favoritesProvider; 




//   List<Character> get characters => _characterProvider.characters;
//   List<Character> get favorites => _favoritesProvider.favorites;

//      bool isFavorite(Character character) => _favoritesProvider.isFavorite(character);

//        void toggleFavorite(Character character) {
//     isFavorite(character)
//         ? _favoritesProvider.removeFavorite(character)
//         : _favoritesProvider.addFavorite(character);
    
//     notifyListeners();
//   }



//       void removeFavorite(Character character) {
//     _favoritesProvider.removeFavorite(character);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/character_provider.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/character_card.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/characters_list/list_of_characters_cards_model.dart';

class ListOfCharacterCardsWidget extends StatefulWidget {
  const ListOfCharacterCardsWidget({super.key});

  @override
  State<ListOfCharacterCardsWidget> createState() => _ListOfCharactersState();
}

class _ListOfCharactersState extends State<ListOfCharacterCardsWidget> {

  final CharacterProvider _characterProvider = getIt<CharacterProvider>();
  final FavoritesProvider _favoritesProvider = getIt<FavoritesProvider>();
  final ListOfCharactersCardsModel _model = getIt<ListOfCharactersCardsModel>();
  @override
  void initState() {
    super.initState();
    _characterProvider.addListener(_updateUI);
    _favoritesProvider.addListener(_updateUI);
    _model.addListener(_updateUI);
  }

  @override
  void dispose() {
    _characterProvider.removeListener(_updateUI);
    _favoritesProvider.removeListener(_updateUI);
    _model.removeListener(_updateUI);
    super.dispose();
  }

  void _updateUI() => setState(() {});


  @override
  Widget build(BuildContext context) {
        // final characterProvider = getIt<CharacterProvider>();
        // final favoritesProvider = getIt<FavoritesProvider>();
        // final model = getIt<ListOfCharactersCardsModel>();
    return ListView.builder(
      
        controller: _model.scrollController,
        itemCount: _characterProvider.characters.length +
            (_characterProvider.isLoadingProgress ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _characterProvider.characters.length) {
            final Character character = _characterProvider.characters[index];
            final bool isFav = _favoritesProvider.isFavorite(character);
            return CharacterCard(
              character: character,
              isFavorite: isFav,
              onFavoriteToggle: () {
                // При нажатии переключается состояние избранного через провайдер
                if (isFav) {
                  _favoritesProvider.removeFavorite(character);
                } else {
                  _favoritesProvider.addFavorite(character);
                }
              },
            );
          } else {
            // Индикатор загрузки при дозагрузке данных
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
    );
  }
}
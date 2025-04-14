import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/character_card.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/favorites_list/favorite_list_model.dart';

class FavoriteListWidget extends StatelessWidget {
  const FavoriteListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<FavoriteListModel>();
    final _sortedFavorites = model.sortedFavorites();
    return _sortedFavorites.isEmpty
        ? const Center(child: Text('Нет избранных персонажей'))
        : ListView.builder(
            itemCount: _sortedFavorites.length,
            itemBuilder: (context, index) {
              final character = _sortedFavorites[index];
              return CharacterCard(
                character: character,
                isFavorite: true,
                onFavoriteToggle: () {
                  model.removeFavorite(character);
                },
              );
            },
          );
  }
}
import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/character_card.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/favorites_list/favorite_list_model.dart';

class FavoriteListWidget extends StatefulWidget {
  const FavoriteListWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteListWidget> createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<FavoriteListWidget> {

  // final CharacterProvider _characterProvider = getIt<CharacterProvider>();
  // final FavoritesProvider _favoritesProvider = getIt<FavoritesProvider>();
  final FavoriteListModel _model = getIt<FavoriteListModel>();
  @override
  void initState() {
    super.initState();
    // _characterProvider.addListener(_updateUI);
    // _favoritesProvider.addListener(_updateUI);
    _model.addListener(_updateUI);
    getIt<FavoritesProvider>().addListener(_updateUI);
  }

  @override
  void dispose() {
    // _characterProvider.addListener(_updateUI);
    // _favoritesProvider.addListener(_updateUI);
    _model.addListener(_updateUI);
    getIt<FavoritesProvider>().removeListener(_updateUI);
    super.dispose();
  }

  void _updateUI() => setState(() {});

  
  @override
  Widget build(BuildContext context) {
    // final model = getIt<FavoriteListModel>();
    final _sortedFavorites = _model.sortedFavorites();
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
                  _model.removeFavorite(character);
                },
              );
            },
          );
  }
}
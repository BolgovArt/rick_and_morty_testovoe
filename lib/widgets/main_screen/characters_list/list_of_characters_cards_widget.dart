import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';
import 'package:rick_and_morty_testovoe/widgets/app/character_card/character_card_widget.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/characters_list/list_of_characters_cards_model.dart';

class ListOfCharacterCardsWidget extends StatefulWidget {
  const ListOfCharacterCardsWidget({super.key});

  @override
  State<ListOfCharacterCardsWidget> createState() => _ListOfCharacterCardsWidgetState();
}

class _ListOfCharacterCardsWidgetState extends State<ListOfCharacterCardsWidget> {
  @override
  Widget build(BuildContext context) {
        final model = context.watch<ListOfCharactersCardsModel>();
    return ListView.builder(
        controller: model.scrollController,
        itemCount: model.characters.length +
            (model.isLoadingProgress ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < model.characters.length) {
            final Character character = model.characters[index];
            // final bool isFav = model.favoritesProvider.isFavorite(character);
            return CharacterCard(
              character: character,
              isFavorite: model.isFavorite(character),
              onFavoriteToggle: () => model.toggleFavorite(character),
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
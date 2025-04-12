import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/character_provider.dart';

class ListOfCharactersCardsModel extends ChangeNotifier{
  final ScrollController _scrollController = ScrollController();
  final CharacterProvider provider;

  get scrollController => _scrollController;

  ListOfCharactersCardsModel({required this.provider}) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0 &&
          !provider.isLoadingProgress) {
        provider.loadNextPage();
      }
    });

    if (provider.characters.isEmpty) {
      provider.loadNextPage();
    }
  }

  // void dispose() {
  //   _scrollController.dispose();
  // }
}


//     @override
//   void initState() {
//     super.initState();
//     // Отложенная настройка слушателя, когда провайдер уже инициализирован // Настраиваем scroll listener для дозагрузки
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<CharacterProvider>(context, listen: false);
//       _setupScrollListener(provider);
//       // Если список пуст, выполняем начальную загрузку
//       if (provider.characters.isEmpty) {
//         provider.loadNextPage();
//       }
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/character_provider.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
import 'package:rick_and_morty_testovoe/domain/services/api_service.dart';
import 'package:rick_and_morty_testovoe/domain/services/storage_service.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/theme_provider.dart';
import 'package:rick_and_morty_testovoe/widgets/app/my_app.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/characters_list/list_of_characters_cards_model.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/characters_list/list_of_characters_cards_widget.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/favorites_list/favorite_list_model.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/favorites_list/favorite_list_widget.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/main_screen_model.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/main_screen_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Контейнер зависимостей для UI.
/// Принимает внешние зависимости (SharedPreferences, StorageService, ApiService)
/// и на их основе создаёт внутренние объекты:
/// - ThemeProvider: для управления темой,
/// - CharacterProvider: для работы с персонажами,
/// - FavoritesProvider: для работы с избранным.
class _DiContainer {
  final SharedPreferences sharedPreferences;
  final StorageService storageService;
  final ApiService apiService;
  ScreenFactory get screenFactory => ScreenFactoryDefault(this);

  final ThemeProvider themeProvider;
  final CharacterProvider characterProvider;
  final FavoritesProvider favoritesProvider;

  _DiContainer({
    required this.sharedPreferences,
    required this.storageService,
    required this.apiService,
  })  : themeProvider = ThemeProvider(sharedPreferences),
        characterProvider = CharacterProvider(
          apiService: apiService,
          storageService: storageService,
        ),
        favoritesProvider = FavoritesProvider(sharedPreferences: sharedPreferences);

  MainScreenModel makeMainScreenModel() => MainScreenModel(
    themeProvider: themeProvider,
    screenFactory: screenFactory
  );

  ListOfCharactersCardsModel makeListOfCharactersCardsModel() =>
      ListOfCharactersCardsModel(characterProvider: characterProvider, favoritesProvider: favoritesProvider);

  FavoriteListModel makeFavoriteListModel() =>
      FavoriteListModel(favoritesProvider);
}


abstract class AppFactory {
  Widget makeApp();
}


class AppFactoryDefault implements AppFactory {
  final _DiContainer _diContainer;
  final ScreenFactory _screenFactory;

  AppFactoryDefault(this._diContainer)
      : _screenFactory = ScreenFactoryDefault(_diContainer);

  @override
  Widget makeApp() {
      return ChangeNotifierProvider.value( // для доступа themeProvider'у всем виджетам ниже по дереву. | .value используется - 1. когда объект уже создан где-то (у нвас в DI контейнере), 2. Должен сохраняться между перестроениями виджетов, 3. Не должен создаваться заново каждый раз
        value: _diContainer.themeProvider,
        // ----------- вариант 1 ------------
        child: Builder(
          builder: (context) {
            final themeProvider = context.watch<ThemeProvider>(); // Любой вызов context.watch<>() внутри build автоматически подписывает виджет на изменения провайдера по notifylisteners()
            return MyApp(
              theme: themeProvider.theme,
              home: _screenFactory.makeMainScreenWidget(),
            );
          }
          ),
        // ----------- вариант 2 ------------ принцип один и тот же, дело вкуса 
        // child: Consumer<ThemeProvider>(
        //   builder: (context, themeProvider, _) {
        //     return MyApp(
        //       theme: _diContainer.themeProvider.theme,
        //       home: _screenFactory.makeMainScreenWidget(),
        //     );
        //   }
        //   ),
        // -----------------------------------
      );
  }
}


abstract class ScreenFactory {
  Widget makeMainScreenWidget();
  Widget makeListOfCharactersCardsWidget();
  Widget makeFavoriteListWidget();
}


class ScreenFactoryDefault implements ScreenFactory {
  final _DiContainer _diContainer;
  ScreenFactoryDefault(this._diContainer);

  @override
  Widget makeMainScreenWidget() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer.makeMainScreenModel(),
      child:  MainScreenWidget(screenFactory: this),
    );
  }

  @override
  Widget makeListOfCharactersCardsWidget() {
    return ChangeNotifierProvider(
        create: (_) => _diContainer.makeListOfCharactersCardsModel(),
        child: ListOfCharacterCardsWidget(),
      );
  }

  @override
  Widget makeFavoriteListWidget() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer.makeFavoriteListModel(),
      child: const FavoriteListWidget(),
    );
  }

}


AppFactory makeAppFactory({
  required SharedPreferences sharedPreferences,
  required StorageService storageService,
  required ApiService apiService,
}) {
  final diContainer = _DiContainer(
    sharedPreferences: sharedPreferences,
    storageService: storageService,
    apiService: apiService,
  );
  return AppFactoryDefault(diContainer);
}
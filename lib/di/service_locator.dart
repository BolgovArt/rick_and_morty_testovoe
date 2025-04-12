import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/character_provider.dart';
import 'package:rick_and_morty_testovoe/domain/data_providers/favorites_provider.dart';
import 'package:rick_and_morty_testovoe/domain/services/api_service.dart';
import 'package:rick_and_morty_testovoe/domain/services/storage_service.dart';
import 'package:rick_and_morty_testovoe/ui/theme/theme_provider.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/characters_list/list_of_characters_cards_model.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/favorites_list/favorite_list_model.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/main_screen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // 1. Инициализируем SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // 2. Регистрируем "тяжелые" сервисы (создаются один раз)
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<StorageService>(
    () => StorageService(sharedPreferences: getIt())
  );
  getIt.registerLazySingleton<ThemeProvider>( // или registerFactory
    () => ThemeProvider(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  

  // 3. Регистрируем провайдеры (могут пересоздаваться)
  getIt.registerLazySingleton<CharacterProvider>(  // было registerFactory
    () => CharacterProvider(
      apiService: getIt(),
      storageService: getIt(),
    )
  );
  
  getIt.registerLazySingleton<FavoritesProvider>( // было registerFactory
    () => FavoritesProvider(
    sharedPreferences: getIt<SharedPreferences>(), // Явно передаем параметр
  ),
  );

  getIt.registerFactory<MainScreenModel>(
    () => MainScreenModel(),
  );

  getIt.registerFactory<ListOfCharactersCardsModel>( 
    () => ListOfCharactersCardsModel(
      provider: getIt<CharacterProvider>(), // Зависимость из GetIt
    ),
  );

  getIt.registerFactory<FavoriteListModel>( 
    () => FavoriteListModel(
      getIt<FavoritesProvider>(), // Зависимость из GetIt
    ),
  );
}
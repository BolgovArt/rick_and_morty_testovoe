import 'dart:convert';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences sharedPreferences;
  final String charactersKey = 'cached_characters';

  StorageService({required this.sharedPreferences});

  // Сохраняем список персонажей в SharedPreferences в виде JSON-строки.
  Future<void> cacheCharacters(List<Character> characters) async {
    final List<String> jsonList =
        characters.map((character) => json.encode(character.toJson())).toList();
    await sharedPreferences.setStringList(charactersKey, jsonList);
  }

  // Достаем эту JSON-строку и раскручиваем ее
  List<Character> getCachedCharacters() {
    final List<String>? jsonList = sharedPreferences.getStringList(charactersKey);
    if (jsonList != null) {
      return jsonList
          .map((jsonStr) => Character.fromJson(json.decode(jsonStr)))
          .toList();
    }
    return [];
  }
}


//? СТРОЧКА 15. А для чего при записи в хранилище нам данные обратно в JSON загонять?
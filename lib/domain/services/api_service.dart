import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_testovoe/configuration/configutarion.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';

class ApiService {
  Future<List<Character>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('${Configutarion.baseUrl}/character?page=$page'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Парсинг JSON и создание списка объектов Character
      final List<dynamic> results = data['results']; // обращение к значению по ключу 'results' в data
      return results.map((e) => Character.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка загрузки персонажей');
    }
  }
}
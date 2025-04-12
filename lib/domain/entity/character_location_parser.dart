// Функция для извлечения имени локации из JSON.
// Если json является Map, возвращается значение поля 'name'.
// Если json уже строка, возвращаем её как есть.
String locationFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return json['name'] as String;
  } else if (json is String) {
    return json;
  }
  return '';
}

// Функция для сериализации поля location (просто возвращаем строку).
dynamic locationToJson(String location) => location;
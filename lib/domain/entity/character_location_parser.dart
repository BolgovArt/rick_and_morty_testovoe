String locationFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return json['name'] as String;
  } else if (json is String) {
    return json;
  }
  return '';
}

dynamic locationToJson(String location) => location;
import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character_location_parser.dart';

part 'character.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  @JsonKey(fromJson: locationFromJson, toJson: locationToJson)
  final String location;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.location,
  });

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
  
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

}
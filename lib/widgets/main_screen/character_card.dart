import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/domain/entity/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        leading: Image.network(
          character.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(character.name),
        subtitle: Text('Статус: ${character.status}\n'
            'Вид: ${character.species}\n'
            'Локация: ${character.location}'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: Colors.yellow[700],
          ),
          onPressed: onFavoriteToggle, // Вызываем callback при смене избранного
        ),
      ),
    );
  }
}
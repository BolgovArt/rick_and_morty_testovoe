import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/main_screen_model.dart';

class MainScreenWidget extends StatelessWidget {
  final ScreenFactory screenFactory;
  const MainScreenWidget({super.key, required this.screenFactory});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестовое задание: "Список \nперсонажей Рика и Морти"', style: TextStyle(fontSize: 14)),
        actions: [
          Padding(
          padding:  EdgeInsets.only(right: 16),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: model.toggleTheme,
                icon: Icon(Icons.color_lens, size: 25),
                label: Text('Сменить тему'),
                ),
            ],
          )
          )
        ],
      ),
      body: Container(
        child: model.currentTabIndex == 0 
          ? screenFactory.makeListOfCharactersCardsWidget()
          : screenFactory.makeFavoriteListWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: model.currentTabIndex,
        onTap: model.onSelectTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list_outlined), 
            label: 'Список персонажей', 
            activeIcon: Icon(Icons.view_list)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border), 
            label: 'Избранное', 
            activeIcon: Icon(Icons.star)
          ),
        ]
      ),
    );
  }
}





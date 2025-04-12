import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/ui/theme/theme_provider.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/characters_list/list_of_characters_cards_widget.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/favorites_list/favorite_list_widget.dart';
import 'package:rick_and_morty_testovoe/widgets/main_screen/main_screen_model.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {

// приколы пакета GetIt? Теряется контекст, переотрисовку стейта по контексту через инхериты (старый метод через Provider) не сделать - экраны рабочие, но обездвижены
  final MainScreenModel _model = getIt<MainScreenModel>();
  final ThemeProvider _themeProvider = getIt<ThemeProvider>();
  @override
  void initState() {
    super.initState();
    _model.addListener(_updateUI);
    _themeProvider.addListener(_updateUI);
  }

  @override
  void dispose() {
    _model.removeListener(_updateUI);
    _themeProvider.removeListener(_updateUI);
    super.dispose();
  }

  void _updateUI() => setState(() {});

  
  @override
  Widget build(BuildContext context) {
    // final themeProvider = getIt<ThemeProvider>();
    // final model = getIt<MainScreenModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестовое задание: "Список \nперсонажей Рика и Морти"', style: TextStyle(fontSize: 14)),
        actions: [
          Padding(
          padding:  EdgeInsets.only(right: 16),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: _themeProvider.toggleTheme,
                icon: Icon(Icons.color_lens, size: 25),
                label: Text('Сменить тему'),
                ),
            ],
          )
          )
        ],
      ),
      body: Container(
        child: IndexedStack(
          index: _model.currentTabIndex,
          children: [
            ListOfCharacterCardsWidget(),
            FavoriteListWidget(),
          ]
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _model.currentTabIndex,
        onTap: _model.onSelectTab,
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





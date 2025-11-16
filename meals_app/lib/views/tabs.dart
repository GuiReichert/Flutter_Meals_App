import 'package:flutter/material.dart';
import 'package:meals_app/views/categories_screen.dart';
import 'package:meals_app/views/meals_screen.dart';

enum TabScreens { categories, favorites }

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  Widget _activePage = CategoriesScreen();
  int _selectedPageIndex = 0;

  void _selectPage(TabScreens selectedPage) {
    setState(() {
      switch (selectedPage) {
        case TabScreens.categories:
          _activePage = CategoriesScreen();
          _selectedPageIndex = TabScreens.categories.index;
          break;

        case TabScreens.favorites:
          _activePage = MealsScreen(title: 'Your favorites', meals: []);
          _selectedPageIndex = TabScreens.favorites.index;
          break;

        // ignore: unreachable_switch_default
        default:
          _activePage = CategoriesScreen();
          _selectedPageIndex = TabScreens.categories.index;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(TabScreens.values[index]);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

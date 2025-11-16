import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/views/categories_screen.dart';
import 'package:meals_app/views/meals_screen.dart';

enum TabScreens { categories, favorites }

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  TabScreens _selectedPage = TabScreens.categories;
  final List<MealModel> _favoriteMeals = [];

  Widget get _activePage {
    switch (_selectedPage) {
      case TabScreens.categories:
        return CategoriesScreen(onToggleFavorite: _addDeleteFavoriteMeal);
      case TabScreens.favorites:
        return MealsScreen(
          title: 'Your Favorites',
          meals: _favoriteMeals,
          onToggleFavorite: _addDeleteFavoriteMeal,
        );
      // ignore: unreachable_switch_default
      default:
        return CategoriesScreen(onToggleFavorite: _addDeleteFavoriteMeal);
    }
  }

  void _addDeleteFavoriteMeal(MealModel meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  void _selectPage(TabScreens selectedPage) {
    setState(() {
      _selectedPage = selectedPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage.index,
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

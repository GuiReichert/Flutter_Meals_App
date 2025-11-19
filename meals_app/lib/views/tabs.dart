import 'package:flutter/material.dart';
import 'package:meals_app/CustomWidgets/main_drawer.dart';
import 'package:meals_app/DummyData/dummy_data.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/views/categories_screen.dart';
import 'package:meals_app/views/filters_screen.dart';
import 'package:meals_app/views/meals_screen.dart';

const Map<FiltersEnum, bool> kInitialFilters = {
  FiltersEnum.glutenFree: false,
  FiltersEnum.lactoseFree: false,
  FiltersEnum.vegetarian: false,
  FiltersEnum.vegan: false,
};

enum TabScreens { categories, favorites }

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  TabScreens _selectedPage = TabScreens.categories;
  final List<MealModel> _favoriteMeals = [];
  Map<FiltersEnum, bool> _selectedfilters = kInitialFilters;
  List<MealModel> _filteredMeals = availableMeals;

  Widget get _activePage {
    switch (_selectedPage) {
      case TabScreens.categories:
        return CategoriesScreen(
          onToggleFavorite: _addDeleteFavoriteMeal,
          filteredMeals: _filteredMeals,
        );
      case TabScreens.favorites:
        return MealsScreen(
          title: 'Your Favorites',
          meals: _favoriteMeals,
          onToggleFavorite: _addDeleteFavoriteMeal,
        );
      // ignore: unreachable_switch_default
      default:
        return CategoriesScreen(
          onToggleFavorite: _addDeleteFavoriteMeal,
          filteredMeals: _filteredMeals,
        );
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

  void _setDrawerScreen(String identifier) async {
    Navigator.pop(context); // Dá pop no drawer
    if (identifier == 'Filters') {
      final filters = await Navigator.push<Map<FiltersEnum, bool>>(
        context,
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedfilters,
          ),
        ),

        // Navigator.pushReplacement() substitui a tela. Isso faz com que, quando o usuário clique no 'Back' button, o aplicativo feche
      );

      setState(() {
        _selectedfilters = filters ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _filteredMeals = availableMeals.where((x) {
      if (_selectedfilters[FiltersEnum.glutenFree]! && !x.isGlutenFree) {
        return false;
      }
      if (_selectedfilters[FiltersEnum.lactoseFree]! && !x.isLactoseFree) {
        return false;
      }
      if (_selectedfilters[FiltersEnum.vegetarian]! && !x.isVegetarian) {
        return false;
      }
      if (_selectedfilters[FiltersEnum.vegan]! && !x.isVegan) {
        return false;
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(onSelectScreen: _setDrawerScreen),
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

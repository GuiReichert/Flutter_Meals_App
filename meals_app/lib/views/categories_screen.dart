import 'package:flutter/material.dart';
import 'package:meals_app/CustomWidgets/category_grid_item.dart';
import 'package:meals_app/DummyData/dummy_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/views/meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});

  final void Function(MealModel meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your category'),
      ),
      body: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final cat in availableCategories)
            CategoryGridItem(
              category: cat,
              onSelectCategory: () {
                _selectCategory(context, cat);
              },
            ),
        ],
      ),
    );
  }

  void _selectCategory(context, CategoryModel category) {
    final filteredMeals = availableMeals.where(
      (meal) => meal.categories.contains(category.id),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.name,
          meals: filteredMeals.toList(),
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }
}

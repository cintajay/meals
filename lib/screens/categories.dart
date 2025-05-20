import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _categorySelected(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((meal) { //map seems to return List<Meal?>
          return meal.categories.contains(category.id);
        }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(meals: filteredMeals, title: category.title,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        children: [
          for (final item in availableCategories)
            CategoryGridItem(
              category: item,
              onSelectCategory: () {
                _categorySelected(context, item);
              },
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //only variables updated through setState is set here, the rest is moved to build method
  var _currentIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _setScreen(String screen) async { 
    Navigator.pop(context);
    if (screen == 'filters') {
      await Navigator.push<Map<Filters, bool>>(context, MaterialPageRoute(
        builder: (ctx) => const FiltersScreen()
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);

    var currentTitle = "Categories";
    List<Meal> availableMeals = dummyMeals.where((meal) {
      if (!meal.isGlutenFree && activeFilters[Filters.glutenFree]! || !meal.isLactoseFree && activeFilters[Filters.lactoseFree]! || 
      !meal.isVegetarian && activeFilters[Filters.vegetarian]! || !meal.isVegan && activeFilters[Filters.vegan]!) {
        return false;
      }
      return true;
    }).toList();        
    Widget content = CategoriesScreen(availableMeals: availableMeals);

    if (_currentIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      content = MealsScreen(meals: favoriteMeals);
      currentTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle),
      ),
      drawer: MainDrawer(onDrawerItemClick: _setScreen),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories',),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites',)
        ]
      ),
    );
  }
}
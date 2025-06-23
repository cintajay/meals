import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _categorySelected(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals.where((meal) { //map seems to return List<Meal?>
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
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => SlideTransition( // SlideTransition func executes 60 times per second to show animation
        //can add a custom animation instead of SlideTransition by using _animationController.value(its value changes btw the bounds) to change say the padding value
        //Eg: EdgeInsets.only(top: 100 - _animationController.value*100)
          position: Tween( //or _animationController.drive(), Tween is a predefined animatable child
            begin: Offset(0, 0.3),
            end: Offset(0, 0),
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          )),
          child: child,
        ),
        child: GridView( //this child is passed to the builder to improve performance so that not all parts of this widget is rebuild
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
      )
    );
  }
}
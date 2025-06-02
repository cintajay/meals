import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]); //super to reach out to the parent class, we pass an empty list to the parent class, the empty list is actually a List<Meal>

  toggleMealFavoriteStatus(Meal meal) { //methods to change the list (.add, .remove is not allowed, list should only be replaced)
    final mealIsFavorite = state.contains(meal); //globally available state property holds the list

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList(); //state is reassigned, not edited
    } else {
      state = [...state, meal]; //state is reassigned, not edited
    }
  } 
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) { //StateNotifierProvider - optimised for data that can change
  return FavoriteMealsNotifier();
});
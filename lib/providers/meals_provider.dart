import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealsProvider = Provider((ref) { //Provider - to return static data that never changes
  return dummyMeals;
});
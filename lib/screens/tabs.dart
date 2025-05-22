import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  Widget _content = CategoriesScreen();
  var _currentIndex = 0;
  var _currentTitle = "Categories";

  void _tabClick(index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        _content = CategoriesScreen();
        _currentTitle = "Categories";
      } else if (index == 1) {
        _content = MealsScreen(meals: []);
        _currentTitle = "Your Favourites";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTitle),
      ),
      drawer: MainDrawer(),
      body: _content,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _tabClick(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories',),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites',)
        ]
      ),
    );
  }
}
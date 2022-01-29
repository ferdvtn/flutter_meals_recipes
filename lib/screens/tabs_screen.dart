import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(this.favoritesMeal, {Key? key}) : super(key: key);

  final List<Meal> favoritesMeal;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late int _currentState;
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _currentState = 0;
    _pages = [
      {
        'title': 'Category',
        'page': const CategoriesScreen(),
      },
      {
        'title': 'My Favorites',
        'page': FavoritesScreen(widget.favoritesMeal),
      },
    ];

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _currentState = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentState]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_currentState]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _selectPage(index),
        currentIndex: _currentState,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rate),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

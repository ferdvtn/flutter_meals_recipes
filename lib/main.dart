import 'package:flutter/material.dart';
import 'package:flutter_complete_guide_part_7/dummy_data.dart';

import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _settings = {
    'gluten_free': false,
    'lactose_free': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _filteredMeals = DUMMY_MEALS;
  final List<Meal> _favoritesMeals = [];

  void _saveSetting(BuildContext context, Map<String, bool> newSettings) {
    setState(() {
      _settings = newSettings;

      _filteredMeals = DUMMY_MEALS.where((meal) {
        if (_settings['gluten_free'] == true && meal.isGlutenFree == false) {
          return false;
        }
        if (_settings['lactose_free'] == true && meal.isLactoseFree == false) {
          return false;
        }
        if (_settings['vegan'] == true && meal.isVegan == false) {
          return false;
        }
        if (_settings['vegetarian'] == true && meal.isVegetarian == false) {
          return false;
        }

        return true;
      }).toList();
    });

    Navigator.of(context).pushReplacementNamed('/');
  }

  void _toggleFavoriteMeal(String mealId) {
    bool existInFav = _favoritesMeals
        .contains(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    setState(() {
      if (existInFav) {
        _favoritesMeals.removeWhere((meal) => meal.id == mealId);
      } else {
        _favoritesMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_favoritesMeals);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(245, 245, 245, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              subtitle1: const TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
              subtitle2: const TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
            ),
      ),
      // home: const CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoritesMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_filteredMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_favoritesMeals, _toggleFavoriteMeal),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_settings, _saveSetting),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.name);
      //   return MaterialPageRoute(
      //     builder: (context) => const CategoriesScreen(),
      //   );
      // },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //       builder: (context) => const CategoriesScreen());
      // },
    );
  }
}

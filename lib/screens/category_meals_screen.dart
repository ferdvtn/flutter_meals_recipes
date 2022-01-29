import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen(this.filteredMeals, {Key? key}) : super(key: key);

  static const routeName = '/category-meals';
  final List<Meal> filteredMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryId;
  late Color categoryColor;
  late String categoryTitle;
  late List<Meal> displayedMeals;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    categoryColor = routeArgs['color'] as Color;
    categoryTitle = routeArgs['title'] as String;
    categoryId = routeArgs['id'] as String;
    displayedMeals = widget.filteredMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CategoryMealsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _hiddenItem(String id) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: categoryColor,
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayedMeals.length,
        itemBuilder: (context, index) {
          return MealItem(
            color: categoryColor,
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            hiddenItem: _hiddenItem,
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     print('on press $_counter');
      //     setState(
      //       () => _counter = _counter + 1,
      //     );
      //   },
      // ),
    );
  }
}

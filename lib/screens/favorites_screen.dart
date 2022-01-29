import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(this.favoritesMeal, {Key? key}) : super(key: key);

  final List<Meal> favoritesMeal;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritesMeal.length,
      itemBuilder: (context, index) {
        return MealItem(
          // color: categoryColor,
          id: favoritesMeal[index].id,
          title: favoritesMeal[index].title,
          imageUrl: favoritesMeal[index].imageUrl,
          duration: favoritesMeal[index].duration,
          complexity: favoritesMeal[index].complexity,
          affordability: favoritesMeal[index].affordability,
          // hiddenItem: _hiddenItem,
        );
      },
    );
  }
}

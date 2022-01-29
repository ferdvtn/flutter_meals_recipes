import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(this.favoritesMeals, this.toggleFavoriteMealHandler,
      {Key? key})
      : super(key: key);

  static const routeName = '/meal-detail';
  final List<Meal> favoritesMeals;
  final Function toggleFavoriteMealHandler;

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
      height: 120,
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }

  Widget buildStarButton(String mealId) {
    final bool meal = favoritesMeals.any((meal) => meal.id == mealId);
    IconData icon;
    if (meal) {
      icon = Icons.star_outlined;
    } else {
      icon = Icons.star_outline;
    }

    return IconButton(
      onPressed: () => toggleFavoriteMealHandler(mealId),
      icon: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final id = routeArgs['id'] as String;
    final color = routeArgs['color'] as Color;
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            ElevatedButton(
              onPressed: () => toggleFavoriteMealHandler(id),
              child: buildStarButton(id),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              context,
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) => Card(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white10,
                          color.withOpacity(0.5),
                        ],
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    child: Text(meal.ingredients[index]),
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              context,
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: meal.steps.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withOpacity(0.5),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(meal.steps[index]),
                    // textColor: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.error,
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context).pop(id);
        },
      ),
    );
  }
}

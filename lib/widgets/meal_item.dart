import 'package:flutter/material.dart';
import '../screens/meal_detail_screen.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    this.color = Colors.pinkAccent,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
    this.hiddenItem,
    Key? key,
  }) : super(key: key);

  final Color color;
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function? hiddenItem;

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: {
        'id': id,
        'color': color,
      },
    ).then((id) => id != null ? hiddenItem!(id) : null);
  }

  Widget infoLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Pricey:
        return 'Pricey';
      case Affordability.Luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 15;
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          color.withOpacity(0.4),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(radius),
                        bottomRight: Radius.circular(radius),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  infoLabel(
                    Icons.access_time_outlined,
                    '$duration min',
                  ),
                  infoLabel(
                    Icons.work_outline_outlined,
                    complexityText,
                  ),
                  infoLabel(
                    Icons.attach_money_outlined,
                    affordabilityText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

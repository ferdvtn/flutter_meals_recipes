import 'package:flutter/material.dart';

import './screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.only(left: 10),
              color: Theme.of(context).colorScheme.secondary,
              alignment: Alignment.centerLeft,
              child: const Text(
                'Cooking Up!',
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                buildListItem(context, Icons.restaurant, 'Meals', () {
                  Navigator.of(context).pushReplacementNamed(
                    '/',
                  );
                }),
                buildListItem(context, Icons.settings, 'Filters', () {
                  Navigator.of(context).pushReplacementNamed(
                    FiltersScreen.routeName,
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  ListTile buildListItem(BuildContext context, IconData icon, String title,
      VoidCallback tapHandler) {
    return ListTile(
      textColor: Theme.of(context).textTheme.subtitle1!.color,
      leading: Icon(icon),
      title: Text(title),
      onTap: tapHandler,
    );
  }
}

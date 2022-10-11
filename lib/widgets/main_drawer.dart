import 'package:flutter/material.dart';
import '/screens/filters.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) =>
      ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).accentColor,
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            alignment: Alignment.centerLeft,
            child: Text(
              'Hello',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 20),
          buildListItem(
            title: 'Meals',
            icon: Icons.restaurant,
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          buildListItem(
            title: 'Filters',
            icon: Icons.settings,
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.routeName),
          ),
          buildListItem(
            title: 'Back',
            icon: Icons.navigate_before,
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

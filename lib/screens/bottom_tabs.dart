import 'package:flutter/material.dart';
import '/models/bottom_nav.dart';
import '/widgets/main_drawer.dart';
import '/screens/favorites.dart';
import '/screens/categories.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<BottomNavigationModel> _screens = [
    BottomNavigationModel(
        widget: const CategoriesScreen(),
        label: 'Categories',
        icon: Icons.category),
    BottomNavigationModel(
        widget: const FavoritesScreen(), label: 'Favorites', icon: Icons.star),
  ];
  int _selectedIndex = 0;
  void _selectScreen(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedIndex].label),
      ),
      drawer: const MainDrawer(),
      body: _screens[_selectedIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? null
            : Colors.white,
        items: _screens
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  backgroundColor: Theme.of(context).primaryColor,
                  label: e.label,
                ))
            .toList(),
      ),
    );
  }
}

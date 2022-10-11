import 'package:flutter/material.dart';
import 'package:navigation_app/dummy_data.dart';
import 'package:navigation_app/models/item.dart';
import '/screens/category_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  static const FAVORITES_KEY = 'favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return favorites.isEmpty
        ? const Center(
            child: Text('You have no favorites yet'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final favorite = getItem(favorites[index]);
              return CategoryItem(favorite, () {});
            },
            itemCount: favorites.length,
          );
  }

  ItemData getItem(String id) {
    return DUMMY_MEALS.where((element) => element.id == id).single;
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final newFavorites = prefs.getStringList(FavoritesScreen.FAVORITES_KEY);
    if (newFavorites == null || newFavorites.isEmpty) return;
    setState(() {
      favorites.addAll(newFavorites);
    });
  }
}

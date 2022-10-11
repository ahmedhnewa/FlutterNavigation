import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/screens/favorites.dart';
import '/models/item.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  static const routeName = '/item-detail';

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late final ItemData item;
  late final List<String> favorites = [];
  bool _loadedInitData = false;
  bool isFavorite = false;

  @override
  void didChangeDependencies() {
    if (_loadedInitData) return;
    super.didChangeDependencies();
    item = ModalRoute.of(context)!.settings.arguments as ItemData;
    _loadIsFavorite();
    _loadedInitData = true;
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(item.title),
    );

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final contentHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(item.id),
        child: const Icon(Icons.delete),
      ),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: contentHeight * 0.5,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              onPressed: () => _toggleFavorite(item.id),
              icon: isFavorite
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
            ),
            const SizedBox(height: 2),
            _buildSectionTitle(context, 'Ingredientss'),
            buildContainerWithBorder(
              height: contentHeight * 0.35,
              child: ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(item.ingredients[index]),
                  ),
                ),
                itemCount: item.ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            buildContainerWithBorder(
              height: contentHeight * 0.4,
              child: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(item.steps[index]),
                      // trailing: const Text('Hello'),
                    ),
                    const Divider()
                  ],
                ),
                itemCount: item.steps.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteList =
        prefs.getStringList(FavoritesScreen.FAVORITES_KEY) ?? [];
    bool exists = favoriteList.contains(id);
    if (!exists) {
      favoriteList.add(id);
    } else {
      favoriteList.remove(id);
    }
    prefs.setStringList(FavoritesScreen.FAVORITES_KEY, favoriteList);
    setState(() {
      isFavorite = !exists;
    });
  }

  void _loadIsFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(FavoritesScreen.FAVORITES_KEY) ?? [];
    setState(() {
      isFavorite = favorites.any((element) => element == item.id);
    });
    // favorites.forEach((element) {
    //   if (element == item.id) {
    //     setState(() {
    //       isFavorite = true;
    //     });
    //   }
    //
    // });
  }

  Widget _buildSectionTitle(BuildContext context, String title) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );

  Widget buildContainerWithBorder(
          {required double height,
          double width = 300,
          required Widget child}) =>
      Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        height: height,
        width: width,
        child: child,
      );
}

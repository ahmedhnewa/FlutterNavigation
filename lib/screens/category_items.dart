import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/filters.dart';
import '/screens/item_detail.dart';
import '../models/item.dart';
import '/models/category.dart';
import '/dummy_data.dart';

class CategoryItemsScreen extends StatefulWidget {
  const CategoryItemsScreen({super.key});

  static const routeName = '/category-items';

  @override
  State<CategoryItemsScreen> createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  late final Category category;
  late List<ItemData> categoryItems;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (_loadedInitData) return;
    super.didChangeDependencies();
    category = ModalRoute.of(context)!.settings.arguments as Category;
    final prefs = SharedPreferences.getInstance();
    final categoryId = category.id;
    categoryItems = DUMMY_MEALS
        .where((meal) => meal.categoryIds.contains(categoryId))
        .toList();
    prefs.then(
      (prefs) => setState(() {
        // Filters
        final _glutenFree =
            prefs.getBool(FiltersScreen.GLUENT_FREE_KEY) ?? false;
        final _vegetarian =
            prefs.getBool(FiltersScreen.VEGETARIAN_KEY) ?? false;
        final _vegan = prefs.getBool(FiltersScreen.VEGAN_KEY) ?? false;
        final _lactoseFree =
            prefs.getBool(FiltersScreen.LACTOSE_FREE_KEY) ?? false;
        categoryItems = categoryItems.where((element) {
          if (_glutenFree && !element.isGlutenFree) return false;
          if (_lactoseFree && !element.isLactoseFree) return false;
          if (_vegan && !element.isVegan) return false;
          if (_vegetarian && !element.isVegetarian) return false;
          return true;
        }).toList();
      }),
    );
    _loadedInitData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => CategoryItem(
          categoryItems[index],
          () => setState(() {
            categoryItems.removeWhere(
                (element) => element.id == categoryItems[index].id);
          }),
        ),
        itemCount: categoryItems.length,
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.item, this.onRemoveItem, {super.key});

  final ItemData item;
  final Function onRemoveItem;

  @override
  Widget build(BuildContext context) {
    const double radius = 15;
    final borderRadius = BorderRadius.circular(radius);
    return LayoutBuilder(
      builder: (context, constraints) => Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () => _selectItem(context, item, onRemoveItem),
          splashColor: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: constraints.maxWidth,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        // horizontal: 20,
                      ),
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 26),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        const Icon(Icons.schedule),
                        const SizedBox(
                          width: 6,
                        ),
                        Text('${item.duration} min')
                      ],
                    ),
                    // SizedBox(width: 20),
                    Row(
                      children: [
                        const Icon(Icons.work),
                        const SizedBox(width: 6),
                        Text(item.complexity.name)
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        const SizedBox(width: 6),
                        Text(item.affordability.name[0])
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectItem(
          BuildContext context, ItemData item, Function onRemoveItem) =>
      Navigator.of(context)
          .pushNamed(ItemDetailScreen.routeName, arguments: item)
          .then((itemId) {
        if (itemId == null) return;
        onRemoveItem();
      });
}

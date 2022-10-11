import 'package:flutter/material.dart';

import '/screens/category_items.dart';
import '/models/category.dart';
import '/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES.map((e) => CategoryItem(e)).toList(),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    return InkWell(
      onTap: () => openCategory(context, category),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [category.color.withOpacity(0.7), category.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.all(15),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  void openCategory(BuildContext context, Category category) {
    Navigator.of(context).pushNamed(
      CategoryItemsScreen.routeName,
      arguments: category,
    );
  }
}

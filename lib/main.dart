import 'package:flutter/material.dart';

import 'screens/top_tabs.dart';
// import 'screens/bottom_tabs.dart';
import './screens/category_items.dart';
import './screens/item_detail.dart';
import '/screens/filters.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool useMaterial3 = true;
    const isDark = true;
    final theme = ThemeData(
      primarySwatch: Colors.pink,
      fontFamily: 'Raleway',
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme:
          isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.copyWith(
        useMaterial3: useMaterial3,
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
      ),
      darkTheme: theme.copyWith(
        useMaterial3: useMaterial3,
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      // home: const CategoriesScreen(),
      routes: {
        '/': (context) => const TabsScreen(),
        CategoryItemsScreen.routeName: (context) => const CategoryItemsScreen(),
        ItemDetailScreen.routeName: (context) => const ItemDetailScreen(),
        FiltersScreen.routeName: (context) => const FiltersScreen()
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('404'),
          ),
          body: const Center(
            child: Text('Can\'t find this screen'),
          ),
        ),
      ),
    );
  }
}

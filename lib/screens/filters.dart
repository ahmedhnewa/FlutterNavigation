import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  static const routeName = '/filters';
  static const GLUENT_FREE_KEY = 'glutenFree';
  static const VEGETARIAN_KEY = 'vegetarian';
  static const VEGAN_KEY = 'vegan';
  static const LACTOSE_FREE_KEY = 'lactoseFree';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool initValue,
    Function(bool newValue) updateValue,
  ) =>
      SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: initValue,
        onChanged: updateValue,
      );

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _saveSettings,
            icon: const Icon(Icons.save),
          ),
        ],
        title: const Text('Your filters'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free items',
                  _glutenFree,
                  (value) => setState(() {
                    _glutenFree = value;
                  }),
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free items',
                  _lactoseFree,
                  (value) => setState(() {
                    _lactoseFree = value;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian items',
                  _vegetarian,
                  (value) => setState(() {
                    _vegetarian = value;
                  }),
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan items',
                  _vegan,
                  (value) => setState(() {
                    _vegan = value;
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(FiltersScreen.GLUENT_FREE_KEY, _glutenFree);
    prefs.setBool(FiltersScreen.VEGETARIAN_KEY, _vegetarian);
    prefs.setBool(FiltersScreen.VEGAN_KEY, _vegan);
    prefs.setBool(FiltersScreen.LACTOSE_FREE_KEY, _lactoseFree);
  }

  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _glutenFree = prefs.getBool(FiltersScreen.GLUENT_FREE_KEY) ?? false;
      _vegetarian = prefs.getBool(FiltersScreen.VEGETARIAN_KEY) ?? false;
      _vegan = prefs.getBool(FiltersScreen.VEGAN_KEY) ?? false;
      _lactoseFree = prefs.getBool(FiltersScreen.LACTOSE_FREE_KEY) ?? false;
    });
  }
}

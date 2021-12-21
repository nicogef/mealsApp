import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(setFilters, currentFilters, {Key? key})
      : _saveFilters = setFilters, _filters = currentFilters,
        super(key: key);

  final Function _saveFilters;
  final Map<String, bool> _filters;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  initState() {
    _isGlutenFree = widget._filters['isGlutenFree']!;
    _isVegan = widget._filters['isVegan']!;
    _isVegetarian = widget._filters['isVegetarian']!;
    _isLactoseFree = widget._filters['isLactoseFree']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      {required String title,
      required bool current,
      required Function update,
      String subtitle = ""}) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: current,
        onChanged: (v) {
          setState(() => update(v));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  Map<String, bool> values = {
                    'isGlutenFree': _isGlutenFree,
                    'isVegan': _isVegan,
                    'isVegetarian': _isVegetarian,
                    'isLactoseFree': _isLactoseFree,
                  };
                  widget._saveFilters(values);
                }),
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                child: Text('Preferences',
                    style: Theme.of(context).textTheme.subtitle1)),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile(
                    title: 'Gluten Free',
                    subtitle: 'This is for people with Gluten problems',
                    current: _isGlutenFree,
                    update: (v) => _isGlutenFree = v),
                _buildSwitchListTile(
                    title: 'Lactose Free',
                    current: _isLactoseFree,
                    update: (v) => _isLactoseFree = v),
                _buildSwitchListTile(
                    title: 'Vegan',
                    current: _isVegan,
                    update: (v) => _isVegan = v),
                _buildSwitchListTile(
                    title: 'Vegetarian',
                    current: _isVegetarian,
                    update: (v) => _isVegetarian = v),
              ],
            ))
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';

import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(List<Meal> favoritesMeals, {Key? key})
      : _favoritesMeals = favoritesMeals,
        super(key: key);

  final List<Meal> _favoritesMeals;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPage = 0;
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget._favoritesMeals),
        'title': 'Your Favorite',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  BottomNavigationBarItem _buildBarItem(IconData item, String label) {
    return BottomNavigationBarItem(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        icon: Icon(item),
        label: label);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPage]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPage]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blueGrey,
        currentIndex: _selectedPage,
        // type: BottomNavigationBarType.fixed,
        items: [
          _buildBarItem(Icons.category, 'Categories'),
          _buildBarItem(Icons.star, 'Favorites'),
        ],
      ),
    );
  }
}

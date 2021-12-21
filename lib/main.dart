import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meals.dart';
import './screen/categories_screen.dart';
import './screen/category_meals_screen.dart';
import './screen/meal_details_screen.dart';
import './screen/settings_screen.dart';
import './screen/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'isGlutenFree': false,
    'isVegan': false,
    'isVegetarian': false,
    'isLactoseFree': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favoritesMeals = List.empty(growable: true);

  void _setFilters(Map<String, bool> data) {
    setState(() {
      _filters = data;
      _availableMeals = DUMMY_MEALS.where((m) {
        if (_filters['isGlutenFree']! && !m.isGlutenFree) return false;
        if (_filters['isVegan']! && !m.isVegan) return false;
        if (_filters['isVegetarian']! && !m.isVegetarian) return false;
        if (_filters['isLactoseFree']! && !m.isLactoseFree) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id) {
    final int existingIndex = _favoritesMeals.indexWhere((e) => e.id == id);
    setState(() {
      existingIndex < 0
          ? _favoritesMeals.add(DUMMY_MEALS.firstWhere((e) => e.id == id))
          : _favoritesMeals.removeAt(existingIndex);
    });
  }

  bool _isFavorite(String id) {
    return _favoritesMeals.any((e) => e.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.white),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            subtitle1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold),
            subtitle2: const TextStyle(
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
        bottomNavigationBarTheme: ThemeData().bottomNavigationBarTheme.copyWith(
              unselectedLabelStyle:
                  const TextStyle(fontFamily: 'RobotoCondensed'),
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'RobotoCondensed'),
            ),
      ),
      //home: const CategoriesScreen(),
      routes: //_initialiseRoutes(),
          // { for (var e in ALL_PAGES.values) e.route : (ctx) => e.screen() },
          {
        // This links to home
        '/': (ctx) => TabsScreen(_favoritesMeals),
        '/categories': (ctx) => const CategoriesScreen(),
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        '/meals': (ctx) => MealDetailsScreen(_toggleFavorite, _isFavorite),
        '/settings': (ctx) => SettingsScreen(_setFilters, _filters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}

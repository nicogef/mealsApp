import 'package:flutter/material.dart';
import '../lib/screen/category_meals_screen.dart';
import '../lib/screen/settings_screen.dart';

import '../lib/screen/categories_screen.dart';
import '../lib/screen/favorites_screen.dart';
import '../lib/screen/meal_details_screen.dart';
import '../lib/screen/tabs_screen.dart';

enum Positions {
  mainDrawer,
  bottomTab,
}

class AppScreens {
  final String label;
  final Function screen;
  final IconData icon;
  final List<Positions> positions;
  final String route;

  const AppScreens(
      {required this.label,
      required this.screen,
      required this.icon,
      required this.positions,
      required this.route});
}

MapEntry<String, AppScreens> _buildAppScreen(
    {required label,
    required screen,
    required icon,
    required positions,
    required route}) {
  return MapEntry(
      label,
      AppScreens(
          label: label,
          screen: screen,
          icon: icon,
          positions: positions,
          route: route));
}

Map<String, AppScreens> ALL_PAGES = {
  'TabsScreen':  AppScreens(
      label: 'TabsScreen',
      screen: (v) =>  TabsScreen(v),
      icon: Icons.account_tree,
      positions: [],
      route: "/"),
  'Categories': AppScreens(
      label: 'Categories',
      screen: () => const CategoriesScreen(),
      icon: Icons.category,
      positions: [Positions.mainDrawer, Positions.bottomTab],
      route: "/"), // AppScreens Go back to root as default
  'Category Meals': AppScreens(
      label: 'Category Meals',
      screen: () => (v) => CategoryMealsScreen(v),
      icon: Icons.category,
      positions: [],
      route: "/meals-categories"),
  'Meal Details': AppScreens(
      label: 'Meal Details',
      screen: (a,b) => MealDetailsScreen(a,b),
      icon: Icons.restaurant,
      positions: [],
      route: "/meals-details"),
  'Settings': AppScreens(
      label: 'Settings',
      screen: (v, f) => SettingsScreen(v, f),
      icon: Icons.settings,
      positions: [Positions.mainDrawer],
      route: "/settings"),
  'Favorites': AppScreens(
      label: 'Favorites',
      screen: (v) => FavoritesScreen(v),
      icon: Icons.star,
      positions: [Positions.bottomTab],
      route: "/favorites"),
};

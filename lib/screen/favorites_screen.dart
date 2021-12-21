import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meals.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(List<Meal> favoritesMeals, {Key? key})
      : _favoritesMeals = favoritesMeals,
        super(key: key);

  final List<Meal> _favoritesMeals;

  @override
  Widget build(BuildContext context) {
    if (_favoritesMeals.isEmpty) {
      return const Center(
          child: Text('You have no favorites yet - start adding some!'));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _favoritesMeals[index].id,
            title: _favoritesMeals[index].title,
            imageUrl: _favoritesMeals[index].imageUrl,
            duration: _favoritesMeals[index].duration,
            affordability: _favoritesMeals[index].affordability,
            complexity: _favoritesMeals[index].complexity,
          );
        },
        itemCount: _favoritesMeals.length,
      );
    }
  }
}

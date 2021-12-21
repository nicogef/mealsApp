import 'package:flutter/material.dart';

import '../models/meals.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen(availableMeals, {Key? key}) : _availableMeals = availableMeals, super(key: key);

  final List<Meal> _availableMeals;

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Meal> categoryMeals;
  late String category;
  late Color color;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      category = routeArgs['title']! as String;
      final id = routeArgs['id']! as String;
      color = routeArgs['color']! as Color;

      categoryMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // final String id;
  @override
  Widget build(BuildContext context) {
    void _removeMeal(id) {
      print('remove $id');
      setState(() {
        categoryMeals.removeWhere((element) => element.id == id);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: color,
      ),
      body: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (BuildContext context, int index) {
            var categoryMeal = categoryMeals[index];
            return MealItem(
              id: categoryMeal.id,
              title: categoryMeal.title,
              imageUrl: categoryMeal.imageUrl,
              duration: categoryMeal.duration,
              complexity: categoryMeal.complexity,
              affordability: categoryMeal.affordability,
            );
          }),
    );
  }
}

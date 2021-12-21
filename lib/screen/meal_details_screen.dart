import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen(
      Function(String id) toggleFavorite, Function(String id) isFavorite,
      {Key? key})
      : _toggleFavorite = toggleFavorite,
        _isFavorite = isFavorite,
        super(key: key);

  final Function(String id) _toggleFavorite;
  final Function(String id) _isFavorite;

  List<Widget> buildListWidget(BuildContext context, String title,
      {required Widget child}) {
    return [
      Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: Theme.of(context).textTheme.subtitle1)),
      Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: child),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final id = routeArgs['id']! as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              )),
          ...buildListWidget(context, 'Ingredient',
              child: ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            meal.ingredients[index],
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                      ))),
          ...buildListWidget(
            context,
            'Steps',
            child: ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          leading:
                              CircleAvatar(child: Text('# ${(index + 1)}')),
                          title: Text(
                            meal.steps[index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        const Divider(),
                      ],
                    )),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(_isFavorite(id) ? Icons.star : Icons.star_border),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => _toggleFavorite(id)),
    );
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

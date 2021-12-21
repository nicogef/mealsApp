import 'package:flutter/material.dart';

import '../models/meals.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability,
      required this.id})
      : super(key: key);

  void _selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed('/meals', arguments: {'id': id});
  }

  Widget _buildImage(url) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      child: Image.network(
        url,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTitle(title) {
    return Positioned(
      bottom: 20,
      right: 10,
      child: Container(
        width: 300,
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 26, color: Colors.white),
          //softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }

  Widget _buildInfo(
      int duration, Complexity complexity, Affordability affordability) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(children: [
            const Icon(Icons.schedule),
            const SizedBox(width: 6),
            Text('$duration min'),
          ]),
          Row(children: [
            const Icon(Icons.work),
            const SizedBox(width: 6),
            Text(complexity.toShortString()),
          ]),
          Row(children: [
            const Icon(Icons.attach_money),
            const SizedBox(width: 6),
            Text(affordability.toShortString()),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _selectMeal(context),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  _buildImage(imageUrl),
                  _buildTitle(title),
                ],
              ),
              _buildInfo(duration, complexity, affordability),
            ],
          ),
        ));
  }
}

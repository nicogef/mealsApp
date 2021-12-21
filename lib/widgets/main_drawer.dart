import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget _buildListTile(BuildContext context, title, IconData icon,
      String route) {
    return ListTile(
        leading: Icon(icon, size: 26),
        title: Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 24),
        ),
        onTap: () => Navigator.of(context).pushReplacementNamed(route)
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      color: Theme
          .of(context)
          .primaryColor,
      child: Text(title,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Theme
                  .of(context)
                  .colorScheme
                  .secondary)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
          _buildTitle(context, 'Cooking App'),
          const SizedBox(height: 20),
          _buildListTile(context, 'Categories', Icons.category, '/'),
          _buildListTile(context, 'Settings', Icons.settings, '/settings'),
        ],
        ));
  }
}
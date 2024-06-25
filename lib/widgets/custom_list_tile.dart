import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('customListTile_$title'), // Key for testing.
      leading: Icon(icon, color: iconColor, size: 40), // Leading icon with specified size and color.
      title: Text(title), // Main title of the list tile.
      subtitle: Text(subtitle), // Subtitle of the list tile.
      trailing: const Icon(Icons.arrow_forward_ios), // Trailing arrow icon.
      onTap: () {}, // onTap callback (empty for now).
    );
  }
}

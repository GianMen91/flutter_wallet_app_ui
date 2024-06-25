import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: const Key('appBarTitle'), // Key for testing.
      text: const TextSpan(
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'My ',
            style: TextStyle(fontWeight: FontWeight.bold), // Bold style for 'My'.
          ),
          TextSpan(
            text: 'Cards', // Regular style for 'Cards'.
          ),
        ],
      ),
    );
  }
}

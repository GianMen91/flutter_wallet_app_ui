import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'My ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Cards'),
        ],
      ),
    );
  }
}

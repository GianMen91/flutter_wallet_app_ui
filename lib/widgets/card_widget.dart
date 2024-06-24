import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(card.color),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Balance', style: TextStyle(color: Colors.white)),
            Text(
              card.balance,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(card.number, style: const TextStyle(color: Colors.white)),
                Text(card.expiry, style: const TextStyle(color: Colors.white)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

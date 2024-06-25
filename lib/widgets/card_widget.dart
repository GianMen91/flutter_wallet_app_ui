import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel card;

  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('cardWidget'), // Key for testing.
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
            const Text('Balance', style: TextStyle(color: Colors.white)), // Label for balance.
            Text(
              card.balance,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              key: const Key('cardBalance'), // Key for testing.
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.number,
                  style: const TextStyle(color: Colors.white),
                  key: const Key('cardNumber'), // Key for testing.
                ),
                Text(
                  card.expiry,
                  style: const TextStyle(color: Colors.white),
                  key: const Key('cardExpiry'), // Key for testing.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

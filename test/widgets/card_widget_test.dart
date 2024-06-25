import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/models/card_model.dart';
import 'package:flutter_wallet_app_ui/widgets/card_widget.dart';

void main() {
  testWidgets('CardWidget UI Test', (WidgetTester tester) async {
    // Test data
    final testCard = CardModel(
      balance: "\$5250.25",
      number: "12345678",
      expiry: "10/24",
      color: 0xFF8A2BE2,
    );

    // Build the CardWidget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CardWidget(card: testCard),
        ),
      ),
    );

    // Verify the presence of the CardWidget.
    expect(find.byKey(const Key('cardWidget')), findsOneWidget);

    // Verify the balance text.
    expect(find.byKey(const Key('cardBalance')), findsOneWidget);
    expect(find.text("\$5250.25"), findsOneWidget);

    // Verify the card number text.
    expect(find.byKey(const Key('cardNumber')), findsOneWidget);
    expect(find.text("12345678"), findsOneWidget);

    // Verify the expiry date text.
    expect(find.byKey(const Key('cardExpiry')), findsOneWidget);
    expect(find.text("10/24"), findsOneWidget);
  });
}

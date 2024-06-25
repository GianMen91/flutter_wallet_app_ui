import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/widgets/action_buttons.dart';

void main() {
  testWidgets('ActionButtons UI Test', (WidgetTester tester) async {
    // Build the ActionButtons widget.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ActionButtons(),
        ),
      ),
    );

    // Verify the presence of the Send button.
    expect(find.byKey(const Key('sendButton')), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);
    expect(find.text('Send'), findsOneWidget);

    // Verify the presence of the Pay button.
    expect(find.byKey(const Key('payButton')), findsOneWidget);
    expect(find.byIcon(Icons.payment), findsOneWidget);
    expect(find.text('Pay'), findsOneWidget);

    // Verify the presence of the Bills button.
    expect(find.byKey(const Key('billsButton')), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long), findsOneWidget);
    expect(find.text('Bills'), findsOneWidget);
  });
}

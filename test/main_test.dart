import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/main.dart';
import 'package:flutter_wallet_app_ui/screens/wallet_home.dart'; // Adjust the import based on your project structure.

void main() {
  testWidgets('MyApp UI Test', (WidgetTester tester) async {
    // Build the MyApp widget.
    await tester.pumpWidget(const MyApp());

    // Verify the presence of the MaterialApp.
    expect(find.byKey(const Key('myApp')), findsOneWidget);

    // Verify the initial screen is WalletHome.
    expect(find.byType(WalletHome), findsOneWidget);
  });
}

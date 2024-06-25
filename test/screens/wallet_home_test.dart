import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/screens/wallet_home.dart';

void main() {
  testWidgets('WalletHome UI Test', (WidgetTester tester) async {
    // Build the WalletHome widget.
    await tester.pumpWidget(
      const MaterialApp(
        home: WalletHome(),
      ),
    );

    // Verify the presence of the AppBar.
    expect(find.byType(AppBar), findsOneWidget);

    // Verify the presence of the add button.
    expect(find.byKey(const Key('addButton')), findsOneWidget);

    // Verify the presence of the CarouselSlider.
    expect(find.byKey(const Key('carouselSlider')), findsOneWidget);

    // Verify the presence of the page indicator.
    expect(find.byKey(const Key('pageIndicator')), findsOneWidget);

    // Verify the presence of the action buttons.
    expect(find.byKey(const Key('actionButtons')), findsOneWidget);

    // Verify the presence of the statistics tile.
    expect(find.byKey(const Key('statisticsTile')), findsOneWidget);

    // Verify the presence of the transactions tile.
    expect(find.byKey(const Key('transactionsTile')), findsOneWidget);

    // Verify the presence of the custom bottom app bar.
    expect(find.byKey(const Key('bottomAppBar')), findsOneWidget);

    // Verify the presence of the floating action button.
    expect(find.byKey(const Key('floatingActionButton')), findsOneWidget);
  });
}

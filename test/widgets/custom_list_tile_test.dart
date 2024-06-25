import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/widgets/custom_list_tile.dart';

void main() {
  testWidgets('CustomListTile UI Test', (WidgetTester tester) async {
    // Build the CustomListTile widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: const [
              CustomListTile(
                icon: Icons.bar_chart,
                iconColor: Colors.orange,
                title: 'Statistics',
                subtitle: 'Payment and Income',
              ),
              CustomListTile(
                icon: Icons.history,
                iconColor: Colors.green,
                title: 'Transactions',
                subtitle: 'Transaction History',
              ),
            ],
          ),
        ),
      ),
    );

    // Verify the presence of the Statistics CustomListTile.
    expect(find.byKey(const Key('customListTile_Statistics')), findsOneWidget);
    expect(find.text('Statistics'), findsOneWidget);
    expect(find.text('Payment and Income'), findsOneWidget);

    // Verify the presence of the Transactions CustomListTile.
    expect(find.byKey(const Key('customListTile_Transactions')), findsOneWidget);
    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('Transaction History'), findsOneWidget);
  });
}

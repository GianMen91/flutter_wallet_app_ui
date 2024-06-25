import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wallet_app_ui/widgets/app_bar_title.dart';

void main() {
  testWidgets('AppBarTitle UI Test', (WidgetTester tester) async {
    // Build the AppBarTitle widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(),
          ),
        ),
      ),
    );

    // Verify the presence of the AppBarTitle.
    expect(find.byKey(const Key('appBarTitle')), findsOneWidget);

    // Verify the text spans are correct.
    expect(find.text('My '), findsOneWidget);
    expect(find.text('Cards'), findsOneWidget);

    // Verify the text styles are correct.
    final textSpanFinder = find.byKey(const Key('appBarTitle')).evaluate().single.widget as RichText;
    final textSpan = textSpanFinder.text as TextSpan;

    expect(textSpan.children![0].style!.fontWeight, FontWeight.bold); // 'My' should be bold.
    expect(textSpan.children![1].style!.fontWeight, isNot(FontWeight.bold)); // 'Cards' should not be bold.
  });
}

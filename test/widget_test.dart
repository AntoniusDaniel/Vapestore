import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_drive/main.dart';

void main() {
  testWidgets('Add to Cart button increments cart item count',
      (WidgetTester tester) async {
    // Build the VapeStoreHomePage widget.
    await tester.pumpWidget(MaterialApp(
      home: VapeStoreHomePage(),
    ));

    // Verify that cart item count starts at 0.
    expect(find.text('Cart: 0'), findsOneWidget);

    // Tap the 'Add to Cart' button and trigger a frame.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
    await tester.pump();

    // Verify that cart item count has incremented.
    expect(find.text('Cart: 1'), findsOneWidget);
  });
}

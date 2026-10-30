import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_product_catalog/main.dart';

void main() {
  testWidgets('login, favorite, open details and add to cart', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome, Guest'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pump();
    expect(find.text('Favorites: 1'), findsOneWidget);

    await tester.tap(find.text('Laptop'));
    await tester.pumpAndSettle();
    expect(find.text('Add to Cart'), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Laptop added to cart'), findsOneWidget);
    expect(find.text('Favorites: 1'), findsOneWidget);
  });
}

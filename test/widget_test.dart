import 'package:flutter_test/flutter_test.dart';

import 'package:campus_coffee/main.dart';

void main() {
  testWidgets('shows the coffee order screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CoffeeApp());

    expect(find.text('Campus Coffee'), findsOneWidget);
    expect(find.text('Choose your drink'), findsOneWidget);
    expect(find.text('Vanilla Latte'), findsOneWidget);
  });
}

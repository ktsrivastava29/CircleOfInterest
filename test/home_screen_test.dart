import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:circle_of_interest/presentation/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen shows a welcome message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    expect(find.text('Welcome to Circle of Interest!'), findsOneWidget);
  });
}

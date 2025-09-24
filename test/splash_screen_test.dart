import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:circle_of_interest/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('SplashScreen shows a logo', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });
}

import 'package:circle_of_interest/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sending a message displays it in the chat list', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ChatScreen(eventId: '', currentUserId: '', currentUserName: ''),
      ),
    );

    // Find input field and send button
    final inputField = find.byType(TextField);
    final sendButton = find.byIcon(Icons.send);

    // Enter text and send
    await tester.enterText(inputField, 'Hello there');
    await tester.tap(sendButton);
    await tester.pumpAndSettle();

    // Check if the message is displayed
    expect(find.text('Hello there'), findsOneWidget);
    expect(find.text('You'), findsOneWidget);
  });
}

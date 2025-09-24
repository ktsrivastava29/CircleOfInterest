import 'package:circle_of_interest/presentation/screens/event_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('sending a message shows it in the list', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: EventChatScreen(
          eventId: 'e1',
          currentUserId: 'u1',
          currentUserName: 'Me',
        ),
      ),
    );

    // Initially empty
    expect(find.byKey(const Key('chat_message_list')), findsOneWidget);

    // Enter text and send
    await tester.enterText(find.byKey(const Key('chat_input_field')), 'Hello');
    await tester.tap(find.byKey(const Key('chat_send_button')));
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Me'), findsOneWidget);
  });
}
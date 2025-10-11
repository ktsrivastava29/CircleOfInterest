import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      appBar: AppBar(title: const Text("Chat"), centerTitle: true),
      body: Center(
        child: Text(
          "Chat Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}

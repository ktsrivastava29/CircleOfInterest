import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Details"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Event Details Screen",
          style: TextStyle(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}

// lib/presentation/widget/event_details/event_description_card.dart
import 'package:flutter/material.dart';

class EventDescriptionCard extends StatelessWidget {
  final String title;
  final String description;
  final Color primaryColor;

  const EventDescriptionCard({super.key, required this.title, required this.description, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

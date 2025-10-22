// lib/presentation/widget/event_details/event_location_card.dart
import 'package:flutter/material.dart';

class EventLocationCard extends StatelessWidget {
  final String title;
  final String locationText;
  final Color primaryColor;
  final VoidCallback onOpenMap;

  const EventLocationCard({
    super.key,
    required this.title,
    required this.locationText,
    required this.primaryColor,
    required this.onOpenMap,
  });

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
            Row(
              children: [
                Icon(Icons.location_on, color: primaryColor),
                const SizedBox(width: 8),
                Expanded(child: Text(locationText, style: const TextStyle(fontSize: 14))),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onOpenMap,
                icon: const Icon(Icons.map),
                label: const Text('View on Map'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

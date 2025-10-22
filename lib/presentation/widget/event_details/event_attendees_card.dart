// lib/presentation/widget/event_details/event_attendees_card.dart
import 'package:flutter/material.dart';

class EventAttendeesCard extends StatelessWidget {
  final String title;
  final int attendeeCount;
  final int mockAvatarCount;
  final Color primaryColor;

  const EventAttendeesCard({
    super.key,
    required this.title,
    required this.attendeeCount,
    required this.primaryColor,
    this.mockAvatarCount = 5,
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
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$attendeeCount going',
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                mockAvatarCount,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: primaryColor.withOpacity(0.7),
                    child: Text(
                      String.fromCharCode(65 + index),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

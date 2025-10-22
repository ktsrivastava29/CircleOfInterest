// lib/presentation/widget/event_details/event_header_chips.dart
import 'package:flutter/material.dart';

class EventHeaderChips extends StatelessWidget {
  final String category;
  final bool isPublic;
  final Color primaryColor;

  const EventHeaderChips({super.key, required this.category, required this.isPublic, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: Text(
                category,
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isPublic ? Colors.green : Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                isPublic ? 'Public' : 'Private',
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

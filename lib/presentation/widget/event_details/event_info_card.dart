// lib/presentation/widget/event_details/event_info_card.dart
import 'package:flutter/material.dart';

class EventInfoCard extends StatelessWidget {
  final String dateText;
  final String timeText;
  final String locationText;
  final Color primaryColor;

  const EventInfoCard({
    super.key,
    required this.dateText,
    required this.timeText,
    required this.locationText,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _InfoRow(icon: Icons.calendar_today, label: 'Date', value: dateText, primaryColor: primaryColor),
            const Divider(),
            _InfoRow(icon: Icons.access_time, label: 'Time', value: timeText, primaryColor: primaryColor),
            const Divider(),
            _InfoRow(icon: Icons.location_on, label: 'Location', value: locationText, primaryColor: primaryColor),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color primaryColor;

  const _InfoRow({required this.icon, required this.label, required this.value, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            flex: 2,
            child: Text(
              '',
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.transparent),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}

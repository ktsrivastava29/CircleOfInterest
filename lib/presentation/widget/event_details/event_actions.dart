// lib/presentation/widget/event_details/event_actions.dart
import 'package:flutter/material.dart';

class EventActions extends StatelessWidget {
  final bool isJoined;
  final Color primaryColor;
  final VoidCallback onJoinToggle;
  final VoidCallback onMessage;
  final VoidCallback onShare;

  const EventActions({
    super.key,
    required this.isJoined,
    required this.primaryColor,
    required this.onJoinToggle,
    required this.onMessage,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: onJoinToggle,
            icon: Icon(isJoined ? Icons.check_circle : Icons.person_add),
            label: Text(isJoined ? 'Joined' : 'Join Event'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isJoined ? Colors.green : primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onMessage,
                icon: const Icon(Icons.message),
                label: const Text('Message'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(onPressed: onShare, icon: const Icon(Icons.share), label: const Text('Share')),
            ),
          ],
        ),
      ],
    );
  }
}

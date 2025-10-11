import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PastEventsWidget extends StatelessWidget {
  final List<String> pastEvents;
  final Function(int) onEventTap;

  const PastEventsWidget({super.key, required this.pastEvents, required this.onEventTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Past Events Joined',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (pastEvents.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('No events joined yet', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pastEvents.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      child: Icon(Icons.event, color: AppColors.primary),
                    ),
                    title: Text(pastEvents[index]),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => onEventTap(index),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

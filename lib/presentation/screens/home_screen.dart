// lib/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/event.dart';
import '../../constants/constants.dart';
import 'event_details_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample events for demonstration
    final List<Event> sampleEvents = [
      Event(
        title: 'Flutter Workshop',
        description: 'Learn Flutter development with hands-on coding exercises.',
        category: 'Workshop',
        isPublic: true,
        dateTime: DateTime.now().add(const Duration(days: 3)),
        location: 'Tech Hub, Downtown',
      ),
      Event(
        title: 'Book Club Meeting',
        description: 'Monthly book club discussion on "The Art of Programming".',
        category: 'Book Club',
        isPublic: true,
        dateTime: DateTime.now().add(const Duration(days: 5)),
        location: 'Central Library',
      ),
      Event(
        title: 'Photography Walk',
        description: 'Explore the city and capture beautiful moments together.',
        category: 'Photography',
        isPublic: true,
        dateTime: DateTime.now().add(const Duration(days: 7)),
        location: 'City Park',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Discover Events'), centerTitle: true, backgroundColor: AppColors.primary),
      body: Padding(
        padding: AppConstants.paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Events',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
            AppConstants.verticalSpaceMedium,
            Expanded(
              child: ListView.builder(
                itemCount: sampleEvents.length,
                itemBuilder: (context, index) {
                  return EventCard(
                    event: sampleEvents[index],
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (context) => EventDetailsScreen(event: sampleEvents[index])));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({Key? key, required this.event, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: AppConstants.paddingMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(event.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      event.category,
                      style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              AppConstants.verticalSpaceSmall,
              Text(
                event.description,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              AppConstants.verticalSpaceSmall,
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat.MMMd().format(event.dateTime),
                    style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.location_on, size: 16, color: AppColors.primary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.location,
                      style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

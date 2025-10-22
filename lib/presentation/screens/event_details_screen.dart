// lib/presentation/screens/event_details_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../models/event.dart';
import '../../constants/constants.dart';

// Widgets
import '../widget/event_details/event_app_bar.dart';
import '../widget/event_details/event_header_chips.dart';
import '../widget/event_details/event_info_card.dart';
import '../widget/event_details/event_description_card.dart';
import '../widget/event_details/event_location_card.dart';
import '../widget/event_details/event_attendees_card.dart';
import '../widget/event_details/event_actions.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool _isJoined = false;
  int _attendeeCount = 23;

  void _toggleJoinEvent() {
    setState(() {
      _isJoined = !_isJoined;
      _attendeeCount += _isJoined ? 1 : -1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isJoined ? 'Joined event successfully!' : 'Left the event'),
        backgroundColor: _isJoined ? Colors.green : Colors.orange,
      ),
    );
  }

  void _toggleBookmark() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bookmark toggled')));
  }

  void _shareEvent() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sharing event...')));
  }

  void _openMap() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening map...')));
  }

  void _contactOrganizer() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening chat with organizer...')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          EventAppBar(
            title: widget.event.title,
            primaryColor: AppColors.primary,
            isJoined: _isJoined,
            onShare: _shareEvent,
            onToggleBookmark: _toggleBookmark,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppConstants.paddingMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventHeaderChips(
                    category: widget.event.category,
                    isPublic: widget.event.isPublic,
                    primaryColor: AppColors.primary,
                  ),
                  AppConstants.verticalSpaceMedium,
                  EventInfoCard(
                    dateText: DateFormat.yMMMMEEEEd().format(widget.event.dateTime),
                    timeText: TimeOfDay.fromDateTime(widget.event.dateTime).format(context),
                    locationText: widget.event.location.isEmpty ? 'Location TBD' : widget.event.location,
                    primaryColor: AppColors.primary,
                  ),
                  AppConstants.verticalSpaceMedium,
                  EventDescriptionCard(
                    title: 'About This Event',
                    description: widget.event.description,
                    primaryColor: AppColors.primary,
                  ),
                  AppConstants.verticalSpaceMedium,
                  if (widget.event.location.isNotEmpty)
                    EventLocationCard(
                      title: 'Location',
                      locationText: widget.event.location,
                      primaryColor: AppColors.primary,
                      onOpenMap: _openMap,
                    ),
                  if (widget.event.location.isNotEmpty) AppConstants.verticalSpaceMedium,
                  EventAttendeesCard(
                    title: 'Attendees',
                    attendeeCount: _attendeeCount,
                    primaryColor: AppColors.primary,
                    mockAvatarCount: 5,
                  ),
                  AppConstants.verticalSpaceLarge,
                  EventActions(
                    isJoined: _isJoined,
                    primaryColor: AppColors.primary,
                    onJoinToggle: _toggleJoinEvent,
                    onMessage: _contactOrganizer,
                    onShare: _shareEvent,
                  ),
                  AppConstants.verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

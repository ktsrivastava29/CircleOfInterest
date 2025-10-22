import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widget/profile/past_events_widget.dart';
import '../widget/profile/profile_image_widget.dart';
import '../widget/profile/user_info_form_widget.dart';
import '../../constants/profile_constants.dart';
import '../../models/event.dart'; // Add this import
import 'event_details_screen.dart'; // Add this import

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isEditing = false;

  String _profileImageUrl = '';
  final List<String> _pastEvents = [
    'Book Club Meeting - Oct 04, 2025',
    'Photography Workshop - Oct 06, 2025',
    'Coding Bootcamp - Oct 10, 2025',
  ];

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  void _initializeUserData() {
    _nameController.text = 'ABC';
    _emailController.text = 'abc123@gmail.com';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageWidget(imageUrl: _profileImageUrl, isEditing: _isEditing, onImageTap: _showImagePicker),
            const SizedBox(height: 24),
            UserInfoFormWidget(
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
              isEditing: _isEditing,
            ),
            const SizedBox(height: 32),
            PastEventsWidget(pastEvents: _pastEvents, onEventTap: _showEventDetails),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(ProfileConstants.profileTitle),
      backgroundColor: AppColors.primary,
      actions: [
        IconButton(icon: Icon(_isEditing ? Icons.save : Icons.edit), onPressed: _toggleEdit),
        // Add this button for quick access to demo event details
        IconButton(icon: const Icon(Icons.event), tooltip: 'View Sample Event', onPressed: _showSampleEvent),
      ],
    );
  }

  void _toggleEdit() {
    if (_isEditing && _formKey.currentState!.validate()) {
      _saveProfile();
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(ProfileConstants.profileUpdatedMessage), backgroundColor: Colors.green),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text(ProfileConstants.cameraOption),
                onTap: () {
                  Navigator.pop(context);
                  // Implement camera functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text(ProfileConstants.galleryOption),
                onTap: () {
                  Navigator.pop(context);
                  // Implement gallery functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Updated method to navigate to Event Details Screen
  void _showEventDetails(int index) {
    // Create an Event object based on the past event
    final eventTitle = _pastEvents[index].split(' - ')[0];
    final eventDate = _pastEvents[index].split(' - ')[1];

    // Parse the date (you might want to store actual DateTime objects)
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(eventDate.replaceAll(',', '').replaceAll(' ', '-'));
    } catch (e) {
      parsedDate = DateTime.now().subtract(Duration(days: index * 5));
    }

    final event = Event(
      title: eventTitle,
      description: _getEventDescription(eventTitle),
      category: _getEventCategory(eventTitle),
      isPublic: true,
      dateTime: parsedDate,
      location: _getEventLocation(eventTitle),
    );

    // Navigate to Event Details Screen
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen(event: event)));
  }

  // Add this method for quick access to a sample event
  void _showSampleEvent() {
    final sampleEvent = Event(
      title: 'CircleOfInterest Demo Event',
      description:
          'This is a demonstration of the Event Details screen. You can join events, view attendees, and interact with other participants.',
      category: 'Demo',
      isPublic: true,
      dateTime: DateTime.now().add(const Duration(days: 2)),
      location: 'Demo Location, Sample City',
    );

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen(event: sampleEvent)));
  }

  // Helper methods to generate realistic event data
  String _getEventDescription(String title) {
    switch (title) {
      case 'Book Club Meeting':
        return 'Join us for an engaging discussion about our latest book selection. Share insights, ask questions, and connect with fellow book lovers.';
      case 'Photography Workshop':
        return 'Learn advanced photography techniques with professional photographers. Bring your camera and explore creative composition and lighting.';
      case 'Coding Bootcamp':
        return 'Intensive coding session covering modern development practices. Perfect for beginners and intermediate developers looking to enhance their skills.';
      default:
        return 'A great event where like-minded people come together to share experiences and learn something new.';
    }
  }

  String _getEventCategory(String title) {
    if (title.contains('Book')) return 'Book Club';
    if (title.contains('Photography')) return 'Photography';
    if (title.contains('Coding')) return 'Workshop';
    return 'Meetup';
  }

  String _getEventLocation(String title) {
    switch (title) {
      case 'Book Club Meeting':
        return 'Central Library, Reading Room A';
      case 'Photography Workshop':
        return 'City Park, Photography Studio';
      case 'Coding Bootcamp':
        return 'Tech Hub, Conference Room 2';
      default:
        return 'Community Center, Main Hall';
    }
  }
}

import 'package:flutter/material.dart';
import '../widget/profile/profile_image_widget.dart';
import '../widget/profile/past_events_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  String _profileImageUrl = '';
  String _name = 'John Doe';
  String _email = 'john@example.com';
  List<String> _pastEvents = ['Event 1', 'Event 2', 'Event 3'];

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
      const SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  void _showImagePicker() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image picker opened')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProfileImageWidget(
                imageUrl: _profileImageUrl,
                isEditing: _isEditing,
                onImageTap: _showImagePicker,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                readOnly: !_isEditing,
                onChanged: (val) => _name = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                readOnly: !_isEditing,
                onChanged: (val) => _email = val,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter your email' : null,
              ),
              const SizedBox(height: 24),
              PastEventsWidget(
                pastEvents: _pastEvents,
                onEventTap: (event) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tapped $event')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

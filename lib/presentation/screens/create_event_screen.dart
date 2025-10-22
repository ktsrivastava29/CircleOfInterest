import 'package:circle_of_interest/constants/constants.dart';
import 'package:circle_of_interest/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/event.dart';
import '../../services/event_services.dart';
import 'event_details_screen.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // Hold form data
  Event _event = Event(
    title: '',
    description: '',
    category: '',
    isPublic: true,
    dateTime: DateTime.now(),
    location: '',
  );

  final EventService _eventService = EventService();

  /// Submit form
  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    // Validate event using service
    final validationMessage = _eventService.validateEvent(_event);
    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(validationMessage)));
      return;
    }

    // Create event
    _eventService.createEvent(
      _event,
      onSuccess: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Event created successfully!'), backgroundColor: Colors.green));

        // Navigate to the event details screen
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailsScreen(event: _event)));
      },
      onError: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to create event')));
      },
    );
  }

  /// Pick event date
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (date != null) {
      setState(() {
        _event.dateTime = DateTime(date.year, date.month, date.day, _event.dateTime.hour, _event.dateTime.minute);
      });
    }
  }

  /// Pick event time
  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_event.dateTime),
    );
    if (time != null) {
      setState(() {
        _event.dateTime = DateTime(
          _event.dateTime.year,
          _event.dateTime.month,
          _event.dateTime.day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  /// Pick event location
  Future<void> _pickLocation() async {
    TextEditingController controller = TextEditingController(text: _event.location);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Event Location'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'City, Venue, or Address'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Select')),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() => _event.location = result);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location selected: ${_event.location}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Create Event"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Event Title
                      TextFormField(
                        initialValue: _event.title,
                        decoration: const InputDecoration(labelText: 'Event Title', border: OutlineInputBorder()),
                        validator: (val) => val == null || val.isEmpty ? 'Enter a title' : null,
                        onSaved: (val) => _event.title = val!,
                      ),
                      AppConstants.verticalSpaceSmall,

                      // Description
                      TextFormField(
                        initialValue: _event.description,
                        decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                        maxLines: 3,
                        validator: (val) => val == null || val.isEmpty ? 'Enter description' : null,
                        onSaved: (val) => _event.description = val!,
                      ),
                      AppConstants.verticalSpaceSmall,

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        value: _event.category.isEmpty ? null : _event.category,
                        decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                        items: Event.categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                        onChanged: (val) => setState(() => _event.category = val!),
                        validator: (val) => val == null || val.isEmpty ? 'Select category' : null,
                      ),
                      AppConstants.verticalSpaceSmall,

                      // Date Picker Card
                      Card(
                        child: ListTile(
                          title: Text(DateFormat.yMMMd().format(_event.dateTime), style: const TextStyle(fontSize: 16)),
                          subtitle: const Text('Event Date'),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: _pickDate,
                        ),
                      ),

                      // Time Picker Card
                      Card(
                        child: ListTile(
                          title: Text(
                            TimeOfDay.fromDateTime(_event.dateTime).format(context),
                            style: const TextStyle(fontSize: 16),
                          ),
                          subtitle: const Text('Event Time'),
                          trailing: const Icon(Icons.access_time),
                          onTap: _pickTime,
                        ),
                      ),

                      // Location Picker Card
                      Card(
                        child: ListTile(
                          title: Text(
                            _event.location.isEmpty ? 'Pick Event Location' : _event.location,
                            style: TextStyle(fontSize: 16, color: _event.location.isEmpty ? Colors.grey : null),
                          ),
                          subtitle: const Text('Event Location'),
                          trailing: const Icon(Icons.location_on),
                          onTap: _pickLocation,
                        ),
                      ),

                      // Public/Private Toggle Card
                      Card(
                        child: SwitchListTile(
                          title: const Text('Public Event'),
                          subtitle: Text(_event.isPublic ? 'Anyone can join' : 'Invite only'),
                          value: _event.isPublic,
                          onChanged: (val) => setState(() => _event.isPublic = val),
                        ),
                      ),

                      AppConstants.verticalSpaceMedium,
                    ],
                  ),
                ),

                // Single Create Event Button at bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Create Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

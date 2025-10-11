import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/event.dart';
import '../../services/event_services.dart';
import '../../constants/constants.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final Event _event = Event(
    title: '',
    description: '',
    category: '',
    isPublic: true,
    dateTime: DateTime.now(),
    location: '',
  );
  final EventService _eventService = EventService();

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final validationMessage = _eventService.validateEvent(_event);
    if (validationMessage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(validationMessage)));
      return;
    }

    _eventService.createEvent(
      _event,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Event Created: ${_event.title} (${_event.category}) on '
              '${_eventService.formatEventDateTime(_event.dateTime)} at ${_event.location}',
            ),
          ),
        );
      },
      onError: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create event')),
        );
      },
    );
  }

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
        _event.dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          _event.dateTime.hour,
          _event.dateTime.minute,
        );
      });
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_event.dateTime));
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

  Future<void> _pickLocation() async {
    TextEditingController controller = TextEditingController(text: _event.location);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Event Location'),
        content: TextField(controller: controller, decoration: const InputDecoration(hintText: 'City, Venue, or Address')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('Select')),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      setState(() => _event.location = result);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Location selected: ${_event.location}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _event.title,
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: textColor),
                validator: (val) => val == null || val.isEmpty ? 'Enter a title' : null,
                onSaved: (val) => _event.title = val!,
              ),
              AppConstants.verticalSpaceSmall,
              TextFormField(
                initialValue: _event.description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: textColor),
                maxLines: 3,
                validator: (val) => val == null || val.isEmpty ? 'Enter description' : null,
                onSaved: (val) => _event.description = val!,
              ),
              AppConstants.verticalSpaceSmall,
              DropdownButtonFormField<String>(
                initialValue: _event.category.isEmpty ? null : _event.category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: Event.categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat, style: TextStyle(color: textColor)))).toList(),
                onChanged: (val) => setState(() => _event.category = val!),
                validator: (val) => val == null || val.isEmpty ? 'Select category' : null,
              ),
              AppConstants.verticalSpaceSmall,
              ListTile(
                title: Text(DateFormat.yMMMd().format(_event.dateTime), style: TextStyle(color: textColor)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text(TimeOfDay.fromDateTime(_event.dateTime).format(context), style: TextStyle(color: textColor)),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              ListTile(
                title: Text(_event.location.isEmpty ? 'Pick Event Location' : _event.location, style: TextStyle(color: textColor)),
                trailing: const Icon(Icons.location_on),
                onTap: _pickLocation,
              ),
              SwitchListTile(
                title: const Text('Public Event'),
                value: _event.isPublic,
                onChanged: (val) => setState(() => _event.isPublic = val),
              ),
              AppConstants.verticalSpaceMedium,
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Create Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


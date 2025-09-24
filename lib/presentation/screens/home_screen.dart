import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CircleOfInterest"),
        centerTitle: true,
      ),
body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to CircleOfInterest"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/events/sample-event/chat'),
              child: const Text('Open Sample Event Chat'),
            ),
          ],
        ),
      ),
    );
  }
}

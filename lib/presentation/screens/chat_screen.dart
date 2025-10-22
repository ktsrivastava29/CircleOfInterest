import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat"), centerTitle: true, backgroundColor: AppColors.primary),
      body: const Center(child: Text("Chat Screen")),
    );
  }
}

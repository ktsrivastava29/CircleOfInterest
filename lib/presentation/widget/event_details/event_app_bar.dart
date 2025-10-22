// lib/presentation/widget/event_details/event_app_bar.dart
import 'package:flutter/material.dart';

class EventAppBar extends StatelessWidget {
  final String title;
  final Color primaryColor;
  final bool isJoined;
  final VoidCallback onShare;
  final VoidCallback onToggleBookmark;

  const EventAppBar({
    super.key,
    required this.title,
    required this.primaryColor,
    required this.isJoined,
    required this.onShare,
    required this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            shadows: [Shadow(offset: Offset(0, 1), blurRadius: 3, color: Colors.black54)],
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [primaryColor, primaryColor.withOpacity(0.8)],
            ),
          ),
          child: const Icon(Icons.event, size: 80, color: Colors.white54),
        ),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share), onPressed: onShare),
        IconButton(icon: Icon(isJoined ? Icons.bookmark : Icons.bookmark_border), onPressed: onToggleBookmark),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class ChatConstants {
  static const String title = "Event Chat";
  static const String messageHint = "Type a message...";
  static const String currentUserName = "You";

  static const double bubbleMaxWidth = 280.0;
  static const double bubbleRadius = 16.0;
  static const double inputBorderRadius = 24.0;
  static const double bubbleVerticalMargin = 6.0;
  static const double bubbleHorizontalMargin = 12.0;
  static const double bubbleVerticalPadding = 10.0;
  static const double bubbleHorizontalPadding = 14.0;

  static const double smallSpace = 4.0;
  static const double mediumSpace = 8.0;
  static const double largeSpace = 16.0;

  static const Duration scrollAnimationDuration = Duration(milliseconds: 200);
  static const Duration scrollDelay = Duration(milliseconds: 100);

  static Color get myBubbleColor => AppColors.primary.withOpacity(0.15);
  static const Color otherBubbleColor = Colors.white;
}

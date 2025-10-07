import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor:
          isDarkMode ? AppColors.cardBackgroundDark : AppColors.cardBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: isDarkMode
          ? AppColors.iconDark.withOpacity(0.7)
          : AppColors.iconLight.withOpacity(0.7),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Create',
        ),
        BottomNavigationBarItem(
         icon: Icon(Icons.chat_bubble_outline),
         activeIcon: Icon(Icons.chat_bubble),
         label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

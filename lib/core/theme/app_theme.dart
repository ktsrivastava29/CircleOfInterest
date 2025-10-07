import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    cardColor: AppColors.cardBackground,
    iconTheme: const IconThemeData(color: AppColors.iconLight),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      surface: AppColors.cardBackground,
      onSurface: AppColors.textPrimary,
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(

      color: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
    ),
    cardColor: AppColors.cardBackgroundDark,
    iconTheme: const IconThemeData(color: AppColors.iconDark),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.primary,
      surface: AppColors.cardBackgroundDark,
      onSurface: AppColors.textPrimaryDark,
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(

      color: Color(0xFF1E1E1E),
    ),
  );
}


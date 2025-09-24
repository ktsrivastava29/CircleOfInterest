import 'package:flutter/material.dart';
import 'config/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const CircleOfInterest());
}

class CircleOfInterest extends StatelessWidget {
  const CircleOfInterest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CircleOfInterest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/chat_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/events/:eventId/chat',
        builder: (context, state) {
          final eventId = state.pathParameters['eventId']!;
          return ChatScreen(
            key: ValueKey('chat_$eventId'),
            eventId: '',
            currentUserId: '',
            currentUserName: '',
          );
        },
      ),
    ],
  );
}

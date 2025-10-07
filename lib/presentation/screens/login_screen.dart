import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.tealAccent : Colors.blue,
            foregroundColor: isDark ? Colors.black : Colors.white,
          ),
          onPressed: () => context.go('/home'),
          child: const Text("Login with Supabase (stub)"),
        ),
      ),
    );
  }
}

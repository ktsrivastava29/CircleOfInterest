import 'package:flutter/material.dart';
import '../widget/bottom_nav.dart';
import 'home_screen.dart';
import 'create_event_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme; // Theme toggle callback

  const MainScreen({super.key, this.onToggleTheme});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CreateEventScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Circle of Interest'),
      //   actions: [
      //     if (widget.onToggleTheme != null)
      //       IconButton(
      //         icon: const Icon(Icons.brightness_6),
      //         onPressed: widget.onToggleTheme,
      //       ),
      //   ],
      // ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationWidget(currentIndex: _currentIndex, onTap: _onTabTapped),
    );
  }
}

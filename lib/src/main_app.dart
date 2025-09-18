import 'package:flutter/material.dart';
import 'package:fitaccess/src/global/custom_bottom_nav_bar.dart';
import 'package:fitaccess/src/screens/homepage/home_page.dart';
import 'package:fitaccess/src/screens/progress/progress_page.dart';
import 'package:fitaccess/src/screens/settings/settings_page.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomePage(title: 'Fit Access'), // Index 0 - Home
      const ProgressPage(), // Index 1 - Progress 
      const Placeholder(), // Index 2 - Apps
      const SettingsPage(), // Index 3 - Settings
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

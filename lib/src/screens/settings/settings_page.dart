import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/custom_app_bar.dart';
import 'package:fitaccess/src/screens/settings/widgets/settings_item.dart';
import 'package:fitaccess/src/screens/settings/widgets/settings_toggle.dart';
import 'package:fitaccess/src/screens/settings/widgets/profile_card.dart';
import 'package:fitaccess/src/screens/settings/excersize_settings/exercise_settings_page.dart';
import 'package:fitaccess/src/screens/settings/feedback/feedback_page.dart';
import 'package:fitaccess/src/global/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Profile Section
            ProfileCard(
              name: 'Steve Erwin', // TODO: get from user profile
              icon: Icons.person,
            ),
            const SizedBox(height: 32),
            
            // Preferences Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return SettingsToggle(
                  icon: Icons.dark_mode_rounded,
                  title: 'Dark Mode',
                  value: themeProvider.isDarkMode,
                  onChanged: (bool value) {
                    themeProvider.setTheme(value);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            SettingsItem(
              icon: Icons.fitness_center_rounded,
              title: 'Exercise Settings',
              screen: const ExerciseSettingsPage(),
            ),
            const SizedBox(height: 16),
            SettingsItem(
              icon: Icons.app_blocking,
              title: 'Blocked Apps',
              // screen: const BlockedAppsPage(), // TODO: Create this page
            ),
            const SizedBox(height: 32),
            
            // Support Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Support',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SettingsItem(
              icon: Icons.feedback,
              title: 'Feedback',
              screen: const FeedbackPage(),
            ),
            const SizedBox(height: 16),
            SettingsItem(
              icon: Icons.help,
              title: 'Help',
              // screen: const HelpPage(), // TODO: Create this page
            ),
          ],
        ),
      ),
    ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/custom_app_bar.dart';
import 'package:fitaccess/src/global/primary_button.dart';
import 'package:fitaccess/src/screens/settings/excersize_settings/widgets/exercise_reward_item.dart';
import 'package:fitaccess/src/theme/exercise_icons.dart';

class ExerciseSettingsPage extends StatefulWidget {
  const ExerciseSettingsPage({super.key});

  @override
  State<ExerciseSettingsPage> createState() => _ExerciseSettingsPageState();
}

class _ExerciseSettingsPageState extends State<ExerciseSettingsPage> {
  // TODO: get this information from a database/API
  List<ExerciseData> exercises = [
    ExerciseData(
      name: 'Push-ups',
      icon: ExerciseIcons.getIcon('Push-ups'),
      currentReward: 6,
      reps: 15,
      unit: 'reps',
    ),
    ExerciseData(
      name: 'Jumping Jacks',
      icon: ExerciseIcons.getIcon('Jumping Jacks'),
      currentReward: 1,
      reps: 15,
      unit: 'reps',
    ),
    ExerciseData(
      name: 'Sit-ups',
      icon: ExerciseIcons.getIcon('Sit-ups'),
      currentReward: 2,
      reps: 10,
      unit: 'reps',
    ),
    ExerciseData(
      name: 'Pull-ups',
      icon: ExerciseIcons.getIcon('Pull-ups'),
      currentReward: 5,
      reps: 5,
      unit: 'reps',
    ),
    ExerciseData(
      name: 'Squats',
      icon: ExerciseIcons.getIcon('Squats'),
      currentReward: 2,
      reps: 10,
      unit: 'reps',
    ),    
    
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Exercise Settings',
        showBackButton: true,
      ),
      body: Column(
        children: [

          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise Rewards',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Adjust how much time each exercise earns you',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.textTertiaryDark : AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          
          // Scrollable exercise list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return ExerciseRewardItem(
                  exercise: exercises[index],
                  onRewardChanged: (newReward) {
                    setState(() {
                      exercises[index].currentReward = newReward;
                    });
                  },
                );
              },
            ),
          ),
          
          // Save button
          PrimaryButton(
            text: 'Save Changes',
            height: 56,
            padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            onTap: () {
              // TODO: Save changes to database/storage
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

// Data model for exercises
class ExerciseData {
  final String name;
  final IconData icon;
  int currentReward; //only thing changeable by user
  final int reps;
  final String unit;

  ExerciseData({
    required this.name,
    required this.icon,
    required this.currentReward,
    required this.reps,
    required this.unit,
  });
}

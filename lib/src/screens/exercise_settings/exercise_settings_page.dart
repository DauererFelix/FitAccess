import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/custom_app_bar.dart';
import 'package:fitaccess/src/screens/exercise_settings/widgets/exercise_reward_item.dart';
import 'package:fitaccess/src/theme/exercise_icons.dart';

class ExerciseSettingsPage extends StatefulWidget {
  const ExerciseSettingsPage({super.key});

  @override
  State<ExerciseSettingsPage> createState() => _ExerciseSettingsPageState();
}

class _ExerciseSettingsPageState extends State<ExerciseSettingsPage> {
  // Sample exercise data - in a real app this would come from a database/API
  List<ExerciseData> exercises = [
    ExerciseData(
      name: 'Push-ups',
      icon: ExerciseIcons.getIcon('Push-ups'),
      currentReward: 2,
      unit: 'minutes per 5 reps',
    ),
    ExerciseData(
      name: 'Jumping Jacks',
      icon: ExerciseIcons.getIcon('Jumping Jacks'),
      currentReward: 1,
      unit: 'minutes per 15 reps',
    ),
    ExerciseData(
      name: 'Sit-ups',
      icon: ExerciseIcons.getIcon('Sit-ups'),
      currentReward: 2,
      unit: 'minutes per 10 reps',
    ),
    ExerciseData(
      name: 'Pull-ups',
      icon: ExerciseIcons.getIcon('Pull-ups'),
      currentReward: 2,
      unit: 'minutes per 1 rep',
    ),
    ExerciseData(
      name: 'Squats',
      icon: ExerciseIcons.getIcon('Squats'),
      currentReward: 1,
      unit: 'minutes per 5 reps',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Exercise Settings',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            const Text(
              'Exercise Rewards',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Adjust how much screen time each exercise earns',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Scrollable exercise list
            Expanded(
              child: ListView.separated(
                itemCount: exercises.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}

// Data model for exercises
class ExerciseData {
  final String name;
  final IconData icon;
  int currentReward;
  final String unit;

  ExerciseData({
    required this.name,
    required this.icon,
    required this.currentReward,
    required this.unit,
  });
}

import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/info_field.dart';
import 'package:fitaccess/src/global/custom_app_bar.dart';
import 'package:fitaccess/src/global/primary_button.dart';
import 'package:fitaccess/src/screens/homepage/widgets/available_time_widget.dart';
import 'package:fitaccess/src/screens/homepage/widgets/exercise_card.dart';
import 'package:fitaccess/src/theme/exercise_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedExerciseIndex = 0; // Currently selected exercise

  // TODO: get this information from the database
  int _availableMinutes = 26; // Available screen time in minutes  
  
  final List<Map<String, dynamic>> _exercises = [
    {
      'icon': ExerciseIcons.getIcon('Push-ups'),
      'name': 'Push-ups',
      'reps': 5,
      'minutes': 2,
    },
    {
      'icon': ExerciseIcons.getIcon('Jumping Jacks'),
      'name': 'Jumping Jacks',
      'reps': 15,
      'minutes': 1,
    },
    {
      'icon': ExerciseIcons.getIcon('Sit-ups'),
      'name': 'Sit-ups',
      'reps': 5,
      'minutes': 1,
    },
    {
      'icon': ExerciseIcons.getIcon('Pull-ups'),
      'name': 'Pull-ups',
      'reps': 1,
      'minutes': 1,
    },
    {
      'icon': ExerciseIcons.getIcon('Squats'),
      'name': 'Squats',
      'reps': 5,
      'minutes': 1,
    },
  ];

  void _selectExercise(int index) {
    setState(() {
      _selectedExerciseIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Available Time
            AvailableTimeWidget(
              availableMinutes: _availableMinutes,
            ),
            const SizedBox(height: 30),

            // Activity Header
            Row(
              children: [
                Text(
                  'Activities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                InfoField(
                  infoText: 'If you want to change the rewards per exercise, you can do so in the settings',
                  dialogTitle: 'FYI :',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Exercise Cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(_exercises.length, (index) {
                    final exercise = _exercises[index];
                    final isSelected = _selectedExerciseIndex == index;
                    
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => _selectExercise(index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: isSelected 
                                  ? Border.all(
                                      color: isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                                      width: 2,
                                    )
                                  : null,
                            ),
                            child: ExerciseCard(
                              icon: exercise['icon'],
                              exerciseName: exercise['name'],
                              reps: exercise['reps'],
                              minutes: exercise['minutes'],
                            ),
                          ),
                        ),
                        if (index < _exercises.length - 1) const SizedBox(height: 12),
                      ],
                    );
                  })..add(const SizedBox(height: 20)), 
                ),
              ),
            ),

            // Start Exercise Button
            PrimaryButton(
              text: 'Start Exercise',
              height: 56,
              onTap: () {
                // TODO: Navigate to exercise selection/camera screen
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:fitaccess/src/screens/settings/excersize_settings/exercise_settings_page.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/custom_gradient_slider.dart';

class ExerciseRewardItem extends StatefulWidget {
  final ExerciseData exercise;
  final Function(int) onRewardChanged;

  const ExerciseRewardItem({
    super.key,
    required this.exercise,
    required this.onRewardChanged,
  });

  @override
  State<ExerciseRewardItem> createState() => _ExerciseRewardItemState();
}

class _ExerciseRewardItemState extends State<ExerciseRewardItem> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.exercise.currentReward;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
            isDark ? AppColors.cardBackgroundSecondaryDark : AppColors.cardBackgroundSecondary,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowMediumDark : AppColors.shadowLight.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: isDark ? AppColors.shadowLightDark : AppColors.shadowLight.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [

          // Exercise info row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                
                // Exercise icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.iconBackgroundDark : AppColors.iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.exercise.icon,
                    size: 24,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textBlack,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Exercise name and minute display
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exercise.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_currentValue minutes for ${widget.exercise.reps} reps',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppColors.textTertiaryDark : AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
        // Slider section
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
          child: Column(
            children: [
              
              CustomGradientSlider(
                value: _currentValue.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value.round();
                  });
                  widget.onRewardChanged(_currentValue);
                },
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}

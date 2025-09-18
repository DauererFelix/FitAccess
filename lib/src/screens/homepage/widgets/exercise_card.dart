import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class ExerciseCard extends StatelessWidget {
  final IconData icon;
  final String exerciseName;
  final int reps;
  final int minutes;

  const ExerciseCard({
    super.key,
    required this.icon,
    required this.exerciseName,
    required this.reps,
    required this.minutes,
  });

  String get rewardText {
    return '$minutes min per $reps reps';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground,
            isDark ? AppColors.cardBackgroundSecondaryDark : AppColors.cardBackgroundSecondary,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowMediumDark : AppColors.shadowLight.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [

          // Icon Box
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.8),
                  isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 30,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 16),
          
          // Exercise Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  rewardText,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppColors.textTertiaryDark : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/screens/progress/progress_page.dart';
import 'package:intl/intl.dart';

class ExerciseEntry extends StatelessWidget {
  final ExerciseHistoryEntry exercise;

  const ExerciseEntry({
    super.key,
    required this.exercise,
  });

  String get formattedTime {
    final hour = exercise.completedAt.hour;
    final minute = exercise.completedAt.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  String get formattedDate {
    return DateFormat('d. MMM').format(exercise.completedAt);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
          // Exercise icon
          Container(
            width: 40,
            height: 40,
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
              exercise.icon,
              size: 20,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          
          // Exercise details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.exerciseName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${exercise.reps} reps completed',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textTertiaryDark : AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          
          // Time earned and timestamp
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+${exercise.timeEarned} min',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.textTertiaryDark : AppColors.textGrey,
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? AppColors.textTertiaryDark : AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

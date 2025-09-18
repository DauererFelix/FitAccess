import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class AvailableTimeWidget extends StatelessWidget {
  final int availableMinutes;
  final int totalMinutes;

  const AvailableTimeWidget({
    super.key,
    required this.availableMinutes,
    this.totalMinutes = 60, // Maximum saved time in minutes
  });

  double get progressPercentage => availableMinutes / totalMinutes;

  String get timeDisplayText {
    if (availableMinutes >= 60) {
      final hours = availableMinutes ~/ 60;
      final minutes = availableMinutes % 60;
      if (minutes == 0) {
        return '${hours}h';
      }
      return '${hours}h ${minutes}m';
    }
    return '$availableMinutes min';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available Time',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),

            // Saved Time Display
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.8), // Lighter on the left
                  (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 1.0), // Darker on the right
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                timeDisplayText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Progress Bar
        Container(
          height: 8,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? AppColors.textTertiaryDark.withValues(alpha: 0.3) : Colors.grey[400],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progressPercentage.clamp(0.0, 1.0),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 1.0), // Darker on the left
                      (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.6), // Lighter on the right
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class ExperienceRatingBox extends StatelessWidget {
  final String rating;
  final VoidCallback onTap;
  final bool isSelected;

  const ExperienceRatingBox({
    super.key,
    required this.rating,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(minWidth: 86.0),
            padding: const EdgeInsets.all(12),
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
              border: Border.all(
                color: isSelected 
                  ? (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary) 
                  : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark ? AppColors.shadowMediumDark : AppColors.shadowLight.withValues(alpha: 0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: isDark ? AppColors.shadowLightDark : AppColors.shadowMedium.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              rating,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary)
                    : (isDark ? AppColors.elementTertiaryDark : AppColors.elementTertiary),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

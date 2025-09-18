import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class FeedbackCategoryItem extends StatelessWidget {
  final String category;
  final VoidCallback onTap;
  final bool isSelected;

  const FeedbackCategoryItem({
    super.key,
    required this.category,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              
              padding: const EdgeInsets.all(16),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Category text
            Text(
              category,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.elementTertiaryDark : AppColors.elementTertiary,
              ),
            ),
            // Radio button
            Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2), // Space for border
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected 
                      ? (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary) 
                      : (isDark ? AppColors.textSecondaryDark : AppColors.textGrey),
                    width: 2,
                  ),
                  color: isSelected 
                    ? (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary) 
                    : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.circle,
                        size: 10,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
          ],
        ),
            ),
          ),
        ),
      ],
    );
  }
}
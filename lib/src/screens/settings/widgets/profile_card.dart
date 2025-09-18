import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final IconData icon;

  const ProfileCard({
    super.key,
    required this.name,
    this.icon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
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
            color: isDark ? AppColors.shadowLightDark : AppColors.shadowLight,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: isDark ? AppColors.shadowMediumDark : AppColors.shadowMedium,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Giant Profile Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.8),
                  isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 50,
              color: Colors.white, // Always white on blue gradient
            ),
          ),
          const SizedBox(width: 16),
          // User Name - positioned higher
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

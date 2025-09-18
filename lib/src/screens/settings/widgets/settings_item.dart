import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? screen;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.screen,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
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
            color: isDark ? AppColors.shadowMediumDark : AppColors.shadowMedium,
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: screen != null 
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => screen!),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(12),
          splashColor: (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.1),
          highlightColor: (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Icon
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
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white, // Always white on blue gradient
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Arrow Icon
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.7),
                      isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                    ],
                  ).createShader(bounds),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white, // Use white as base for shader mask
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

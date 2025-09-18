import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class ThemeColors {
  static Color getBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.backgroundDark : AppColors.background;
  }
  
  static Color getTextPrimaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
  }
  
  static Color getTextSecondaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;
  }
  
  static Color getTextTertiaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.textTertiaryDark : AppColors.textTertiary;
  }
  
  static Color getCardBackgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.cardBackgroundDark : AppColors.cardBackground;
  }
  
  static Color getCardBackgroundSecondaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.cardBackgroundSecondaryDark : AppColors.cardBackgroundSecondary;
  }
  
  static Color getElementPrimaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary;
  }
  
  static Color getElementTertiaryColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.elementTertiaryDark : AppColors.elementTertiary;
  }
  
  static Color getShadowMediumColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.shadowMediumDark : AppColors.shadowMedium;
  }
}
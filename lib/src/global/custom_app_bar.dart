import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              icon: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    AppColors.elementPrimary.withValues(alpha: 1.0),
                    AppColors.elementPrimary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ),
            )
          : null,
      automaticallyImplyLeading: false,

      title: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: isDark 
            ? [
                // Dark mode - blue to lighter blue gradient
                AppColors.elementPrimaryDark, // Full blue
                AppColors.elementPrimaryDark.withValues(alpha: 0.9), // Slightly lighter blue
                AppColors.elementPrimaryDark.withValues(alpha: 0.8), // Even lighter blue
                AppColors.elementPrimaryDark.withValues(alpha: 0.7), // Lightest blue
              ]
            : [
                // Light mode - keep original gradient
                AppColors.elementPrimary.withValues(alpha: 1.0),
                AppColors.elementPrimary.withValues(alpha: 0.9), 
                AppColors.elementPrimary.withValues(alpha: 0.9), 
                AppColors.elementPrimary.withValues(alpha: 0.8), 
              ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).createShader(bounds),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
            color: Colors.white, // Always white for shader mask
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

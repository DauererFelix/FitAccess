import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double? width;
  final double? height;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 51,
    this.height = 31,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((height ?? 31) / 2),
          color: (isDark ? AppColors.textTertiaryDark : AppColors.textTertiary).withValues(alpha: 0.3),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: (height ?? 31) - 8, // thumb size based on height
            height: (height ?? 31) - 8,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: value 
                ? LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.8),
                      isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                    ],
                  )
                : null,
              color: value ? null : (isDark ? AppColors.textTertiaryDark : AppColors.textTertiary),
            ),
          ),
        ),
      ),
    );
  }
}
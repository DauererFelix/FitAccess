import 'package:flutter/material.dart';
import '../theme/appcolors.dart';

class InfoField extends StatelessWidget {
  final String infoText;
  final String? dialogTitle;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  final String buttonText;

  const InfoField({
    super.key,
    required this.infoText,
    this.dialogTitle = 'Instructions',
    this.icon = Icons.info_outline,
    this.iconSize = 22,
    this.iconColor,
    this.buttonText = 'Got it!',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: dialogTitle != null ? Row(
                children: [               
                  const SizedBox(width: 8),
                  Text(
                    dialogTitle!,
                    style: TextStyle(
                      color: isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ) : null,
              content: Text(
                infoText,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.elementSecondary,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.7), // Lighter blue on the left
            isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary, // Darker blue on the right
          ],
        ).createShader(bounds),
        child: Icon(
          icon,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}

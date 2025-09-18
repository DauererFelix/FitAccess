import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double height;
  final EdgeInsets padding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 56,
    this.padding = const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.elementPrimary,
              AppColors.elementPrimary.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.elementPrimary.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: AppColors.textSecondary.withValues(alpha: 0.2),
            highlightColor: AppColors.textSecondary.withValues(alpha: 0.1),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

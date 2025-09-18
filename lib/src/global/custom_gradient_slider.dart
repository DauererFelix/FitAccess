import 'package:flutter/material.dart';
import '../theme/appcolors.dart';

class CustomGradientSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double>? onChanged;
  final Color? thumbColor;
  final Color? inactiveTrackColor;
  final List<Color>? gradientColors;

  const CustomGradientSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    this.onChanged,
    this.thumbColor,
    this.inactiveTrackColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final activeGradientColors = gradientColors ?? [
      AppColors.elementPrimary.withValues(alpha: 0.6), 
      AppColors.elementPrimary, 
    ];
    
    final activeThumbColor = thumbColor ?? AppColors.elementPrimary;
    final activeInactiveTrackColor = inactiveTrackColor ?? AppColors.sliderInactive;
    
    return SizedBox(
      height: 40, // Give enough height for proper alignment
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          Positioned(
            left: 24,
            right: 24,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: activeInactiveTrackColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Gradient active track
          Positioned(
            left: 24,
            right: 24,
            child: FractionallySizedBox(
              widthFactor: (value - min) / (max - min), // Normalize to 0-1 range
              alignment: Alignment.centerLeft,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: activeGradientColors,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // Transparent slider for interaction
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              thumbColor: activeThumbColor,
              overlayColor: activeThumbColor.withValues(alpha: 0.1),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

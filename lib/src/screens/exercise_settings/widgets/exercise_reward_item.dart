import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/screens/exercise_settings/exercise_settings_page.dart';

class ExerciseRewardItem extends StatefulWidget {
  final ExerciseData exercise;
  final Function(int) onRewardChanged;

  const ExerciseRewardItem({
    super.key,
    required this.exercise,
    required this.onRewardChanged,
  });

  @override
  State<ExerciseRewardItem> createState() => _ExerciseRewardItemState();
}

class _ExerciseRewardItemState extends State<ExerciseRewardItem> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.exercise.currentReward;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Colors.white,
            Color(0xFFF5F5F5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Exercise Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  AppColors.elementPrimary.withValues(alpha: 0.8),
                  AppColors.elementPrimary,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.exercise.icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          
          // Exercise Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.exercise.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.exercise.unit,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Reward Controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Current reward value display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.elementPrimary.withValues(alpha: 0.1),
                      AppColors.elementPrimary.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_currentValue min',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.elementPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              // Slider
              SizedBox(
                width: 120,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.elementPrimary,
                    inactiveTrackColor: AppColors.elementPrimary.withValues(alpha: 0.2),
                    thumbColor: AppColors.elementPrimary,
                    overlayColor: AppColors.elementPrimary.withValues(alpha: 0.1),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                    trackHeight: 4,
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
                  ),
                  child: Slider(
                    value: _currentValue.toDouble(),
                    min: 1.0,
                    max: 5.0,
                    divisions: 4,
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value.round();
                      });
                      widget.onRewardChanged(_currentValue);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

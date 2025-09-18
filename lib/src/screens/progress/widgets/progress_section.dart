import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/screens/progress/progress_page.dart';
import 'package:fitaccess/src/screens/progress/widgets/exercise_entry.dart';

class ProgressSection extends StatefulWidget {
  final String timeframe;
  final List<ExerciseHistoryEntry> exercises;

  const ProgressSection({
    super.key,
    required this.timeframe,
    required this.exercises,
  });

  @override
  State<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends State<ProgressSection> with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late AnimationController _animationController;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    // All sections with exercises start collapsed by default
    _isExpanded = widget.exercises.isEmpty;
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _iconRotation = Tween<double>(
      begin: 0.0,
      end: 0.5, // 180 degrees (0.5 * 2π)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    if (_isExpanded) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  int get totalTimeEarned => widget.exercises.fold(0, (sum, exercise) => sum + exercise.timeEarned);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasExercises = widget.exercises.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeframe header
        GestureDetector(
          onTap: hasExercises ? _toggleExpanded : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.timeframe,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                Row(
                  children: [
                    // Expandable arrow (only if has exercises)
                    if (hasExercises) ...[
                      AnimatedBuilder(
                        animation: _iconRotation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _iconRotation.value * 2 * 3.14159,
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                              size: 28,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                    // Time earned badge (always visible)
                    Container(
                      constraints: const BoxConstraints(minWidth: 110), // enough for '99 min earned'
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha:0.8),
                            isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$totalTimeEarned min earned',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Exercise entries (expandable for certain sections)
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Column(
            children: widget.exercises.map((exercise) => ExerciseEntry(exercise: exercise)).toList(),
          ),
          secondChild: const SizedBox.shrink(),
        ),
        
        const SizedBox(height: 16),
      ],
    );
  }
}
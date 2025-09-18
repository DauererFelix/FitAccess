import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/custom_app_bar.dart';
import 'package:fitaccess/src/screens/progress/widgets/progress_section.dart';
import 'package:fitaccess/src/screens/progress/widgets/progress_graph.dart';
import 'package:fitaccess/src/theme/exercise_icons.dart';


class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late final List<ExerciseHistoryEntry> _exerciseHistory;
  late final DateTime _referenceNow;

  @override
  void initState() {
    super.initState();
    _referenceNow = DateTime.now();
    _exerciseHistory = [
      // Today
      ExerciseHistoryEntry(
        exerciseName: 'Push-ups',
        reps: 5,
        timeEarned: 2,
        completedAt: _referenceNow.subtract(const Duration(hours: 2)),
        icon: ExerciseIcons.getIcon('Push-ups'),
      ),
      ExerciseHistoryEntry(
        exerciseName: 'Jumping Jacks',
        reps: 15,
        timeEarned: 1,
        completedAt: _referenceNow.subtract(const Duration(hours: 4)),
        icon: ExerciseIcons.getIcon('Jumping Jacks'),
      ),
      // Yesterday (This Week)
      ExerciseHistoryEntry(
        exerciseName: 'Sit-ups',
        reps: 10,
        timeEarned: 2,
        completedAt: _referenceNow.subtract(const Duration(days: 1, hours: 3)),
        icon: ExerciseIcons.getIcon('Sit-ups'),
      ),
      ExerciseHistoryEntry(
        exerciseName: 'Squats',
        reps: 5,
        timeEarned: 1,
        completedAt: _referenceNow.subtract(const Duration(days: 1, hours: 6)),
        icon: ExerciseIcons.getIcon('Squats'),
      ),
      // 2 Days Ago (This Week)
      ExerciseHistoryEntry(
        exerciseName: 'Pull-ups',
        reps: 3,
        timeEarned: 6,
        completedAt: _referenceNow.subtract(const Duration(days: 2, hours: 1)),
        icon: ExerciseIcons.getIcon('Pull-ups'),
      ),
      // 4 Days Ago (This Week)
      ExerciseHistoryEntry(
        exerciseName: 'Squats',
        reps: 5,
        timeEarned: 1,
        completedAt: _referenceNow.subtract(const Duration(days: 4, hours: 1)),
        icon: ExerciseIcons.getIcon('Squats'),
      ),
      // 5 Days Ago (This Week)
      ExerciseHistoryEntry(
        exerciseName: 'Pull-ups',
        reps: 2,
        timeEarned: 4,
        completedAt: _referenceNow.subtract(const Duration(days: 5, hours: 1)),
        icon: ExerciseIcons.getIcon('Pull-ups'),
      ),
      // Last Week (10 days ago)
      ExerciseHistoryEntry(
        exerciseName: 'Push-ups',
        reps: 8,
        timeEarned: 3,
        completedAt: _referenceNow.subtract(const Duration(days: 10, hours: 2)),
        icon: ExerciseIcons.getIcon('Push-ups'),
      ),
      ExerciseHistoryEntry(
        exerciseName: 'Jumping Jacks',
        reps: 20,
        timeEarned: 2,
        completedAt: _referenceNow.subtract(const Duration(days: 12, hours: 4)),
        icon: ExerciseIcons.getIcon('Jumping Jacks'),
      ),
      // Earlier (20 days ago)
      ExerciseHistoryEntry(
        exerciseName: 'Push-ups',
        reps: 5,
        timeEarned: 2,
        completedAt: _referenceNow.subtract(const Duration(days: 20, hours: 2)),
        icon: ExerciseIcons.getIcon('Push-ups'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
  final now = _referenceNow;
  final today = DateTime(now.year, now.month, now.day);
    final currentWeekStart = today.subtract(Duration(days: now.weekday - 1));
    final lastWeekStart = currentWeekStart.subtract(const Duration(days: 7));

    // Separate lists for each timeframe
    List<ExerciseHistoryEntry> todayExercises = [];
    List<ExerciseHistoryEntry> thisWeekExercises = [];
    List<ExerciseHistoryEntry> lastWeekExercises = [];
    List<ExerciseHistoryEntry> olderExercises = [];

    // Calculate minutes earned per day for the last 7 days
    Map<DateTime, int> minutesPerDay = {};
    for (int i = 0; i < 7; i++) {
      final day = DateTime(today.year, today.month, today.day).subtract(Duration(days: 6 - i));
      minutesPerDay[day] = 0;
    }
    // add exercise to datelist
    for (final entry in _exerciseHistory) {
      final entryDate = DateTime(
        entry.completedAt.year,
        entry.completedAt.month,
        entry.completedAt.day,
      );

      if (entryDate.isAtSameMomentAs(today)) {
        todayExercises.add(entry);
      } else if (entryDate.isAfter(currentWeekStart.subtract(const Duration(days: 1))) && 
                 entryDate.isBefore(today)) {
        thisWeekExercises.add(entry);
      } else if (entryDate.isAfter(lastWeekStart.subtract(const Duration(days: 1))) && 
                 entryDate.isBefore(currentWeekStart)) {
        lastWeekExercises.add(entry);
      } else if (entryDate.isBefore(lastWeekStart)) {
        olderExercises.add(entry);
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Progress',
        showBackButton: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        children: [

          // Top Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exercise History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Track your completed exercises and earned time',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.textTertiaryDark : AppColors.textGrey,
                  ),
                ),
                const SizedBox(height: 8),

              ],
            ),
          ),
          
          // Progress graph for last 7 days
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ProgressGraph(history: _exerciseHistory),
          ),
          // Timeline sections - explicit sections
          ProgressSection(timeframe: 'Today', exercises: todayExercises),
          ProgressSection(timeframe: 'This Week', exercises: thisWeekExercises),
          if (lastWeekExercises.isNotEmpty) 
            ProgressSection(timeframe: 'Last Week', exercises: lastWeekExercises),
          if (olderExercises.isNotEmpty) 
            ProgressSection(timeframe: 'Older', exercises: olderExercises),
        ],
      ),
    );
  }
}

// Data model for exercise history entries
class ExerciseHistoryEntry {
  final String exerciseName;
  final int reps;
  final int timeEarned;
  final DateTime completedAt;
  final IconData icon;

  ExerciseHistoryEntry({
    required this.exerciseName,
    required this.reps,
    required this.timeEarned,
    required this.completedAt,
    required this.icon,
  });
}

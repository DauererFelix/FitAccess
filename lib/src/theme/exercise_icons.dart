import 'package:flutter/material.dart';

/// Centralized exercise icon mapping for consistent icons across the app
class ExerciseIcons {
  static const Map<String, IconData> _exerciseIconMap = {
    // Main exercises with original Material icons
    'Push-ups': Icons.fitness_center,
    'Jumping Jacks': Icons.accessibility_new,
    'Sit-ups': Icons.airline_seat_legroom_reduced,
    'Pull-ups': Icons.fitness_center_outlined,
    'Squats': Icons.directions_run,   
    
    // Default/Fallback
    'default': Icons.fitness_center,
  };

  /// Get the icon for a specific exercise
  /// Returns the specific icon if found, otherwise returns the default fitness icon
  static IconData getIcon(String exerciseName) {
    return _exerciseIconMap[exerciseName] ?? _exerciseIconMap['default']!;
  }

  /// Get all available exercise names
  static List<String> get availableExercises {
    return _exerciseIconMap.keys.where((key) => key != 'default').toList();
  }

  /// Check if an exercise has a specific icon
  static bool hasIcon(String exerciseName) {
    return _exerciseIconMap.containsKey(exerciseName);
  }
}

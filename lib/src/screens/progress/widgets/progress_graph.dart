import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../progress_page.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'dart:ui' as ui;

class ProgressGraph extends StatefulWidget {
  final List<ExerciseHistoryEntry> history;
  final double height;
  final double width;

  const ProgressGraph({
    super.key,
    required this.history,
    this.height = 200,
    this.width = double.infinity,
  });

  @override
  State<ProgressGraph> createState() => _ProgressGraphState();
}

class _ProgressGraphState extends State<ProgressGraph> {
  // No selection state

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final now = DateTime.now();
    final last7Days = List.generate(7, (i) => DateTime(now.year, now.month, now.day).subtract(Duration(days: 6 - i)));
    final Map<String, int> minutesPerDay = {for (var d in last7Days) DateFormat('yyyy-MM-dd').format(d): 0};
    for (final entry in widget.history) {
      final date = DateFormat('yyyy-MM-dd').format(entry.completedAt);
      if (minutesPerDay.containsKey(date)) {
        minutesPerDay[date] = (minutesPerDay[date] ?? 0) + (entry.timeEarned);
      }
    }
    final points = minutesPerDay.values.map((e) => e.toDouble()).toList();
    final maxMinutes = points.isNotEmpty ? points.reduce((a, b) => a > b ? a : b) : 1.0;

    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.85),
            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.95),
            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 1.0),
            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 1.0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _ProgressGraphPainter(
          points: points,
          maxMinutes: maxMinutes,
          dates: last7Days,
        ),
      ),
    );
  }
}

class _ProgressGraphPainter extends CustomPainter {
  final List<double> points;
  final double maxMinutes;
  final List<DateTime> dates;

  _ProgressGraphPainter({required this.points, required this.maxMinutes, required this.dates});

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final paintDot = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  final double leftPad = 8;
  final double rightPad = 48;
    final double topPad = 16;
  final double bottomPad = 28; // Reduced for less space between day text and bottom
    final double graphWidth = size.width - leftPad - rightPad;
    final double graphHeight = size.height - topPad - bottomPad;
  // (Old lines/dots drawing removed; only maxY-scaled lines/dots are drawn below)
    // Draw x axis labels (dates)
    final textStyle = TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5);
    for (int i = 0; i < dates.length; i++) {
      final x = leftPad + (i / (dates.length - 1)) * graphWidth;
      final dateStr = DateFormat('E').format(dates[i]).toUpperCase();
      final tp = TextPainter(
        text: TextSpan(text: dateStr, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout();
  tp.paint(canvas, Offset(x - tp.width / 2, size.height - bottomPad + 18)); // Move labels lower on the card
    }

    // Draw y axis labels (10min steps) and horizontal grid lines
    int step;
    if (maxMinutes < 10) {
      step = 2;
    } else if (maxMinutes < 20) {
      step = 5;
    } else if (maxMinutes < 60) {
      step = 20;
    } else if (maxMinutes > 60) {
      step = 30;
    } else {
      step = 10;
    }
    final int maxY = ((maxMinutes / step).ceil() * step).clamp(step, 9999);
    for (int y = 0; y <= maxY; y += step) {
      final yPos = topPad + graphHeight * (1 - (y / (maxY == 0 ? 1 : maxY)));
      final gridLinePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;
      final gridLineEnd = leftPad + graphWidth + 8;
      canvas.drawLine(
        Offset(leftPad, yPos),
        Offset(gridLineEnd, yPos),
        gridLinePaint,
      );
      // ...existing code...
    }

    // Draw straight lines between points
    if (points.length > 1) {
      for (int i = 0; i < points.length - 1; i++) {
        final x1 = leftPad + (i / (points.length - 1)) * graphWidth;
        final y1 = topPad + graphHeight * (1 - (points[i] / (maxY == 0 ? 1 : maxY)));
        final x2 = leftPad + ((i + 1) / (points.length - 1)) * graphWidth;
        final y2 = topPad + graphHeight * (1 - (points[i + 1] / (maxY == 0 ? 1 : maxY)));
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paintLine);
      }
    }

    // Draw dots for each point
    for (int i = 0; i < points.length; i++) {
      final x = leftPad + (i / (points.length - 1)) * graphWidth;
      final y = topPad + graphHeight * (1 - (points[i] / (maxY == 0 ? 1 : maxY)));
      canvas.drawCircle(Offset(x, y), 7, paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

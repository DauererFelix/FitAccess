import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Expanded(
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: () => onItemTapped(index),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isSelected
                    ? ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 1.0),
                            (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary).withValues(alpha: 0.7),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Icon(
                          icon,
                          size: 28,
                          color: Colors.white, 
                        ),
                      )
                    : ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            (isDark ? AppColors.elementTertiaryDark : AppColors.elementTertiary).withValues(alpha: 0.6),
                            (isDark ? AppColors.elementTertiaryDark : AppColors.elementTertiary).withValues(alpha: 0.5),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds),
                        child: Icon(
                          icon,
                          size: 28,
                          color: Colors.white, 
                        ),
                      ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isSelected 
                      ? (isDark ? AppColors.elementPrimaryDark : AppColors.elementPrimary)
                      : (isDark ? AppColors.notSelectedDark : AppColors.notSelected),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: theme.scaffoldBackgroundColor,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
                isSelected: selectedIndex == 0,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.bar_chart_rounded,
                label: 'Progress',
                index: 1,
                isSelected: selectedIndex == 1,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.grid_view_rounded,
                label: 'Apps',
                index: 2,
                isSelected: selectedIndex == 2,
                context: context,
              ),
              _buildNavItem(
                icon: Icons.settings_rounded,
                label: 'Settings',
                index: 3,
                isSelected: selectedIndex == 3,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/main_app.dart';
import 'src/theme/appcolors.dart';
import 'src/global/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Fit Access',
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.elementPrimary,
                brightness: Brightness.light,
                surface: AppColors.background,
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.backgroundDark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.elementPrimaryDark,
                brightness: Brightness.dark,
                surface: AppColors.backgroundDark,
              ),
            ),
            home: const MainApp(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fitaccess/src/theme/appcolors.dart';
import 'package:fitaccess/src/global/custom_app_bar.dart';
import 'package:fitaccess/src/screens/settings/feedback/widgets/experience_rating_box.dart';
import 'package:fitaccess/src/screens/settings/feedback/widgets/feedback_category_item.dart';
import 'package:fitaccess/src/global/custom_text_field.dart';
import 'package:fitaccess/src/global/primary_button.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int selectedRating = 0; //0 = Nothing, 1 = Poor, 2 = Fair, 3 = Good, 4 = Excellent
  int selectedCategory = 0; //0 = Nothing, 1 = AppPerformance, 2 = BugReport,  3 = Feature Request, 4= UI, 5 = Other

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Feedback', showBackButton: true),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We\'d love to hear from you',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your feedback helps us improve FitAccess.\nPlease share your thoughts and suggestions below.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Text(
                'Rate your experience',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ),
          ),

          Row(
            children: [
              ExperienceRatingBox(
                rating: "Poor",
                isSelected: selectedRating == 1,
                onTap: () {
                  setState(() {
                    selectedRating = 1;
                  });
                },
              ),
              ExperienceRatingBox(
                rating: "Fair",
                isSelected: selectedRating == 2,
                onTap: () {
                  setState(() {
                    selectedRating = 2;
                  });
                },
              ),
              ExperienceRatingBox(
                rating: "Good",
                isSelected: selectedRating == 3,
                onTap: () {
                  setState(() {
                    selectedRating = 3;
                  });
                },
              ),
              ExperienceRatingBox(
                rating: "Excellent",
                isSelected: selectedRating == 4,
                onTap: () {
                  setState(() {
                    selectedRating = 4;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 10),
          Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Text(
                'Feedback Category',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ),
          ),

          Column(
            children: [
              FeedbackCategoryItem(
                category: "App Performance",
                isSelected: selectedCategory == 1,
                onTap: () {
                  setState(() {
                    selectedCategory = 1;
                  });
                },
              ),
              const SizedBox(height: 12),
              FeedbackCategoryItem(
                category: "Bug Report",
                isSelected: selectedCategory == 2,
                onTap: () {
                  setState(() {
                    selectedCategory = 2;
                  });
                },
              ),
              const SizedBox(height: 12),
              FeedbackCategoryItem(
                category: "Feature Request",
                isSelected: selectedCategory == 3,
                onTap: () {
                  setState(() {
                    selectedCategory = 3;
                  });
                },
              ),
              const SizedBox(height: 12),
              FeedbackCategoryItem(
                category: "User Interface",
                isSelected: selectedCategory == 4,
                onTap: () {
                  setState(() {
                    selectedCategory = 4;
                  });
                },
              ),
              const SizedBox(height: 12),
              FeedbackCategoryItem(
                category: "Other",
                isSelected: selectedCategory == 5,
                onTap: () {
                  setState(() {
                    selectedCategory = 5;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 24),
          const CustomTextField(label: "Comments and Suggestions", maxLines: 5),

          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PrimaryButton(
              text: "Submit Feedback",
              onTap: () {
                // TODO: Handle feedback submission
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Thank you for your feedback!',
                      style: TextStyle(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textSecondary,
                      ),
                    ),
                    backgroundColor: isDark ? AppColors.elementPrimary : AppColors.elementPrimary,
                    duration: const Duration(seconds: 1),
                  ),
                );

                // Try using named route or ensuring single pop
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

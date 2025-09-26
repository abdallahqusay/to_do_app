import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/core/database/cashe/cashe_helper.dart';
import 'package:to_do_app/core/services/service.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/core/widgets/custom_button.dart';
import 'package:to_do_app/core/widgets/custom_text_button.dart';
import 'package:to_do_app/features/auth/data/model/on_boarding_model.dart';
import 'package:to_do_app/features/task/persentation/screens/home_screen/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: PageView.builder(
            itemCount: 3,
            controller: controller,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  index != 2
                      ?Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextButton(text: AppStrings.skip, onPressed: (){controller.jumpToPage(2);}),
                      )
                      : const SizedBox.shrink(),
                  Image.asset(OnBoardingModel.onBoardingScreens[index].imgPath),
                  const SizedBox(height: 16),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotHeight: 8,
                      spacing: 10,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    OnBoardingModel.onBoardingScreens[index].title,
                    style: GoogleFonts.lato(
                      color: AppColors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      OnBoardingModel.onBoardingScreens[index].subTitle,
                      style: GoogleFonts.lato(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 90),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        index != 0
                            ? CustomTextButton(text: AppStrings.back, onPressed: (){controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );})
                             
                            : const SizedBox.shrink(),
                        index != 2
                            ? CustomButton(text: AppStrings.next, onPressed: (){controller.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInCirc,);})
                           
                            : ElevatedButton(
                                onPressed: () async {
                                 s1< CacheHelper>()
                                      .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true,
                                      )
                                      .then((value) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ),
                                        );
                                      });
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  AppStrings.getStarted,
                                  style: GoogleFonts.lato(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

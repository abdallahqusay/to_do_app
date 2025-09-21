import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/auth/persentation/screens/onboarding/onboarding_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  void navigate(){
    Future.delayed(Duration(seconds: 3),(){
    // ignore: use_build_context_synchronously
    Navigator.push( context, MaterialPageRoute(builder: (context)=>OnboardingScreen()));
  });}

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.logo),
          SizedBox(height: 20,),
          Text(AppStrings.appName,style: GoogleFonts.lato(
            color: AppColors.white,fontSize: 40,fontWeight: FontWeight.bold
          ),)
        ],
      ),),
    );
  }
}
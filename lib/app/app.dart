import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/core/theme/theme.dart';

import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/auth/persentation/screens/splach_screen/splach_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      child: MaterialApp(
        theme: getAppTheme(),
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        darkTheme: getAppDarkTheme(),
        themeMode: ThemeMode.dark,
      
        home: SplachScreen(),
      ),
    );
  }
}

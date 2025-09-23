import 'package:flutter/material.dart';
import 'package:to_do_app/core/theme/theme.dart';

import 'package:to_do_app/core/utils/app_strings.dart';
import 'package:to_do_app/features/auth/persentation/screens/splach_screen/splach_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getAppTheme(),
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      darkTheme: getAppDarkTheme(),
      themeMode: ThemeMode.dark,

      home: SplachScreen(),
    );
  }
}

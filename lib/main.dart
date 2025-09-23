import 'package:flutter/material.dart';
import 'package:to_do_app/app/app.dart';
import 'package:to_do_app/core/database/cashe/cashe_helper.dart';
import 'package:to_do_app/core/services/service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setup();
await s1<CacheHelper>().init();
  runApp(const MyApp());
}

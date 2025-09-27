import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/database/cashe/cashe_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite.dart';

final s1 = GetIt.instance;
void setup(){
  s1.registerLazySingleton<CacheHelper>(()=>CacheHelper());
   s1.registerLazySingleton<SqfliteHelper>(()=>SqfliteHelper());
}
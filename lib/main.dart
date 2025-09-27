import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/app/app.dart';
import 'package:to_do_app/core/bloc/bloc_observer.dart';
import 'package:to_do_app/core/database/cashe/cashe_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite.dart';
import 'package:to_do_app/core/services/service.dart';
import 'package:to_do_app/features/task/persentation/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setup();
  await s1<CacheHelper>().init();
   s1<SqfliteHelper>().initDB();
  runApp(BlocProvider(create: (context) => TaskCubit()..getTasks(), child: const MyApp()));
}

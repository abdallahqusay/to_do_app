import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/database/cashe/cashe_helper.dart';
import 'package:to_do_app/core/database/sqflite_helper/sqflite.dart';
import 'package:to_do_app/core/services/service.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/features/task/data/model/task_model.dart';
import 'package:to_do_app/features/task/persentation/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  DateTime currentDate = DateTime.now();
  DateTime selctedDate = DateTime.now();

  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat(
    'hh:mm a',
  ).format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSucessState());
    } else {
      printToConsole('pickedDate == null');
      emit(GetDateErrorState());
    }
  }

  late TimeOfDay schduledTime;
  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());

    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      schduledTime = pickedStartTime;
      emit(GetStartTimeSucessState());
    } else {
      printToConsole('pickedStartTime ==null');
      schduledTime = TimeOfDay(
        hour: currentDate.hour,
        minute: currentDate.minute,
      );
      emit(GetStartTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());

    TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedEndTime != null) {
      endTime = pickedEndTime.format(context);
      emit(GetEndTimeSucessState());
    } else {
      printToConsole('pickedStartTime ==null');
      emit(GetEndTimeErrorState());
    }
  }

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGrey;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void changeCheckMarkIndex(index) {
    currentIndex = index;
    emit(ChangeCheckMarkIndexState());
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selctedDate = date;

    emit(GetSelectedDateSucessState());
    getTasks();
  }

  List<TaskModel> tasksList = [];
  void insertTask() async {
    emit(InsertTaskLoadingState());

    try {
      await s1<SqfliteHelper>().insertToDB(
        TaskModel(
          date: DateFormat.yMd().format(currentDate),
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          isCompleted: 0,
          color: currentIndex,
        ),
      );

      titleController.clear();
      noteController.clear();
      emit(InsertTaskSucessState());
      getTasks();
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

  void getTasks() async {
    emit(GetDateLoadingState());
    await s1<SqfliteHelper>()
        .getFromDB()
        .then((value) {
          tasksList = value
              .map((e) => TaskModel.fromJson(e))
              .toList()
              .where(
                (element) =>
                    element.date == DateFormat.yMd().format(selctedDate),
              )
              .toList();
          emit(GetDateSucessState());
        })
        .catchError((e) {
          printToConsole(e.toString());
          emit(GetDateErrorState());
        });
  }

  void updateTask(id) async {
    emit(UpdateTaskLoadingState());

    await s1<SqfliteHelper>()
        .updatedDB(id)
        .then((value) {
          emit(UpdateTaskSucessState());
          getTasks();
        })
        .catchError((e) {
          printToConsole(e.toString());
          emit(UpdateTaskErrorState());
        });
  }

  void deleteTask(id) async {
    emit(DeleteTaskLoadingState());

    await s1<SqfliteHelper>()
        .deleteFromDB(id)
        .then((value) {
          emit(DeleteTaskSucessState());
          getTasks();
        })
        .catchError((e) {
          printToConsole(e.toString());
          emit(DeleteTaskErrorState());
        });
  }

  bool isDark = false;
  void changeTheme() async {
    isDark = !isDark; // هيخليها العكس
    await s1<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(ChangeThemeState());
  }

  void getTheme() async {
    isDark = await s1<CacheHelper>().getData(key: 'isDark');
    emit(GetThemeState());
  }
}

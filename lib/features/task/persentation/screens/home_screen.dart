import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/utils/app_assets.dart';
import 'package:to_do_app/core/utils/app_colors.dart';
import 'package:to_do_app/core/utils/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 12),
              Text(
                AppStrings.today,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primary,
                selectedTextColor: Colors.white,
                dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                onDateChange: (date) {
                  // New date selected
                },
              ),
              SizedBox(height: 50),
              noTasks(context),
            ],
          ),
        ),
        //floatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Column noTasks(BuildContext context) {
    return Column(
              children: [
                Image.asset(AppAssets.noTasks),
                Text(
                  AppStrings.noTaskTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium!.copyWith(fontSize: 24),
                ),
                SizedBox(height: 30),
                Text(
                  AppStrings.noTaskSubTitle,
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
              ],
            );
  }
}

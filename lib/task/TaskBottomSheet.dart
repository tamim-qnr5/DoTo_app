import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/setting/MyTheme.dart';
import 'package:to_do/task/tasks.dart';

import '../providers/app_config_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedTime = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: (provider.appMode == ThemeMode.dark)
          ? MyTheme.DarkColor
          : MyTheme.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.addNewTask,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: (provider.appMode == ThemeMode.light)
                        ? MyTheme.blackColor
                        : MyTheme.whiteColor,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      onChanged: (text) {
                        title = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter the task title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(
                              color: (provider.appMode == ThemeMode.light)
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: (provider.appMode == ThemeMode.light)
                                ? MyTheme.blackColor
                                : MyTheme.whiteColor,
                          ),
                          hintText: AppLocalizations.of(context)!.enterTask),
                    ),
                    TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'please enter the task discreption';
                        }
                        return null;
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: (provider.appMode == ThemeMode.light)
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: (provider.appMode == ThemeMode.light)
                                ? MyTheme.blackColor
                                : MyTheme.whiteColor,
                          ),
                          hintText: AppLocalizations.of(context)!.enterDes),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        AppLocalizations.of(context)!.selectTime,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Center(
                      child: InkWell(
                          onTap: () {
                            showCalender();
                          },
                          child: Text(
                            '${selectedTime.day}/${selectedTime.month}/${selectedTime.year}',
                            style: Theme.of(context).textTheme.titleSmall,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        addTask();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            AppLocalizations.of(context)!.add,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: MyTheme.whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedTime = chosenDate;
      setState(() {});
    }
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Tasks tasks =
          Tasks(title: title, dateTime: selectedTime, description: description);
      FirebaseUlils.addTaskToFirestore(tasks)
          .timeout(Duration(microseconds: 500), onTimeout: () {
        print('added done');
        provider.refreshTasks();
        Navigator.pop(context);
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/setting/MyTheme.dart';
import 'package:to_do/task/tasks.dart';

import '../providers/app_config_provider.dart';

class EditTaskBottomSheet extends StatefulWidget {
  Tasks task;

  EditTaskBottomSheet({required this.task});

  @override
  State<EditTaskBottomSheet> createState() =>
      _EditTaskBottomSheetState(task: task);
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  Tasks task;

  _EditTaskBottomSheetState({required this.task});

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
                      initialValue: task.title,
                      onEditingComplete: () {
                        title = task.title!;
                      },
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
                      initialValue: task.description,
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
                          hintText: AppLocalizations.of(context)!.enterDes),
                    ),
                    InkWell(
                      onTap: () {
                        editTask();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            'edit',
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

  void editTask() {
    if (formKey.currentState?.validate() == true) {
      FirebaseUlils.EditTaskFromFirestore(
              task: task, title: title, description: description)
          .timeout(Duration(microseconds: 500), onTimeout: () {
        print('edit');
        print(task.description);
        provider.refreshTasks();
        Navigator.pop(context);
      });
    }
  }
}

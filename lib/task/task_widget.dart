import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_utils.dart';
import 'package:to_do/setting/MyTheme.dart';
import 'package:to_do/task/tasks.dart';

import '../providers/app_config_provider.dart';
import 'EditTaskBottomSheet.dart';

class task_widget extends StatelessWidget {
  Tasks tasks;

  task_widget({required this.tasks});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => EditTaskBottomSheet(
                  task: tasks,
                ));
      },
      child: Container(
        margin: EdgeInsets.all(12),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const BehindMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15)),
                onPressed: (context) {
                  FirebaseUlils.deleteTaskFromFirestore(tasks)
                      .timeout(Duration(microseconds: 500), onTimeout: () {
                    provider.refreshTasks();
                    print('deleted');
                  });
                },
                backgroundColor: MyTheme.redCplor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (provider.appMode == ThemeMode.dark)
                  ? MyTheme.DarkColor
                  : MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 4,
                  color: (tasks.isDone == false)
                      ? Theme.of(context).primaryColor
                      : MyTheme.greenColor,
                  height: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tasks.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: (tasks.isDone == false)
                                      ? Theme.of(context).primaryColor
                                      : MyTheme.greenColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tasks.description ?? '',
                            style: TextStyle(
                              color: (provider.appMode == ThemeMode.dark)
                                  ? MyTheme.whiteColor
                                  : MyTheme.blackColor,
                            )),
                      )
                    ],
                  ),
                ),
                (tasks.isDone == false)
                    ? InkWell(
                        onTap: () {
                          {
                            FirebaseUlils.IsDoneTaskFromFirestore(tasks, true)
                                .timeout(Duration(microseconds: 500),
                                    onTimeout: () {
                              print('edit');
                              print(tasks.isDone);
                              provider.refreshTasks();
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.done,
                            color: MyTheme.whiteColor,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(AppLocalizations.of(context)!.done,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: MyTheme.greenColor)),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

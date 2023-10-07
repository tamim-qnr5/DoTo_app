import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_utils.dart';
import '../task/tasks.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLang = 'en';
  ThemeMode appMode = ThemeMode.light;
  List<Tasks> taskList = [];
  DateTime selectDate = DateTime.now();

  void refreshTasks() async {
    QuerySnapshot<Tasks> querySnapshot =
        await FirebaseUlils.getTasksCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    taskList = taskList.where((tasks) {
      if (tasks.dateTime?.day == selectDate.day &&
          tasks.dateTime?.month == selectDate.month &&
          tasks.dateTime?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();

    //sort
    taskList.sort((Tasks task1, Tasks task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeLang(String newLang) {
    if (appLang == newLang) {
      return;
    }
    appLang = newLang;
    notifyListeners();
  }

  void changeMode(ThemeMode newMode) {
    if (appMode == newMode) {
      return;
    }
    appMode = newMode;
    notifyListeners();
  }

  void changeDate(DateTime newDate) {
    selectDate = newDate;
    refreshTasks();
  }
}
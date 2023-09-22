import 'dart:math';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/task_widget.dart';

import 'MyTheme.dart';
import 'app_config_provider.dart';

class tasks_tab extends StatefulWidget {


  @override
  State<tasks_tab> createState() => _tasks_tabState();
}

class _tasks_tabState extends State<tasks_tab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return  Container(
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 20,
            monthColor:(provider.appMode == ThemeMode.dark)
              ?MyTheme.whiteColor
              :MyTheme.blackColor,
            dayColor:(provider.appMode == ThemeMode.dark)
                ?MyTheme.whiteColor
                :MyTheme.blackColor,
            activeDayColor: MyTheme.whiteColor,
            activeBackgroundDayColor: Theme.of(context).primaryColor,
            dotsColor: MyTheme.whiteColor,
            selectableDayPredicate: (date) => true,
            locale: 'en',
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder:  (context,index){
                 return task_widget();
                },
              itemCount: 30,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';

import 'app_config_provider.dart';

class task_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const BehindMotion(),
          children:[
            SlidableAction(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),topLeft: Radius.circular(15)),
              onPressed: (context){},
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
                  ?MyTheme.DarkColor
                  :MyTheme.whiteColor,
              borderRadius: BorderRadius.circular(15),),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 4,
                color: Theme.of(context).primaryColor,
                height: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Task',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).primaryColor),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Des',style: TextStyle(
                        color:(provider.appMode == ThemeMode.dark)
                          ?MyTheme.whiteColor
                          :MyTheme.blackColor,
                      )),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            ],
          ),
        ),
      ),
    );
  }
}

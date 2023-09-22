import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app_config_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(

                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(

                            color:(provider.appMode == ThemeMode.light)
                                ? MyTheme.blackColor
                                : MyTheme.whiteColor,),
                        ),
                        hintStyle: TextStyle(
                          color: (provider.appMode == ThemeMode.light)
                              ? MyTheme.blackColor
                              : MyTheme.whiteColor,
                        ),
                        hintText: AppLocalizations.of(context)!.enterTask),
                  ),
                  TextFormField(

                    maxLines: 2,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                          borderSide: BorderSide(

                              color:(provider.appMode == ThemeMode.light)
                                  ? MyTheme.blackColor
                                  : MyTheme.whiteColor,),
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
                    onTap: () {},
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
}

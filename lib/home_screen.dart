import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/MyTheme.dart';
import 'package:to_do/setting_tab.dart';
import 'package:to_do/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'TaskBottomSheet.dart';
import 'app_config_provider.dart';

class Home_screen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(AppLocalizations.of(context)!.title,style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color:(provider.appMode == ThemeMode.dark)
                ?MyTheme.DarkColor
                :MyTheme.whiteColor,
            width: 4
          )
        ),
        backgroundColor: Theme.of(context).primaryColor,

        child: Icon(CupertinoIcons.add),
        onPressed: ()
        {
          showModalBottomSheet(
              context: context,
              builder: (context) => TaskBottomSheet()
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color:
        (provider.appMode == ThemeMode.dark)
          ?MyTheme.DarkColor
          :MyTheme.whiteColor,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentTab,
          onTap: (index) {
            currentTab = index;
            setState(() {
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(
              Icons.menu,
              color: (provider.appMode == ThemeMode.dark)
                  ?Theme.of(context).primaryColor
                  :MyTheme.grayColor,

            ),label: 'menu'),
            BottomNavigationBarItem(icon: Icon(
                Icons.settings,
              color: (provider.appMode == ThemeMode.dark)
                  ?Theme.of(context).primaryColor
                  :MyTheme.grayColor,
            ),label: 'setting')
          ],
        )
      ),
      body: tabs[currentTab]
    );
  }

  List<Widget> tabs = [tasks_tab(),setting_tab()];
}

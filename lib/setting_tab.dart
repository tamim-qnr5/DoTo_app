import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/MyTheme.dart';
import 'LangBottomSheet.dart';
import 'ThemeBottomSheet.dart';
import 'package:provider/provider.dart';

import 'app_config_provider.dart';

class setting_tab extends StatefulWidget {
  @override
  State<setting_tab> createState() => _setting_tabState();
}

class _setting_tabState extends State<setting_tab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showLangBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: (provider.appMode == ThemeMode.light)
                      ? MyTheme.whiteColor
                      : MyTheme.DarkColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (provider.appLang == 'ar')
                        ? AppLocalizations.of(context)!.arabic
                        : AppLocalizations.of(context)!.english,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: (provider.appMode == ThemeMode.light)
                      ? MyTheme.whiteColor
                      : MyTheme.DarkColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (provider.appMode == ThemeMode.dark)
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showLangBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LangBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheet());
  }
}

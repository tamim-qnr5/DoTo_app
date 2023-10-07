import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/setting/MyTheme.dart';

import '../providers/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color:
      (provider.appMode == ThemeMode.dark)?
      Theme.of(context).primaryColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              provider.changeMode(ThemeMode.light);
            },
            child:
            (provider.appMode == ThemeMode.light)
                ? Selected(AppLocalizations.of(context)!.light)
                :Unsected(AppLocalizations.of(context)!.light)
          ),
          InkWell(
            onTap: (){
              provider.changeMode(ThemeMode.dark);
            },
            child:
            (provider.appMode == ThemeMode.dark)
                ? Selected(AppLocalizations.of(context)!.dark)
                :Unsected(AppLocalizations.of(context)!.dark)
          )
        ],
      ),
    );
  }
  Widget Selected(String text){
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,

            style: (provider.appMode == ThemeMode.dark)
            ?Theme.of(context).textTheme.titleSmall
            :Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).primaryColor),
          ),
          Icon(Icons.done,size: 30,
              color:(provider.appMode == ThemeMode.dark)
          ?MyTheme.whiteColor
          :Theme.of(context).primaryColor
          )
        ],
      ),
    );
  }
  Widget Unsected(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

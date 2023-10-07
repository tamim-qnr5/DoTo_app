import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';
import 'MyTheme.dart';

class LangBottomSheet extends StatefulWidget {
  const LangBottomSheet({super.key});

  @override
  State<LangBottomSheet> createState() => _LangBottomSheetState();
}

class _LangBottomSheetState extends State<LangBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: (provider.appMode == ThemeMode.dark)?
      Theme.of(context).primaryColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              provider.changeLang('en');
            },
            child:
            (provider.appLang == 'en')
                ? Selected(AppLocalizations.of(context)!.english)
                :Unsected(AppLocalizations.of(context)!.english)
          ),
          InkWell(
            onTap: (){
              provider.changeLang('ar');
            },
            child:
            (provider.appLang == 'ar')
                ? Selected(AppLocalizations.of(context)!.arabic)
                :Unsected(AppLocalizations.of(context)!.arabic)
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
          Icon(Icons.done,size: 30,color: (provider.appMode == ThemeMode.dark)
              ?MyTheme.whiteColor
              :Theme.of(context).primaryColor),

        ],
      ),
    );
  }
  Widget Unsected(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,style: Theme.of(context).textTheme.titleMedium,),);
  }
}

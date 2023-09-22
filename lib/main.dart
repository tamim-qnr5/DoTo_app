import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'MyTheme.dart';
import 'app_config_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AppConfigProvider() ,
      child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      initialRoute: Home_screen.routeName,
      routes: {
        Home_screen.routeName : (context) => Home_screen(),
      },
      theme: MyTheme.LightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale:Locale(provider.appLang),
      themeMode: provider.appMode,
      darkTheme: MyTheme.DarkTheme,

    );
  }
}


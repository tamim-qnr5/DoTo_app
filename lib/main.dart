import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Login/login_screen.dart';
import 'package:to_do/home_screen.dart';
import 'package:to_do/regseter/register_screen.dart';

import 'providers/app_config_provider.dart';
import 'setting/MyTheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppConfigProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      initialRoute: Login_screen.routeName,
      routes: {
        Home_screen.routeName: (context) => Home_screen(),
        Register_screen.routeName: (context) => Register_screen(),
        Login_screen.routeName: (context) => Login_screen(),
      },
      theme: MyTheme.LightTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLang),
      themeMode: provider.appMode,
      darkTheme: MyTheme.DarkTheme,

    );
  }
}


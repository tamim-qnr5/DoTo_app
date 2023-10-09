import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_config_provider.dart';
import '../setting/MyTheme.dart';

class Custom_Form extends StatelessWidget {
  String? Function(String?)? validator;
  TextEditingController controller;
  bool isPassword = false;
  String Label;
  TextInputType KeybordType;

  Custom_Form(
      {this.KeybordType = TextInputType.text,
      required this.Label,
      required this.controller,
      this.isPassword = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: KeybordType,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                BorderSide(width: 3, color: Theme.of(context).primaryColor),
          ),
          labelStyle: TextStyle(
            color: (provider.appMode == ThemeMode.light)
                ? MyTheme.blackColor
                : MyTheme.whiteColor,
          ),
          label: Text(
            Label,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MyTheme.primeLight),
          )),
      obscureText: isPassword,
    );
  }
}

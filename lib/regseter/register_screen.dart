import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Login/login_screen.dart';

import '../components/FormFild.dart';
import '../providers/app_config_provider.dart';
import '../setting/MyTheme.dart';

class Register_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  static const String routeName = 'register';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/imgs/main_bg.png',
              width: double.infinity, fit: BoxFit.fill),
          Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                      ),
                      Custom_Form(
                        Label: 'User Name',
                        controller: nameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Custom_Form(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter email address';
                            }
                            bool emailValid = RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'please enter valid email address';
                            }
                            return null;
                          },
                          Label: 'Email',
                          KeybordType: TextInputType.emailAddress,
                          controller: emailController),
                      SizedBox(
                        height: 20,
                      ),
                      Custom_Form(
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter password';
                            }
                            return null;
                          },
                          Label: 'PassWord',
                          controller: passwordController,
                          isPassword: true),
                      SizedBox(
                        height: 20,
                      ),
                      Custom_Form(
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter password';
                          }
                          if (text != passwordController) {
                            return 'passwords are not the same';
                          }
                          return null;
                        },
                        Label: 'Confirm PassWord',
                        controller: confirmPasswordController,
                        isPassword: true,
                      ),
                      InkWell(
                        onTap: () {
                          onRegisterTap();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: MyTheme.whiteColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have Account ?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Login_screen.routeName);
                              },
                              child: Text(
                                'Log In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: MyTheme.primeLight),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  void onRegisterTap() {
    if (formKey.currentState?.validate() == true) {}
  }
}

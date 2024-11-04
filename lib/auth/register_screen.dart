import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/compnent/com_elevated_button.dart';
import 'package:todo_app/compnent/com_text_form_field.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwardController = TextEditingController();
  TextEditingController confirmedPasswardController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/splash_screen.png',
                  ),
                  height: MediaQuery.sizeOf(context).height * 0.20,
                  width: MediaQuery.sizeOf(context).width * 0.3,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ComTextFormField(
                      controller: nameController,
                      hintText: 'Name',
                      validator: (value) {
                        if (value == null || value.trim().length <= 5) {
                          return 'Your name can not be less than 5 character';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ComTextFormField(
                      controller: emailController,
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.trim().length <= 5) {
                          return 'Your email can not be less than 5 character';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ComTextFormField(
                    controller: passwardController,
                    hintText: 'Password',
                    validator: (value) {
                      if (value == null || value.trim().length <= 8) {
                        return 'Your password can not be less than 8 character';
                      }
                      return null;
                    },
                    isPassward: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ComTextFormField(
                    controller: confirmedPasswardController,
                    hintText: 'Confirm Password',
                    validator: (value) {
                      if (value == null ||
                          confirmedPasswardController.text !=
                              passwardController.text) {
                        return 'Your password not matching';
                      }
                      return null;
                    },
                    isPassward: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                      ComElevatedButton(label: 'Sign Up', onPressed: register),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  child: Text(
                    'Already have an account',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppTheme.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.register(
              name: nameController.text,
              email: emailController.text,
              password: passwardController.text)
          .then((user) {
        FirebaseFunctions.logout();
        Provider.of<UserProvider>(context, listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        print('success');
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    }
  }
}

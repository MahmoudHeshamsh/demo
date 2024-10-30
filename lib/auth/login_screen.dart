import 'package:flutter/material.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/compnent/com_elevated_button.dart';
import 'package:todo_app/compnent/com_text_form_field.dart';
import 'package:todo_app/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwardController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                  hintText: 'Passward',
                  validator: (value) {
                    if (value == null || value.trim().length <= 8) {
                      return 'Your passward can not be less than 8 character';
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
              child: ComElevatedButton(
                  label: 'Login',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                      }
                  }),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text(
                    'Dont have an account : ',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppTheme.primary
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                  },
                  child: Text(
                    'Register',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.gray),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

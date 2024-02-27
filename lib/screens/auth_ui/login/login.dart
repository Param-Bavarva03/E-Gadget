import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_project/constants/constants.dart';
import 'package:mad_project/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:mad_project/screens/auth_ui/signup/sign_up.dart';
import 'package:mad_project/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:mad_project/widgets/primary_button/primary_button.dart';
import 'package:mad_project/widgets/primary_button/top_titles/top_titles.dart';

import '../../../constants/routes.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  bool isShowPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopTitles(subtitle: "Welcome Back To App", title: "Login"),
            const SizedBox(
              height: 46.0,
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "E-Mail",
                prefixIcon: Icon(
                  Icons.email_outlined,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: password,
              obscureText: isShowPassword,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(
                  Icons.password_sharp,
                ),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )),
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            PrimaryButton(
              title: "Login",
              onPressed: () async {
                bool isValidated = loginValidation(email.text, password.text);
                if(isValidated){
                  bool isLogined = await FirebaseAuthHelper.instance
                  .login(email.text, password.text, context);
                  if(isLogined){ 
                    // ignore: use_build_context_synchronously
                    Routes.instance.pushAndRemoveUntil(
                      widget: const CustomBottomBar(), context: context);
                  }
                }
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            const Center(child: Text("Don't Have an Account?")),
            const SizedBox(
              height: 12.0,
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  Routes.instance.push(widget: const SignUp(), context:context);
                },
                child: Text(
                  "Create an Account",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

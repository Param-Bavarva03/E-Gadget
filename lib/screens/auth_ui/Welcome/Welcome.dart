import 'package:flutter/material.dart';
import 'package:mad_project/constants/asset_images.dart';
import 'package:mad_project/constants/routes.dart';
import 'package:mad_project/screens/auth_ui/login/login.dart';
import 'package:mad_project/widgets/primary_button/primary_button.dart';
import 'package:mad_project/widgets/primary_button/top_titles/top_titles.dart';

import '../signup/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitles(
                  subtitle: "Buy Any Items From App", title: "Welcome"),
              Center(child: Image.asset(AssetsImages.instance.welcomeImage)),
              const SizedBox(
                height: 30.0,
              ),
              PrimaryButton(
                title: "Login",
                onPressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
              ),
              const SizedBox(
                height: 21.0,
              ),
              PrimaryButton(
                title: "Sign Up",
                onPressed: () {
                  Routes.instance.push(widget: const SignUp(), context: context);
                },
              ),
              const SizedBox(
                height: 50.0, // Add spacing of 20 pixels
              ),
              const Center(
                child: Text(
                  "Join Us &",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color.fromARGB(255, 0, 20, 239),
                  ),
                ),
              ),
               const Center(
                child: Text(
                  "Discover Amazing Deals!",
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Color.fromARGB(255, 17, 49, 255),
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

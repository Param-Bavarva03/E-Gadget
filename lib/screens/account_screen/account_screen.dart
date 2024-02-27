import 'package:flutter/material.dart';
import 'package:mad_project/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:mad_project/screens/about_us/about_us.dart';
import 'package:mad_project/screens/change_password/change_password.dart';
import 'package:mad_project/screens/edit_profile/edit_profile.dart';
import 'package:mad_project/screens/favourite_screen/favourite_screen.dart';
import 'package:mad_project/screens/order_screen/order_screen.dart';
import 'package:mad_project/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../provider/app_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 15.0),
            appProvider.getUserInformation.image == null
                ? const Icon(
                    Icons.person_outlined,
                    size: 150,
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(appProvider.getUserInformation.image!),
                    radius: 60,
                  ),
            // const SizedBox(height: 15.0),
            Text(
              appProvider.getUserInformation.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              appProvider.getUserInformation.email,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: 130,
              child: PrimaryButton(
                title: "Edit Profile",
                onPressed: () {
                  Routes.instance
                      .push(widget: const EditProfile(), context: context);
                },
              ),
            ),
            const SizedBox(height: 25.0),
            Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const OrderScreen(), context: context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(
                        widget: const FavouriteScreen(), context: context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favourites"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const AboutUs(), context: context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About Us"),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance
                        .push(widget: const ChangePassword(), context: context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    setState(() {});
                  },
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text("Logout"),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text("Version 1.0.0"),
              ],
            ),
            const SizedBox(height: 90.0),
          ],
        ),
      ),
    );
  }
}

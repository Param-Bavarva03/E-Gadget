import 'dart:io'; // Import 'dart:io' for File class

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mad_project/models/user_model/user_model.dart';
import 'package:mad_project/provider/app_provider.dart';
import 'package:mad_project/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image; // Use File instead of File?

  void takePicture() async {
    final ImagePicker picker = ImagePicker(); // Create an ImagePicker instance
    final XFile? value =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(
            value.path); // Use File constructor to create a File from XFile
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 55, child: Icon(Icons.camera_alt)
                      // Use Image.file to display the selected image
                      ),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                    // Use Image.file to display the selected image
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText:
                  appProvider.getUserInformation.name, // Correct method call
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          PrimaryButton(
            title: "Update",
            onPressed: () async {
              UserModel userModel =
                  appProvider.getUserInformation.copyWith(name: textEditingController.text);
              appProvider.updateUserInfoFirebase(context, userModel, image);
            },
          ),
        ],
      ),
    );
  }
}

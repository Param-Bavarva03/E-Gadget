import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Padding(padding: EdgeInsets.all(12.0),
      child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod nisl nec justo tristique, vel fermentum nulla tristique. Vivamus vitae odio in ligula venenatis placerat. Proin id ligula quis nisi cursus tristique. Fusce quis tincidunt arcu. Nullam a felis sit amet erat varius tincidunt id eget metus. In hac habitasse platea dictumst. Vestibulum auctor, ligula a ultrices feugiat, justo augue malesuada arcu, at efficitur justo mi ut justo. Sed vitae velit a elit facilisis vehicula eget at arcu. Sed vel metus vel justo finibus luctus. Phasellus eu bibendum odio, in gravida arcu. Sed nec sapien quis turpis hendrerit mattis. Sed interdum velit ac nisl efficitur, at blandit felis finibus. Nullam hendrerit vel lorem id euismod. Vestibulum vitae urna eget tortor eleifend vehicula. Curabitur id tellus libero."),)
    );
  }
}
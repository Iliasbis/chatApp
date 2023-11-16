// ignore_for_file: file_names

import 'package:chat_app/responsiveText/MediumText.dart';
import 'package:chat_app/services/firebase_auth/FirebaseAuthServices.dart';
import 'package:chat_app/util/DefaultColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/Default_Button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth user = FirebaseAuth.instance;
  final FireBaseAuthService auth = FireBaseAuthService();
  void signOut() {
    
    auth.signOut();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                CupertinoIcons.person_crop_circle,
                color: Colors.deepPurple,
                size: 400,
              ),
              MediumText(text: user.currentUser!.email.toString()),
              const SizedBox(height: 20),
              DefaultButton(text: "Sign Out", onpress: signOut)
            ],
          ),
        ),
      ),
    );
  }
}

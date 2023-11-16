// ignore_for_file: file_names

import 'dart:async';
import 'package:chat_app/responsiveText/MediumText.dart';
import 'package:chat_app/responsiveText/SmallText.dart';
import 'package:chat_app/util/DefaultColors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPge extends StatefulWidget {
  const SplashPge({super.key});

  @override
  State<SplashPge> createState() => _SplashPgeState();
}

class _SplashPgeState extends State<SplashPge> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, "redirectPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "lib/assets/Animation - 1698416728516.json",
            ),
            const MediumText(
              text: "ChatMe",
              color: Colors.white,
              font: FontWeight.bold,
              size: 34,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SmallText(
                text:
                    "we provide the best messaging app with high security level and message encrypt",
                color: Colors.grey.shade400,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

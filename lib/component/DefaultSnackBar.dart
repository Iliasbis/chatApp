// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../responsiveText/SmallText.dart';
class DefaultSnackBar{
  static void showSnackBarError(BuildContext context ,String text, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(
  
        SnackBar(
          content: SmallText(
            text: text,
            color: Colors.white,
            size: 16,
          ),
          backgroundColor: color,
        ),
      );
    }
}

// ignore_for_file: file_names

import 'package:chat_app/responsiveText/MediumText.dart';
import 'package:chat_app/util/DefaultColors.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onpress;
  const DefaultButton({
    super.key,
    required this.text,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: DefaultColors.bgColor,
      ),
      child: MaterialButton(
        onPressed: onpress,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: MediumText(
          text: text,
          color: Colors.white,
          font: FontWeight.bold,
          size: 20,
        ),
      ),
    );
  }
}

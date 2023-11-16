// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultTextfield extends StatefulWidget {
  bool obscureText;
  final String hintText;
  final bool isPassword;
  final String labelText;
  final TextEditingController controller;
  DefaultTextfield({
    super.key,
    this.obscureText = false,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    required this.labelText,
  });

  @override
  State<DefaultTextfield> createState() => _DefaultTextfieldState();
}

class _DefaultTextfieldState extends State<DefaultTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          
            hintText: widget.hintText,
            labelText: widget.labelText,
            labelStyle:const TextStyle(color: Colors.deepPurple),
            filled: true,
            fillColor: Colors.transparent,
          
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    icon: Icon(
                      widget.obscureText
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      color: Colors.black,
                    ))
                : null),
      ),
    );
  }
}

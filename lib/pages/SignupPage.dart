
// ignore_for_file: file_names, use_build_context_synchronously

import 'package:chat_app/component/Default_Button.dart';
import 'package:chat_app/component/Default_Textfield.dart';
import 'package:chat_app/responsiveText/MediumText.dart';
import 'package:chat_app/responsiveText/SmallText.dart';
import 'package:chat_app/services/firebase_auth/FirebaseAuthServices.dart';
import 'package:chat_app/util/DefaultColors.dart';
import 'package:chat_app/component/DefaultSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isChecked = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void _signUp() async {
    final FireBaseAuthService auth =
        Provider.of<FireBaseAuthService>(context, listen: false);
    String userEmail = emailController.text;
    String userPassword = passwordController.text;
    User? user = await auth.signUpWithEmailAndPassword(
        userEmail.trim(), userPassword.trim(), context);
    if (user != null) {
      Navigator.pushReplacementNamed(context, "mainPage");
    } else {
      DefaultSnackBar.showSnackBarError(
          context, "Error in registration", Colors.red);
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(builder: (context, AsyncSnapshot<User?> snapshot) {
      return Scaffold(
          body: snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: height / 6),
                          MediumText(
                            text: "Create Account",
                            font: FontWeight.w800,
                            color: Colors.grey.shade800,
                            size: 34,
                          ),
                          const SizedBox(height: 20),
                          SmallText(
                            text:
                                "Fill your information below or Sign in if your already have an account",
                            color: Colors.grey.shade600,
                            size: 16,
                          ),
                          const SizedBox(height: 25),
                          Column(
                            children: [
                              const SizedBox(height: 25),
                              DefaultTextfield(
                                hintText: "Ex :Ilias Bis",
                                labelText: "Name",
                                controller: nameController,
                              ),
                              const SizedBox(height: 20),
                              DefaultTextfield(
                                hintText: "example@gmail.com",
                                labelText: "Email",
                                controller: emailController,
                              ),
                              const SizedBox(height: 20),
                              DefaultTextfield(
                                hintText: "***************",
                                labelText: "Password",
                                controller: passwordController,
                                obscureText: true,
                                isPassword: true,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  const SmallText(
                                    text: "Agree with",
                                    font: FontWeight.bold,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  SmallText(
                                    text: "Terms & Condition",
                                    size: 16,
                                    color: DefaultColors.bgColor,
                                    font: FontWeight.bold,
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SmallText(
                                    text: 'Forget Password?',
                                    color: Colors.deepPurple,
                                    font: FontWeight.bold,
                                    size: 16,
                                  )
                                ],
                              ),
                              const SizedBox(height: 28),
                              DefaultButton(
                                  text: "Sign Up",
                                  onpress: () {
                                    if (nameController.text.isNotEmpty &&
                                        emailController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty) {
                                      if (isChecked) {
                                        _signUp();
                                      } else {
                                        DefaultSnackBar.showSnackBarError(
                                          context,
                                          "Please agree to our terms & condition to continue.",
                                          Colors.red,
                                        );
                                      }
                                    } else {
                                      DefaultSnackBar.showSnackBarError(
                                          context,
                                          "All inputs are required !",
                                          Colors.red);
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(
                                text: "Already have an account ?",
                                size: 17,
                                font: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, "signin");
                                },
                                child: SmallText(
                                  text: "Sign In",
                                  size: 17,
                                  color: DefaultColors.bgColor,
                                  font: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
    });
  }
}

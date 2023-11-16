// ignore_for_file: file_names, use_build_context_synchronously

import 'package:chat_app/component/Default_Button.dart';
import 'package:chat_app/component/Default_Textfield.dart';
import 'package:chat_app/responsiveText/MediumText.dart';
import 'package:chat_app/responsiveText/SmallText.dart';
import 'package:chat_app/util/DefaultColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth/FirebaseAuthServices.dart';
import '../component/DefaultSnackBar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signIn() async {
    final FireBaseAuthService auth =
        Provider.of<FireBaseAuthService>(context, listen: false);
    String userEmail = emailController.text;
    String userPassword = passwordController.text;
    User? user = await auth.signinWithEmailAndPassword(
        userEmail.trim(), userPassword.trim(), context);
    if (user != null) {
      Navigator.pushReplacementNamed(context, "mainPage");
    } else {
      DefaultSnackBar.showSnackBarError(
          context, "Check your password and email", Colors.red);
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
                            text: "Sign In",
                            font: FontWeight.w800,
                            color: Colors.grey.shade800,
                            size: 34,
                          ),
                          const SizedBox(height: 20),
                          SmallText(
                            text: "Hi ! Welcome back, you've been missed",
                            color: Colors.grey.shade600,
                            size: 16,
                          ),
                          const SizedBox(height: 25),
                          Column(
                            children: [
                              const SizedBox(height: 25),
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
                                  text: "Sign In",
                                  onpress: () {
                                    _signIn();
                                  }),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallText(
                                text: "Don't have an account ?",
                                size: 17,
                                font: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, "signup");
                                },
                                child: SmallText(
                                  text: "Sign Up",
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

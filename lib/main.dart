import 'package:chat_app/pages/HomePage.dart';
import 'package:chat_app/pages/MainPage.dart';
import 'package:chat_app/pages/RedirectPage.dart';
import 'package:chat_app/pages/SigninPage.dart';
import 'package:chat_app/pages/SignupPage.dart';
import 'package:chat_app/pages/SplashPage.dart';
import 'package:chat_app/services/firebase_auth/FirebaseAuthServices.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDa3rONBtPJLfba1nodAAPLrlXt-EEEQis",
    appId: "1:376480778879:android:60f24561f67c00e2758d4a",
    messagingSenderId: "376480778879",
    projectId: "chatapp-3de3d",
  ));
  runApp(ChangeNotifierProvider(
    create: (_) => FireBaseAuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple.shade500,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      initialRoute: "splashScreen",
      routes: {
        "home": (context) =>const HomePage(),
        "mainPage": (context) => const MainPage(),
        "splashScreen": (context) => const SplashPge(),
        "redirectPage": (context) => const RedirectPage(),
        "signin": (context) => const SignInPage(),
        "signup": (context) => const SignUpPage(),
      },
    );
  }
}

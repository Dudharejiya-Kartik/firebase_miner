import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_miner/controller/theme_controller/theme_controller.dart';
import 'package:firebase_miner/views/signin_page/signin_page.dart';
import 'package:firebase_miner/views/signup_page/signup_page.dart';
import 'package:firebase_miner/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/home_controller/home_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (context) =>
              ThemeController(sharedPreferences: sharedPreferences),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (context) => HomeController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "/signin": (context) => SigninPage(),
        "/signup_page": (context) => SignupPage(),
      },
    );
  }
}

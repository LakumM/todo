import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/screens/home_screen.dart';
import 'package:todo/presentation/screens/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      logintoGo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assest/images/img_front_todo1.png')),
          const Text(
            'Manage Your Task',
            style: TextStyle(
                fontSize: 28,
                fontFamily: Assets.fontsMontserratRegular,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'With This Small App you Can Organize',
            style: TextStyle(
                fontSize: 18,
                fontFamily: Assets.fontsMontserratRegular,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
          const Text(
            'All Your Task And Duetis In a One',
            style: TextStyle(
                fontSize: 18,
                fontFamily: Assets.fontsMontserratRegular,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
          const Text(
            'Single App',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  logintoGo() async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString(SignInScreen.User_Email_Key);
    if (email == null) {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
}

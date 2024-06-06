import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/screens/home_screen.dart';
import 'package:todo/presentation/screens/signin_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      logintoGo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Image.asset('assest/images/img_front.png')),
            Text(
              'Manage Everything with Todo Today',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: Assets.fontsMontserratRegular,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  logintoGo() async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString(SignInScreen.User_Email_Key);
    if (email == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}

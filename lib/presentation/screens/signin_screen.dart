import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/presentation/screens/home_screen.dart';
import 'package:todo/presentation/screens/signup_screen.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  FirebaseAuth fireAuth = FirebaseAuth.instance;
  // ignore: constant_identifier_names
  static const String User_ID_Key = 'uid';
  // ignore: constant_identifier_names
  static const String User_Email_Key = 'email';

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(
                'assest/images/img_stationary_bac.jpg',
              ),
              fit: BoxFit.fitHeight)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width * 0.85,
            decoration: (BoxDecoration(
                color: const Color(0xD3FFD6D6),
                borderRadius: BorderRadius.circular(11),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.transparent, spreadRadius: 5, blurRadius: 2)
                ])),
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            child: ListView(
              children: [
                const Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                      color: Color(0xff90006f),
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4),
                )),
                mSize(),
                CusTextField(
                  controller: emailController,
                  lText: 'Email',
                ),
                mSize(),
                CusTextField(
                  controller: passController,
                  htext: 'Password',
                  lText: 'Password',
                ),
                mSize(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: 120,
                        child: CusButtons(
                            onTap: () {
                              if (emailController.text.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                try {
                                  fireAuth
                                      .signInWithEmailAndPassword(
                                          email:
                                              emailController.text.toString(),
                                          password:
                                              passController.text.toString())
                                      .then((onValue) async {
                                    ///Shared Preference
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    ///set Uid in shared Preference
                                    prefs.setString(
                                        "email", emailController.text);
                                    prefs.setString(
                                        User_ID_Key, onValue.user!.uid);
                                    Navigator.pushReplacement(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  });
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == "user-not-found") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Email is Not exist please create a account')));
                                  } else if (e.code == "wrong-password") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please Enter Correct Password')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('invalid Credential')));
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("error $e")));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter email or password')));
                              }
                            },
                            name: 'Login')),
                    SizedBox(
                        width: 120,
                        child: CusButtons(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            name: 'Signup')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mSize({double height = 16}) {
    return SizedBox(
      height: height,
    );
  }
}

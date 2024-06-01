import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/home_screen.dart';
import 'package:todo/presentation/screens/signup_screen.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

class SigninScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width * 0.850,
          decoration: (BoxDecoration(
              color: Color(0xffF7E2FF),
              borderRadius: BorderRadius.circular(11),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 1)
              ])),
          padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
          child: ListView(
            children: [
              Center(
                  child: Text(
                'Login',
                style: TextStyle(
                    color: Color(0xff90006f),
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4),
              )),
              mSize(),
              CusTextfield(
                controller: emailController,
                lText: 'Email',
              ),
              mSize(),
              CusTextfield(
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
                          onTap: () async {
                            try {
                              var cred =
                                  await fireAuth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passController.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                              print(cred);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == "user-not-found") {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Email is Not exist please create a account')));
                              } else if (e.code == "wrong-password") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Please Enter Correct Password')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('invalid Credential')));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("error ${e}")));
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
                                    builder: (context) => SignupScreen()));
                          },
                          name: 'Signup')),
                ],
              )
            ],
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

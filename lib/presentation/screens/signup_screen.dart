import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/presentation/screens/signin_Screen.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileNoController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController conPassController = TextEditingController();

  FirebaseAuth firAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.7,
          width: MediaQuery.sizeOf(context).width * 0.890,
          decoration: (BoxDecoration(
              color: Color(0xfff6e5fd),
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
                  'Signup',
                  style: TextStyle(
                      color: Color(0xff90006f),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4),
                ),
              ),
              mSize(),
              CusTextfield(
                controller: nameController,
                lText: 'Full Name',
              ),
              mSize(),
              CusTextfield(
                controller: emailController,
                lText: 'Email',
              ),
              mSize(),
              CusTextfield(
                controller: mobileNoController,
                lText: 'Mobile No.',
              ),
              mSize(),
              CusTextfield(
                controller: cityController,
                lText: 'City',
              ),
              mSize(),
              CusTextfield(
                controller: passController,
                lText: 'Password',
              ),
              mSize(),
              CusTextfield(
                controller: conPassController,
                lText: 'Confirm Password',
              ),
              mSize(),
              SizedBox(
                width: 220,
                child: CusButtons(
                  onTap: () async {
                    if (nameController.text.isEmpty &&
                        emailController.text.isEmpty &&
                        mobileNoController.text.isEmpty &&
                        cityController.text.isEmpty &&
                        passController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please Fillep all details')));
                    }
                    if (passController.text != conPassController) {
                      try {
                        var cred = await firAuth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text);
                        print(cred);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "weak-password") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('you enter weak Password')));
                          print(e.code);
                        } else if (e.code == "email-already-in-use") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Email Allredy Exist')));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Error')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Confirm Pasword not match')));
                    }
                    nameController.clear();
                    emailController.clear();
                    mobileNoController.clear();
                    cityController.clear();
                    passController.clear();
                    conPassController.clear();
                    setState(() {});
                  },
                  name: 'Create Account',
                ),
              ),
              mSize(),
              TextButton(
                child: Text(
                  'Back to Login',
                  style: TextStyle(
                      color: Color(0xff90006f),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mSize({double height = 16}) {
    return SizedBox(
      height: 16,
    );
  }
}

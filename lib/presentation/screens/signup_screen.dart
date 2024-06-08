import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/domain/model/user_model.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

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

  ///Get instance to Firebase Authentication
  FirebaseAuth firAuth = FirebaseAuth.instance;

  /// Get Instance to firebase FireStore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///Collection reference
  late CollectionReference colRefs;

  @override
  Widget build(BuildContext context) {
    colRefs = firestore.collection('user');
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
            height: MediaQuery.sizeOf(context).height * 0.78,
            width: MediaQuery.sizeOf(context).width * 0.89,
            decoration: (BoxDecoration(
                color: const Color(0xD3FFD6D6),
                borderRadius: BorderRadius.circular(11),
                boxShadow: const [
                  BoxShadow(color: Colors.transparent, spreadRadius: 3)
                ])),
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
            child: ListView(
              children: [
                const Center(
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
                CusTextField(
                  controller: nameController,
                  lText: 'Full Name',
                ),
                mSize(),
                CusTextField(
                  controller: emailController,
                  lText: 'Email',
                ),
                mSize(),
                CusTextField(
                  controller: mobileNoController,
                  lText: 'Mobile No.',
                ),
                mSize(),
                CusTextField(
                  controller: cityController,
                  lText: 'City',
                ),
                mSize(),
                CusTextField(
                  controller: passController,
                  lText: 'Password',
                ),
                mSize(),
                CusTextField(
                  controller: conPassController,
                  lText: 'Confirm Password',
                ),
                mSize(),

                ///Events run hear
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
                            const SnackBar(
                                content: Text('Please Fill-up all details')));
                      }
                      if (passController.text == conPassController.text) {
                        /// Check user Credentials
                        try {
                          var cred =
                              await firAuth.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text);

                          /// Add user Data in FireStore
                          UserModel userDetail = UserModel(
                              name: nameController.text,
                              email: emailController.text,
                              mobile: mobileNoController.text,
                              city: cityController.text);
                          firestore
                              .collection('user')
                              .doc(cred.user!.uid)
                              .set(userDetail.todoc())
                              .then((onValue) {
                            nameController.clear();
                            emailController.clear();
                            mobileNoController.clear();
                            cityController.clear();
                            passController.clear();
                            conPassController.clear();
                            Navigator.pop(context);
                          });
                        } on FirebaseAuthException catch (e) {
                          /// If Password Is To-Weak
                          if (e.code == "weak-password") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('you enter weak Password')));
                          }

                          /// If Email is Already exist
                          else if (e.code == "email-already-in-use") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Email Allredy Exist')));
                            emailController.clear();
                          }
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error')));
                        }
                      }

                      ///If Confirm Password Not match
                      else {
                        passController.clear();
                        conPassController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Confirm Pasword not match')));
                      }

                      /// TextField Clear
                      setState(() {});
                    },
                    name: 'Create Account',
                  ),
                ),

                mSize(),

                /// Back To LoginPage
                TextButton(
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(
                        color: Color(0xff90006f),
                        fontSize: 16,
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
      ),
    );
  }

  /// Custom SizedBox Widget
  Widget mSize({double height = 16}) {
    return const SizedBox(
      height: 16,
    );
  }
}

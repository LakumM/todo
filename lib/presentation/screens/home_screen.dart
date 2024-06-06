import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/screens/signin_Screen.dart';
import 'package:todo/presentation/screens/task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? uId;
  String? email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference colRefs;
  bool? ischecked = false;
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  /// Get User form shared Preference
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uId = prefs.getString(SignInScreen.User_ID_Key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    colRefs = firestore.collection('user').doc(uId).collection('todos');
    return Scaffold(
      backgroundColor: Color(0xffcdbbe1),
      appBar: AppBar(
        title: Text(
          'TODO',
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontFamily: Assets.fontsMontserratRegular,
              fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff90006f),
      ),
      body: StreamBuilder(
        stream: colRefs.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                var mData = snapshot.data!.docs[index].data();
                var eachModel =
                    TodoModel.formDoc(mData as Map<String, dynamic>);

                /// Main Container
                return Container(
                  margin: EdgeInsets.only(top: 10, right: 12, left: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                            blurStyle: BlurStyle.solid,
                            spreadRadius: 1,
                            blurRadius: 2,
                            color: Colors.transparent),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///Chaked Box
                      Checkbox(
                          activeColor: Colors.blue,
                          checkColor: Colors.red,
                          value: mData['isCompleted'],
                          onChanged: (bool? value) {
                            setState(() {
                              mData['isCompleted'] = value!;
                            });
                            log(mData['isCompleted'].toString());
                          }),

                      /// title & Description
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eachModel.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: Assets.fontsMontserratRegular),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              eachModel.desc,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: Assets.fontsMontserratRegular),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Text('Complete'), Text('Complete')],
                            ),
                          ],
                        ),
                      ),

                      /// Edit & Delete Button
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              iconSize: 28,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskScreen()));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              iconSize: 28,
                              onPressed: () {
                                colRefs
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete()
                                    .then((onValue) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('done')));
                                });
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          ;
          return Container();
        },
      ),

      /// Goto Add Todo Page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TaskScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

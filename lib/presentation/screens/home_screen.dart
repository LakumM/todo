import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/screens/signin_screen.dart';
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

  var dtFormat = DateFormat.yMd().add_jm();
  @override
  Widget build(BuildContext context) {
    colRefs = firestore.collection('user').doc(uId).collection('todos');
    return Scaffold(
      backgroundColor: const Color(0xD3FFD6D6),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.getString(SignInScreen.User_Email_Key);
                prefs.remove(SignInScreen.User_Email_Key);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
                setState(() {});
              },
              icon: Icon(
                Icons.logout_outlined,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: const Text(
          'TODO',
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontFamily: Assets.fontsMontserratRegular,
              fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffb2711a),
      ),
      body: StreamBuilder(
        stream: colRefs.snapshots(),
        builder: (context, snapshot) {
          /// connection is waiting mode
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// has any error
          if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          }

          ///Data has Successes
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                var mData = snapshot.data!.docs[index].data();
                var eachModel =
                    TodoModel.formDoc(mData as Map<String, dynamic>);

                /// Main Container
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  margin: const EdgeInsets.only(top: 10, right: 12, left: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: mData['isCompleted']
                          ? Color(0xFFFC7272)
                          : const Color(0X90ffffff),
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.solid,
                            spreadRadius: 3,
                            blurRadius: 1,
                            color: Colors.white30),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ///Chaked Box
                      Checkbox(
                          activeColor: Color(0xb6dbe2ff),
                          checkColor: Colors.red,
                          value: mData['isCompleted'],
                          onChanged: (newValue) {
                            colRefs.doc(snapshot.data!.docs[index].id).update(
                                {"isCompleted": newValue}).then((value) {});
                            setState(() {});
                          }),
                      Stack(
                        children: [
                          /// title & Description
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.64,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eachModel.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      fontFamily:
                                          Assets.fontsMontserratRegular),
                                ),
                                Text(
                                  eachModel.desc,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily:
                                          Assets.fontsMontserratRegular),
                                ),

                                /// time Stamp
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(dtFormat.format(DateTime
                                        .fromMillisecondsSinceEpoch(int.parse(
                                            eachModel.creatdAt.toString())))),
                                    const Text('Complete')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
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
                                        builder: (context) =>
                                            const TaskScreen()));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              iconSize: 28,
                              onPressed: () {
                                colRefs
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete()
                                    .then((onValue) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('done')));
                                });
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),

      /// Goto Add Todo Page
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TaskScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

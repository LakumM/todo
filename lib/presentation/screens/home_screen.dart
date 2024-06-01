import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/presentation/screens/signin_Screen.dart';
import 'package:todo/presentation/screens/task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? uId;
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

  @override
  Widget build(BuildContext context) {
    colRefs = firestore.collection('user').doc(uId).collection('todos');
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
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
                return ListTile(
                  title: Text(eachModel.title),
                  subtitle: Text(eachModel.desc),
                );
              },
            );
          }
          ;
          return Container();
        },
      ),
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

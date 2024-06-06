import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/screens/signin_Screen.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? uId;
  late CollectionReference calRefs;
  @override
  void initState() {
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    uId = prefes.getString(SignInScreen.User_ID_Key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    calRefs = fireStore.collection('user').doc(uId).collection('todos');
    return Scaffold(
      backgroundColor: Color(0xffcdbbe1),
      appBar: AppBar(
        title: Text(
          'Add Your Task',
          style: TextStyle(
              color: Color(0xffffffff),
              fontFamily: Assets.fontsMontserratRegular,
              fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff90006f),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(children: [
          CusTextfield(
            controller: titleController,
            fColor: Colors.white,
            lText: 'Title',
          ),
          mSize(),
          CusTextfield(
            controller: descController,
            fColor: Colors.white,
            lText: 'Description',
          ),
          mSize(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 120,
                child: CusButtons(
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        TodoModel todoModel = TodoModel(
                            desc: descController.text,
                            title: titleController.text,
                            isCompleted: true);
                        calRefs.add(todoModel.toDoc());

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill all details')));
                      }
                    },
                    name: 'Add'),
              ),
              SizedBox(
                  width: 120, child: CusButtons(onTap: () {}, name: 'Cancle')),
            ],
          ),
        ]),
      ),
    );
  }

  Widget mSize({double height = 16}) {
    return SizedBox(
      height: height,
    );
  }
}

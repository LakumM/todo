import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/domain/model/todo_model.dart';
import 'package:todo/generated/assets.dart';
import 'package:todo/presentation/screens/signin_screen.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? uId;
  late CollectionReference calRefs;

  ///init State
  @override
  void initState() {
    super.initState();
    getUid();
  }

  /// Get Uid To Firebase FireStore though Login_Page
  getUid() async {
    SharedPreferences prefes = await SharedPreferences.getInstance();
    uId = prefes.getString(SignInScreen.User_ID_Key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    calRefs = fireStore.collection('user').doc(uId).collection('todos');
    return Scaffold(
      backgroundColor: const Color(0xD3FFD6D6),
      appBar: AppBar(
        title: const Text(
          'Add Your Task',
          style: TextStyle(
              color: Color(0xffffffff),
              fontFamily: Assets.fontsMontserratRegular,
              fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffb2711a),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(children: [
          CusTextField(
            controller: titleController,
            fColor: Colors.white,
            lText: 'Title',
          ),
          mSize(),
          TextFormField(
              style: const TextStyle(
                  color: Color(0xff90006f),
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
              controller: descController,
              maxLines: 2,
              maxLength: 50,
              decoration: InputDecoration(
                label: const Text(
                  'Description',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xff90006f),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: const BorderSide(color: Color(0xfff9e5F5))),
              )),

          /*CusTextfield(
            controller: descController,
            fColor: Colors.white,
            lText: 'Description',
          ),*/
          mSize(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 120,
                child: CusButtons(
                    backColor: Color(0xffb2711a),
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          descController.text.isNotEmpty) {
                        TodoModel todoModel = TodoModel(
                            desc: descController.text,
                            title: titleController.text,
                            isCompleted: false,
                            creatdAt: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString());
                        calRefs.add(todoModel.toDoc());

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all details')));
                      }
                    },
                    name: 'Add'),
              ),
              SizedBox(
                  width: 120,
                  child: CusButtons(
                      backColor: Color(0xffb2711a),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      name: 'Cancle')),
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

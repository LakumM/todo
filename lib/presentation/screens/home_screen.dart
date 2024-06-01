import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_buttons.dart';
import 'package:todo/presentation/utility/cust_widgets/cus_textfield_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
        centerTitle: true,
      ),
      body: Container(
        child: CusButtons(
          onTap: () {},
          name: 'Login',
        ),

        /*CusTextfield(
          controller: TextEditingController(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),*/
      ),
    );
  }
}

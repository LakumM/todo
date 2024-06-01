import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CusTextfield extends StatelessWidget {
  var controller;
  String htext;
  String lText;

  CusTextfield({required this.controller, this.htext = "", this.lText = ""});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: htext,
          label: Text(
            lText,
            style: TextStyle(color: Color(0xff90006f)),
          ),
          filled: true,
          fillColor: Color(0xFFDAB5D8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: BorderSide(color: Color(0xfff9e5F5))),
        ));
  }
}

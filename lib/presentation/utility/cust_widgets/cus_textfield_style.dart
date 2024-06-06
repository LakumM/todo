import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CusTextfield extends StatelessWidget {
  var controller;
  String htext;
  String lText;
  Color fColor;

  CusTextfield(
      {required this.controller,
      this.htext = "",
      this.lText = "",
      this.fColor = const Color(0xFFDAB5D8)});

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
          fillColor: fColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: BorderSide(color: Color(0xfff9e5F5))),
        ));
  }
}

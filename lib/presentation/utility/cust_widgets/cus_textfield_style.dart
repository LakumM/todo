import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CusTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var controller;
  String htext;
  String lText;
  Color fColor;

  CusTextField(
      {super.key,
      required this.controller,
      this.htext = "",
      this.lText = "",
      this.fColor = const Color(0xffdab1b1)});

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: const TextStyle(
            color: Color(0xff90006f),
            fontWeight: FontWeight.w400,
            fontSize: 18),
        controller: controller,
        decoration: InputDecoration(
          hintText: htext,
          label: Text(
            lText,
            style: const TextStyle(
                color: Color(0xff90006f),
                fontWeight: FontWeight.w400,
                fontSize: 18),
          ),
          filled: true,
          fillColor: fColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: const BorderSide(color: Color(0xff850068))),
        ));
  }
}

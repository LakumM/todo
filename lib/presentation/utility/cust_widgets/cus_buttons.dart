import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CusButtons extends StatelessWidget {
  VoidCallback onTap;
  String name;
  Color forColor;
  Color backColor;

  CusButtons(
      {super.key,
      required this.onTap,
      required this.name,
      this.backColor = const Color(0xff90006f),
      this.forColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: forColor,
          backgroundColor: backColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11), side: BorderSide.none),
          shadowColor: Colors.pink,
          elevation: 0.4),
      onPressed: onTap,
      child: Text(
        name,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3),
      ),
    );
  }
}

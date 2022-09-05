// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'constants.dart';

class RounderButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final Color textColor;
  final double bordeReduis;
  final double vertical, horizontal;
  final double width;
  const RounderButton({
    Key? key,
    required this.text,
    required this.press,
    required this.bordeReduis,
    required this.vertical,
    required this.horizontal,
    required this.width,
    this.color = KPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(bordeReduis),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
        onPressed: press(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          backgroundColor: color,
        ),
      ),
    );
  }
}

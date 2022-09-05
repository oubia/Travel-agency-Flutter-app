import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';

class AppButton extends StatelessWidget {
  String? text;
  IconData? icon;
  final Color color;
  final Color background;
  double size;
  final Color borderColor;
  bool isIcon;
  AppButton({
    Key? key,
    this.isIcon = false,
    this.text,
    this.icon,
    required this.color,
    required this.background,
    required this.borderColor,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15),
        color: background,
      ),
      child: isIcon == false
          ? Center(
              // ignore: prefer_const_constructors
              child: Text(text!, style: TextStyle(color: color)),
            )
          : Icon(icon, color: color),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'bodylogin.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyLogin(),
    );
  }
}

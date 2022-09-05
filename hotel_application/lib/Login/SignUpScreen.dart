// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: unused_import
import 'bodylogin.dart';
import 'bodysingup.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Bodysignup(),
    );
  }
}

// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:provider/provider.dart';

import '../Components/rounded_button.dart';
import 'Authentication/Auth_methods.dart';
import 'background.dart';
import 'SignUpScreen.dart';

class BodyLogin extends StatefulWidget {
  const BodyLogin({Key? key}) : super(key: key);
  @override
  _BodyLogin createState() => _BodyLogin();
}

class _BodyLogin extends State<BodyLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwoedController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwoedController.dispose();
  }

  void loginUser() async {
    context.read<FirebaseAuthMethods>().loginUpWithEmail(
        email: emailController.text,
        password: passwoedController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Text(
              "WELCOME TO OPLA",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            TextFieldContainer(
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: KPrimaryColor,
                    ),
                    hintText: "Your Email"),
              ),
            ),
            TextFieldContainer(
              child: TextField(
                obscureText: true,
                controller: passwoedController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: KPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.password,
                    color: KPrimaryColor,
                  ),
                  hintText: "Password",
                ),
              ),
            ),
            RounderButton(
              text: "LOGIN",
              press: () => loginUser,
              bordeReduis: 29,
              vertical: 10,
              horizontal: 0,
              width: size.width * 0.8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  "Don't have an Account?",
                  style: TextStyle(
                    color: KPrimaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: KPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: KPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

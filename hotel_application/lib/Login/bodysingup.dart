// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Login/Authentication/Auth_methods.dart';
import 'package:provider/provider.dart';

import '../Components/rounded_button.dart';
import 'background.dart';
import 'Login.dart';

class Bodysignup extends StatefulWidget {
  const Bodysignup({Key? key}) : super(key: key);
  @override
  _Bodysignup createState() => _Bodysignup();
}

class _Bodysignup extends State<Bodysignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwoedController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwoedController.dispose();
  }

  void singUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: emailController.text,
        password: passwoedController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BackGround(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/undraw_welcome_cats_thqn.svg",
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
                controller: passwoedController,
                obscureText: true,
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
              text: "SIGN UP",
              press: () => singUpUser,
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
                  "Already have an Account?",
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
                          return Login();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: KPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Devider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconsrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconsrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconsrc: "assets/icons/google-plus.svg",
                  press: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithGoogle(context);
                  },
                )
              ],
            ),
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

class Devider extends StatelessWidget {
  const Devider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(children: <Widget>[
        buildDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "OR",
            style: TextStyle(
              color: KPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        buildDivider(),
      ]),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: KPrimaryColor,
        height: 1.5,
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String iconsrc;
  final Function press;
  const SocialIcon({
    Key? key,
    required this.iconsrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: KPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconsrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

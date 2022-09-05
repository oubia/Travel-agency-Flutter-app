import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Login/Authentication/Auth_methods.dart';
import 'package:hotel_application/Login/Login.dart';
import 'package:hotel_application/Login/SignUpScreen.dart';
import 'package:hotel_application/Screens/User/home_screen.dart';
import 'package:provider/provider.dart';
import 'Components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hotel Application',
          theme: ThemeData(
              primaryColor: KPrimaryColor,
              scaffoldBackgroundColor: Colors.white),
          home: const AuthWrapper(),
          routes: {
            '/login': (context) => Login(),
            '/signup': (context) => SignUp()
          }),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return HomeScreen();
    }
    return Login();
  }
}

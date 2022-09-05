import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Screens/Admin/AddReservation.dart';
import 'package:hotel_application/Screens/Admin/Dashboard.dart';
import 'package:hotel_application/Screens/Admin/History.dart';
import 'package:hotel_application/Screens/Admin/ListOfReservationToremove.dart';

class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminHomeScreen> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    AdminDash(),
    AddReservation(),
    ListOfReservationToremove(),
    History(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.add, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.history, size: 30),
    ];
    return SafeArea(
      top: false,
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: KPrimaryColor)),
          child: CurvedNavigationBar(
            key: navigationKey,
            color: KPrimaryLightColor,
            buttonBackgroundColor: KPrimaryLightColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            // ignore: prefer_const_constructors
            animationDuration: Duration(milliseconds: 300),
            height: 50,
            index: index,
            items: items,
            onTap: (index) => setState(() => this.index = index),
          ),
        ),
      ),
    );
  }
}

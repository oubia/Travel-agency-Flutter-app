import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Screens/User/DashBoard.dart';
import 'package:hotel_application/Screens/User/Favorite.dart';
import 'package:hotel_application/Screens/User/PaddingList.dart';
import 'package:hotel_application/Screens/User/Profiel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  final screens = [
    DashBoard(),
    Favorite(),
    PaddingList(),
    Profiel(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.favorite, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.person, size: 30),
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

// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Data/GetData.dart';
import 'package:hotel_application/Login/background.dart';
import 'package:hotel_application/Model/Favorite.dart';
import 'package:hotel_application/Model/Trip.dart';
import 'package:hotel_application/Screens/User/Details.dart';
import 'package:hotel_application/Screens/User/Profiel.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        inputData();
      },
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? KPrimaryColor : KPrimaryLightColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 15.0,
          color: _selectedIndex == index ? KPrimaryLightColor : KPrimaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Profiel();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.person,
                color: KPrimaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: KPrimaryColor.withOpacity(0.1),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 100.0),
              child: Text(
                'Where would you like to go?',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildIcon(map.key),
                  )
                  .toList(),
            ),
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0, right: 165, top: 20),
                  child: Text(
                    'Top destination',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                // getData(),

                Container(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: CardList(
                        context: context,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void inputData() {}
}

class CardList extends StatelessWidget {
  CardList({
    Key? key,
    required this.context,
  }) : super(key: key);
  String getEmail() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    return (user!.email).toString();

    // here you write the codes to input the data into firestore
  }

  static Stream<List<Trip>> getTrips() =>
      FirebaseFirestore.instance.collection("Trip").snapshots().map(
          (snap) => snap.docs.map((doc) => Trip.fromJson(doc.data())).toList());
  final BuildContext context;
  Widget buildInterface(Trip trip) {
    var flag = true;
    Color colorR = KPrimaryLightColor;
    return GestureDetector(
      // ignore: prefer_const_constructors
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Detials(
                country: trip.country,
                date_end: trip.date_end,
                date_start: trip.date_start,
                description: trip.description,
                imgUrl: trip.imgUrl,
                location: trip.location,
                price: trip.price,
                title: trip.title,
              );
            },
          ),
        );
      },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    trip.imgUrl,
                  ),
                ),
                Positioned(
                  top: 15,
                  right: 15,
                  child: GestureDetector(
                    onTap: () {
                      if (flag = true) {
                        colorR = KPrimaryColor;
                        flag = false;
                        FavoriteClass(
                          email: getEmail(),
                          country: trip.country,
                          date_end: trip.date_end,
                          date_start: trip.date_start,
                          description: trip.description,
                          imgUrl: trip.imgUrl,
                          location: trip.location,
                          price: trip.price,
                          title: trip.title,
                        ).addTofavorite(trip: trip);
                      } else {
                        colorR = KPrimaryLightColor;
                        flag = true;
                        print(colorR);
                      }
                    },
                    child: Container(
                      color: null,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Color.fromARGB(100, 255, 255, 255),
                        ),
                        color: Color.fromARGB(100, 255, 255, 255),
                      ),
                      child: Icon(Icons.favorite_border, color: colorR),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // ignore: unnecessary_string_interpolations
                  "${trip.location}",
                  // ignore: unnecessary_const
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${trip.price}",
                  // ignore: unnecessary_const
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "from ${trip.date_start}",
                  // ignore: unnecessary_const
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "To ${trip.date_end}",
                  // ignore: unnecessary_const
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: KPrimaryColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${trip.location},${trip.country}",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: KPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<Trip>>(
        stream: getTrips(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("something went wrong${snapshot.error}");
          } else if (snapshot.hasData) {
            final trip = snapshot.data!;
            return ListView(
              shrinkWrap: false, //just set this property
              padding: const EdgeInsets.all(1.0),
              children: trip.map(buildInterface).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

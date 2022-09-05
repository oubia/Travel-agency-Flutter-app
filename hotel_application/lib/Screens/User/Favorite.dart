// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Model/Favorite.dart';
import 'package:hotel_application/Model/Trip.dart';
import 'package:hotel_application/Screens/User/DashBoard.dart';
import 'package:hotel_application/Screens/User/Details.dart';

class Favorite extends StatefulWidget {
  Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30, right: 40, top: 10),
              // ignore: prefer_const_constructors
              child: Text(
                'Your favorite destinations',
                style: const TextStyle(
                  fontSize: 20,
                  color: KPrimaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: KPrimaryColor.withOpacity(0.1),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Column(
              children: <Widget>[
                // CardList(trip: trip),
                CardView(), // CardList(),
                // CardList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  CardView({Key? key}) : super(key: key);
  static Stream<List<FavoriteClass>> getTrips() => FirebaseFirestore.instance
      .collection("Favorite")
      .snapshots()
      .map((snap) =>
          snap.docs.map((doc) => FavoriteClass.fromJson(doc.data())).toList());
  late BuildContext context;
  @override
  Widget buildInterface(FavoriteClass favoriteClass) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image(image: AssetImage("${favoriteClass.imgUrl}")),
              title: Text('${favoriteClass.location},${favoriteClass.country}'),
              subtitle: Text(
                  'from ${favoriteClass.date_start} to ${favoriteClass.date_end}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Book'),
                  style: TextButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Detials(
                            country: favoriteClass.country,
                            date_end: favoriteClass.date_end,
                            date_start: favoriteClass.date_start,
                            description: favoriteClass.description,
                            imgUrl: favoriteClass.imgUrl,
                            location: favoriteClass.location,
                            price: favoriteClass.price,
                            title: favoriteClass.title,
                          );
                        },
                      ),
                    );
                  },
                ),
                Container(
                  child: GestureDetector(
                    onTap: () async {
                      CollectionReference clr =
                          FirebaseFirestore.instance.collection("Favorite");
                      QuerySnapshot spq = await clr.get();
                      spq.docs[0].reference.delete();
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
                      child: Icon(Icons.favorite_border, color: KPrimaryColor),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<List<FavoriteClass>>(
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

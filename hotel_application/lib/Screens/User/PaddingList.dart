// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Model/Pandding_reservation.dart';

class PaddingList extends StatefulWidget {
  PaddingList({Key? key}) : super(key: key);

  @override
  State<PaddingList> createState() => _PaddingListState();
}

class _PaddingListState extends State<PaddingList> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 20,
            ),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'My Orders',
                  style: TextStyle(
                    color: KPrimaryColor,
                    fontSize: 27,
                    fontFamily: 'Nunito',
                  ),
                ),
                Divider(
                  thickness: 2.5,
                ),
                SizedBox(
                  height: 10,
                ),
                CardView(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);
  static Stream<List<PanddingReservation>> getTrips() =>
      FirebaseFirestore.instance
          .collection("Padding_Reservations")
          .snapshots()
          .map((snap) => snap.docs
              .map((doc) => PanddingReservation.fromJson(doc.data()))
              .toList());
  @override
  Widget buildInterface(PanddingReservation panddingReservation) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading:
                  Image(image: AssetImage("${panddingReservation.imgUrl}")),
              title: Text(
                  '${panddingReservation.location},${panddingReservation.country}'),
              subtitle: Text(
                  'from ${panddingReservation.date_start} to ${panddingReservation.date_end}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                    print("----------------${panddingReservation}-");
                    CollectionReference clr = FirebaseFirestore.instance
                        .collection("Padding_Reservations");
                    QuerySnapshot spq = await clr.get();
                    spq.docs[0].reference.delete();
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('Approved/Padding'),
                  style: TextButton.styleFrom(primary: Colors.green),
                  onPressed: () {},
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
      child: StreamBuilder<List<PanddingReservation>>(
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

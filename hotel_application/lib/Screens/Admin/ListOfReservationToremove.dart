import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Model/Approved_Reservation.dart';
import 'package:hotel_application/Model/Trip.dart';

class ListOfReservationToremove extends StatelessWidget {
  const ListOfReservationToremove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Trip',
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
  static Stream<List<Trip>> getTrips() =>
      FirebaseFirestore.instance.collection("Trip").snapshots().map(
          (snap) => snap.docs.map((doc) => Trip.fromJson(doc.data())).toList());

  @override
  Widget buildInterface(Trip trip) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image(image: AssetImage("${trip.imgUrl}")),
              title: Text('${trip.location},${trip.country}'),
              subtitle: Text(
                  'from ${trip.date_start} to ${trip.date_end}\n ${trip.title}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Delete'),
                  style: TextButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                    print("----------------${trip}-");
                    CollectionReference clr =
                        FirebaseFirestore.instance.collection("Trip");
                    QuerySnapshot spq = await clr.get();
                    spq.docs[0].reference.delete();
                  },
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

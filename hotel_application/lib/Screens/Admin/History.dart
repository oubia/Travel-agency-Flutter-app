import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Model/Approved_Reservation.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

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
                  'Approved',
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
  static Stream<List<Approved>> getTrips() => FirebaseFirestore.instance
      .collection("Approved")
      .snapshots()
      .map((snap) =>
          snap.docs.map((doc) => Approved.fromJson(doc.data())).toList());

  @override
  Widget buildInterface(Approved approved) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              // ignore: unnecessary_string_interpolations
              leading: Image(image: AssetImage("${approved.imgUrl}")),
              title: Text('${approved.location},${approved.country}'),
              subtitle: Text(
                  'from ${approved.date_start} to ${approved.date_end}\n ${approved.email}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                TextButton(
                    child: const Text('Approved'),
                    style: TextButton.styleFrom(primary: Colors.green),
                    onPressed: () {}),
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
      child: StreamBuilder<List<Approved>>(
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

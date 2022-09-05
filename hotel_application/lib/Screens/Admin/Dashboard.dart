import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Components/showSnackBar.dart';
import 'package:hotel_application/Model/Approved_Reservation.dart';
import 'package:hotel_application/Model/Pandding_reservation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:http/http.dart' as http;

class AdminDash extends StatefulWidget {
  AdminDash({Key? key}) : super(key: key);

  @override
  State<AdminDash> createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
  Widget _bulidCard(
      {required IconData icon,
      required int counter,
      required String name,
      required BuildContext context}) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                counter.toString(),
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: KPrimaryColor,
            indicatorWeight: 3,
            unselectedLabelColor: KPrimaryColor,
            tabs: [
              Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 20,
                  color: KPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "reservations",
                style: TextStyle(
                  fontSize: 20,
                  color: KPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Amin Home',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          child: TabBarView(
            children: [
              Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    _bulidCard(
                        context: context,
                        icon: Icons.person,
                        counter: 3,
                        name: "Users"),
                    _bulidCard(
                        context: context,
                        icon: Icons.person,
                        counter: 1,
                        name: "Padding"),
                  ],
                ),
              ),
              Container(
                child: GridView.count(
                  crossAxisCount: 1,
                  children: [
                    CardView(),
                  ],
                ),
              ),
            ],
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

  Future sendEmail(String emailAddr) async {
    String username = 'dev.oubia@gmail.com';
    String password = 'devN451851';

    // ignore: deprecated_member_use
    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'OUBIA')
      ..recipients.add('destination@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.${e}');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

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
                  'from ${panddingReservation.date_start} to ${panddingReservation.date_end}\n ${panddingReservation.email}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('Delete'),
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
                    child: const Text('Approved'),
                    style: TextButton.styleFrom(primary: Colors.green),
                    onPressed: () {
                      Approved(
                              email: panddingReservation.email,
                              title: panddingReservation.title,
                              location: panddingReservation.location,
                              description: panddingReservation.description,
                              price: panddingReservation.price,
                              date_start: panddingReservation.date_start,
                              date_end: panddingReservation.date_end,
                              imgUrl: panddingReservation.imgUrl,
                              country: panddingReservation.country)
                          .addToApprovedFunctionClass();
                      sendEmail(panddingReservation.email);
                    }),
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

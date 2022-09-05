// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hotel_application/Components/app_button.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Components/rounded_button.dart';
import 'package:hotel_application/Model/Pandding_reservation.dart';
import 'package:hotel_application/Model/Trip.dart';
import 'package:hotel_application/Screens/User/DashBoard.dart';

class Detials extends StatefulWidget {
  final String title,
      location,
      description,
      country,
      imgUrl,
      // ignore: non_constant_identifier_names
      date_start,
      date_end;
  final double price;
  Detials({
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.date_start,
    // ignore: non_constant_identifier_names
    required this.date_end,
    required this.imgUrl,
    required this.country,
  });

  @override
  // ignore: no_logic_in_create_state
  State<Detials> createState() => _DetialsState(
      title: title,
      location: location,
      description: description,
      country: country,
      imgUrl: imgUrl,
      // ignore: non_constant_identifier_names
      date_start: date_start,
      date_end: date_end,
      price: price);
}

class _DetialsState extends State<Detials> {
  int gottenStar = 4;
  int selectedIndex = -1;
  final String title,
      location,
      description,
      country,
      imgUrl,
      // ignore: non_constant_identifier_names
      date_start,
      date_end;
  final double price;
  _DetialsState({
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    // ignore: non_constant_identifier_names
    required this.date_start,
    // ignore: non_constant_identifier_names
    required this.date_end,
    required this.imgUrl,
    required this.country,
  });
  String getEmail() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    return (user!.email).toString();

    // here you write the codes to input the data into firestore
  }

  void addToreservation() {
    PanddingReservation(
            email: getEmail(),
            title: title,
            location: location,
            description: description,
            price: price,
            date_start: date_start,
            date_end: date_end,
            imgUrl: imgUrl,
            country: country)
        .addToReservationFunctionClass();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        // ignore: prefer_const_constructors
        physics: BouncingScrollPhysics(),
        // ignore: sized_box_for_whitespace
        child: Container(
          width: width,
          height: height * 1.2,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // ignore: unnecessary_brace_in_string_interps, unnecessary_string_interpolations
                      image: AssetImage("${imgUrl}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 30,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DashBoard();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      color: KPrimaryColor,
                    )
                  ],
                ),
              ),
              Positioned(
                top: 330,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 700,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // ignore: unnecessary_brace_in_string_interps
                            "${location}",
                            // ignore: unnecessary_const
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${price} MADs",
                            // ignore: unnecessary_const
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: KPrimaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${location},${country}",
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              color: KPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(
                              5,
                              (index) => Icon(
                                Icons.stars,
                                color: index < gottenStar
                                    ? Colors.yellow[300]
                                    : KPrimaryLightColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "People",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Number of people in your group",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: AppButton(
                                background: selectedIndex == index
                                    ? KPrimaryColor
                                    : KPrimaryLightColor,
                                borderColor: KPrimaryColor,
                                color: selectedIndex == index
                                    ? KPrimaryLightColor
                                    : KPrimaryColor,
                                size: 40,
                                text: (index + 1).toString(),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${description}",
                        // ignore: unnecessary_const
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Positioned(
                        child: Row(
                          children: [
                            AppButton(
                              color: KPrimaryColor,
                              background: KPrimaryLightColor,
                              borderColor: KPrimaryColor,
                              size: 60,
                              isIcon: true,
                              icon: Icons.favorite_border,
                            ),
                            RounderButton(
                              text: "Book Now",
                              press: () {
                                addToreservation();
                              },
                              bordeReduis: 10,
                              vertical: 0,
                              horizontal: 10,
                              width: 220,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

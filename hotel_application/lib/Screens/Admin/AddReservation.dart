// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotel_application/Components/TextFild.dart';
import 'package:hotel_application/Components/constants.dart';
import 'package:hotel_application/Components/rounded_button.dart';
import 'package:hotel_application/Components/showSnackBar.dart';
import 'package:hotel_application/Model/Trip.dart';

class AddReservation extends StatefulWidget {
  AddReservation({Key? key}) : super(key: key);

  @override
  State<AddReservation> createState() => _AddReservation();
}

class _AddReservation extends State<AddReservation> {
  DateTime dateStart = DateTime.now();
  DateTime dateEnd = DateTime.now();

  final TextEditingController countryContorller = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    countryContorller.dispose();
    locationController.dispose();
    priceController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
  }

  @override
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

  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 100.0),
              child: Text(
                'Add new Reservation',
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
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            //
                            TextFieldContainer(
                              child: TextField(
                                controller: countryContorller,
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.location_on,
                                    color: KPrimaryColor,
                                  ),
                                  hintText: "Country",
                                ),
                              ),
                            ),

                            TextFieldContainer(
                              child: TextField(
                                controller: locationController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.location_city,
                                    color: KPrimaryColor,
                                  ),
                                  hintText: "City",
                                ),
                              ),
                            ),
                            //
                            TextFieldContainer(
                              child: TextField(
                                controller: priceController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.price_change,
                                    color: KPrimaryColor,
                                  ),
                                  hintText: "Price",
                                ),
                              ),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                controller: titleController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.title,
                                    color: KPrimaryColor,
                                  ),
                                  hintText: "Title",
                                ),
                              ),
                            ),
                            //
                            TextFieldContainer(
                              child: TextFormField(
                                controller: descriptionController,
                                obscureText: false,
                                maxLines: 5,
                                minLines: 2,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.description,
                                    color: KPrimaryColor,
                                  ),
                                  hintText: "Description",
                                ),
                              ),
                            ),
                            //

                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFieldContainer(
                                    child: GestureDetector(
                                      child: Text('Start date'),
                                      onTap: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: dateStart,
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(2060),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                  colorScheme:
                                                      ColorScheme.fromSwatch(
                                                    primarySwatch:
                                                        Colors.deepPurple,
                                                    primaryColorDark:
                                                        KPrimaryColor,
                                                    accentColor: KPrimaryColor,
                                                  ), //selection color
                                                  dialogBackgroundColor:
                                                      KPrimaryLightColor //Background color
                                                  ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (newDate == null) {
                                          return;
                                        }

                                        setState(() => dateStart = newDate);
                                      },
                                    ),
                                  ),
                                  TextFieldContainer(
                                    child: GestureDetector(
                                      child: Text('End date'),
                                      onTap: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: dateEnd,
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime(2060),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                  colorScheme:
                                                      ColorScheme.fromSwatch(
                                                    primarySwatch:
                                                        Colors.deepPurple,
                                                    primaryColorDark:
                                                        KPrimaryColor,
                                                    accentColor: KPrimaryColor,
                                                  ), //selection color
                                                  dialogBackgroundColor:
                                                      KPrimaryLightColor //Background color
                                                  ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (newDate == null) {
                                          return;
                                        }

                                        setState(() => dateEnd = newDate);
                                        print(
                                            '-----------type of ${(newDate).toString().runtimeType}');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextFieldContainer(
                              child: TextFormField(
                                controller: imageController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.description,
                                    color: KPrimaryColor,
                                  ),
                                  hintText: "Image",
                                ),
                              ),
                            ),
                            //
                            SizedBox(
                              height: 30,
                            ),
                            //

                            TextButton(
                              onPressed: () async {
                                if (titleController.text == '' ||
                                    locationController.text == '' ||
                                    descriptionController.text == '' ||
                                    imageController.text == '' ||
                                    countryContorller.text == '') {
                                  showSnackBar(
                                      context, 'Please fill up the form');
                                } else {
                                  final docUser = FirebaseFirestore.instance
                                      .collection("Trip");
                                  final json = {
                                    'title': titleController.text,
                                    'location': locationController.text,
                                    'description': descriptionController.text,
                                    'price': double.parse(priceController.text),
                                    'date_start': dateStart.year.toString() +
                                        '-' +
                                        dateStart.month.toString() +
                                        '-' +
                                        dateStart.day.toString(),
                                    'date_end': dateEnd.year.toString() +
                                        '-' +
                                        dateEnd.month.toString() +
                                        '-' +
                                        dateEnd.day.toString(),
                                    'imgUrl': imageController.text,
                                    'country': countryContorller.text
                                  };
                                  await docUser.add(json);
                                  setState(() {
                                    //<-- Clear at the end
                                    countryContorller.clear();
                                    titleController.clear();
                                    locationController.clear();
                                    descriptionController.clear();
                                    imageController.clear();
                                    priceController.clear();
                                  });
                                }
                              },
                              child: Text(
                                'Add Trip',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 20),
                                backgroundColor: KPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

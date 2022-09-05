// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_application/Model/Trip.dart';

class DataBaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future getData() async {
  //   final FirebaseFirestore _db = FirebaseFirestore.instance;

  //   // Get docs from collection reference
  //   List<Trip> listrip = [];
  //   QuerySnapshot<Map<String, dynamic>> snapshot =
  //       await _db.collection("Trip").get();
  //   var data = snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  //   data.forEach((element) {
  //     print(element['title']);
  //     print(element['description']);
  //     print(element['price']);
  //     print(element['date_start']);
  //     print(element['date_end']);
  //     print(element['country']);
  //     print(element['image']);

  //     var obj = Trip(
  //         title: element['title'],
  //         location: element['location'],
  //         description: element['description'],
  //         price: element['price'],
  //         date_start: element['date_start'],
  //         date_end: element['date_end'],
  //         imgUrl: element['image'],
  //         country: element['country']);
  //     listrip.add(obj);
  //   });
  //   return listrip;
  // }
}

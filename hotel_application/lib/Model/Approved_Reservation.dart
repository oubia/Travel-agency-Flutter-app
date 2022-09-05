import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_application/Model/Trip.dart';

class Approved {
  String? id = (Random().nextInt(1000)).toString();

  late String title,
      location,
      description,
      country,
      imgUrl,
      date_start,
      date_end,
      email;
  late double price;
  Approved({
    this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.date_start,
    required this.email,
    // ignore: non_constant_identifier_names
    required this.date_end,
    required this.imgUrl,
    required this.country,
  });
  Future addToApprovedFunctionClass() async {
    final docUser = FirebaseFirestore.instance.collection("Approved");
    final json = {
      'id': id,
      'email': email,
      'image': imgUrl,
      'date_start': date_start,
      'price': price,
      'description': description,
      'location': location,
      'title': title,
      'date_end': date_end,
      'country': country
    };
    await docUser.add(json);
  }

  static Approved fromJson(Map<String, dynamic> json) => Approved(
      id: json['id'],
      email: json['email'],
      imgUrl: json["image"],
      date_start: json["date_start"],
      price: json["price"],
      description: json["description"],
      location: json["location"],
      title: json['title'],
      date_end: json["date_end"],
      country: json['country']);
}

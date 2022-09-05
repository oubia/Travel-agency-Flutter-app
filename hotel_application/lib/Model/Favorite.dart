import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_application/Model/Trip.dart';

class FavoriteClass {
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
  FavoriteClass({
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
  Future addTofavorite({required Trip trip}) async {
    final docUser = FirebaseFirestore.instance.collection("Favorite");
    final json = {
      'image': trip.imgUrl,
      'email': email,
      'date_start': trip.date_start,
      'price': trip.price,
      'description': trip.description,
      'location': trip.location,
      'title': trip.title,
      'date_end': trip.date_end,
      'country': trip.country
    };
    await docUser.add(json);
  }

  static FavoriteClass fromJson(Map<String, dynamic> json) => FavoriteClass(
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class Trip {
  String? id = (Random().nextInt(1000)).toString();
  late String title,
      location,
      description,
      country,
      imgUrl,
      date_start,
      date_end;
  late double price;
  Trip({
    this.id,
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
  Future addToTrip() async {
    final docUser = FirebaseFirestore.instance.collection("Trip");
    final json = {
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

  //read from firebase
  static Trip fromJson(Map<String, dynamic> json) => Trip(
      id: json["id"],
      imgUrl: json["image"],
      date_start: json["date_start"],
      price: json["price"],
      description: json["description"],
      location: json["location"],
      title: json['title'],
      date_end: json["date_end"],
      country: json['country']);
//write into firebases
  Map<String, dynamic> toJson() => {
        'id': id,
        'image': imgUrl,
        'date_start': date_start,
        'price': price,
        'description': description,
        'location': location,
        'title': title,
        'date_end': date_end,
        'country': country
      };
}

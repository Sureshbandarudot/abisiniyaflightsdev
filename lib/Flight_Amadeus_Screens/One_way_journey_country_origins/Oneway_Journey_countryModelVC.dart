import 'package:flutter/material.dart';

final String url = 'https://jsonplaceholder.typicode.com/users';
class CountryDetails {
  //final int id;
  final String Country_Name,
      Country_code;

  // profileUrl;

  // UserDetails({required this.id, required this.firstName, required this.lastName, this.profileUrl = 'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

  CountryDetails({ required this.Country_Name,required this.Country_code});

  factory CountryDetails.fromJson(Map<String, dynamic> json) {
    return new CountryDetails(
      //id: json['id'],
        Country_Name: json['name'],
        Country_code: json['code']
      //lastName: json['username'],
    );
  }
}
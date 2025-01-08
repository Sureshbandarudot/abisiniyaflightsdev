import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  //final String airport; // Declare a field to receive the data
  final List<String> airports;



  // Constructor to receive the value from Page 1
  Page2({required this.airports});


  @override
  Widget build(BuildContext context) {
    print('receive airports...');
    print(airports.first);
    print(airports[1]);
    print('count...');
    print(airports.length);
    return Scaffold(
      appBar: AppBar(title: Text("Page 2")),
      body: Center(
        child: Text("Airport: $airports"), // Use the value
      ),
    );
  }
}

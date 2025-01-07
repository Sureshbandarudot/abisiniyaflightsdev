import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../FlightSearchVC.dart';
import 'multi_city_origin_modelVC.dart';


class multicityOrigincity extends StatefulWidget {

  // HomePage({Key key}) : super(key: key);
  final Function(String) onAirportSelected;

  multicityOrigincity({required this.onAirportSelected});

  //@override
  //_AirportSelectionPageState createState() => _AirportSelectionPageState();

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<multicityOrigincity> {


  List<UserDetails> _searchResult = [];
  List<UserDetails> _userDetails = [];
  TextEditingController controller = new TextEditingController();
  String multicityDeparturestr = '';
  String multicityArrivalstr = '';
  bool isLoading = false;
  String multicity_Cityname = '';
  String multicity_iatacode = '';
  String multicity_Airportnamestr = '';
  List<String> dogsBreedList = [];
  List<String> tempList = [];

  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      multicityDeparturestr = prefs.getString('OnewayDeparturekey') ?? "";
      multicityArrivalstr = prefs.getString('OnewayArrivalkey') ?? "";
      // print('Oneway source and desti');
      // print(OnewayDeparturestr);
      // print(OnewayArrivalstr);
    });
  }


  // Get json result and convert it to model. Then add


  //   Future<dynamic> getUserDetails() async {
  //
  //     print('calling....');
  //   // final response = await http.get(url as Uri);
  //   // final responseJson = json.decode(response.body);
  //   // print('response data...');
  //   // print(responseJson);
  //   //final String url = 'https://jsonplaceholder.typicode.com/users';
  //
  //
  //   String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airportlist';
  //   http.Response response = await http.get(Uri.parse(baseUrl));
  //     if (response.statusCode == 200) {
  //
  //       List<String> items = [];
  //     var jsonData = json.decode(response.body);
  //     print('Airport list.....');
  //     print(jsonData.toString());
  //     setState(() {
  //       for (Map user in jsonData) {
  //         _userDetails.add(UserDetails.fromJson(user as Map<String, dynamic>));
  //
  //       }
  //     }
  //     );
  //   }
  // }

  Future<dynamic> OriginlocationAPI() async {

    // _fetchDogsBreed() async{
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];
    tempList = [];

    //var baseUrl = "https://dog.ceo/api/breeds/list/all";
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airportlist';


    http.Response response = await http.get(Uri.parse(baseUrl));
    //final response = await http.get('https://dog.ceo/api/breeds/list/all');
    if (response.statusCode == 200) {

      List<String> items = [];
      var jsonData = json.decode(response.body);
      // print('Airport list.....');
      // print(jsonData.toString());
      setState(() {
        for (Map user in jsonData) {
          _userDetails.add(UserDetails.fromJson(user as Map<String, dynamic>));

        }
      }



      );
    }
    else{
      throw Exception("Failed to load Dogs Breeds.");
    }
    setState(() {
      //_userDetails = _searchResult;
      isLoading = false;
    });
  }




  @override
  void initState() {
    super.initState();

    //getUserDetails();
    OriginlocationAPI();
    _retrieveValues();
  }

  // Widget _buildUsersList() {
  //   return new  ListView.builder(
  //     itemCount: _userDetails.length,
  //     itemBuilder: (context, index) {
  //       print('stoping....');
  //
  //      // // Text("Indeterminate", style: TextStyle(fontSize: 21));
  //      //  _isLoading ? CircularProgressIndicator() : CircularProgressIndicator(value: 0.0);
  //      //  Text("Wait...", style: TextStyle(fontSize: 21));
  //      //  _isLoading ? CircularProgressIndicator(value: 10.0) : CircularProgressIndicator(value: 10.0);
  //      //
  //
  //
  //       return new Card(
  //         child: new ListTile(
  //           // leading: new CircleAvatar(
  //           //   // backgroundImage: new NetworkImage(
  //           //   //   _userDetails[index].profileUrl,
  //           //   // ),
  //           // ),
  //           //title: new Text(_userDetails[index].Name),
  //
  //             leading: Icon(Icons.flight),
  //             title: new Text(_userDetails[index].Name +
  //                 '  - ' +
  //                 _userDetails[index].iata),
  //             onTap: () {
  //
  //               print('selected value....');
  //               print((_userDetails[index].Name +
  //                   '  - ' +
  //                   _userDetails[index].iata));
  //               controller.text = _userDetails[index].Name + '  - ' + _userDetails[index].iata;
  //
  //             }
  //         ),
  //
  //
  //         margin: const EdgeInsets.all(0.0),
  //       );
  //     },
  //   );
  // }
  //


  Widget _buildUsersList() {
    return Center(
        child: isLoading?
        CircularProgressIndicator():

        ListView.builder(
          itemCount: _userDetails.length,
          itemBuilder: (context, index) {
            multicity_Airportnamestr = _userDetails[index].Name;
            multicity_iatacode = _userDetails[index].iata;
            multicity_Cityname = _userDetails[index].City;
            return new Card(
              child: new ListTile(
                // leading: new CircleAvatar(
                //   // backgroundImage: new NetworkImage(
                //   //   _userDetails[index].profileUrl,
                //   // ),
                // ),
                //title: new Text(_userDetails[index].Name),

                // leading: Icon(Icons.flight),
                // title: new Text(_userDetails[index].Name + '  ' + "\($Oneway_iatacode)" + ' ' + _userDetails[index].City +" " + _userDetails[index].Country),

                // title: new Text(_userDetails[index].Name +
                //     '  - ' +
                //     _userDetails[index].iata + '  - ' +
                //     _userDetails[index].City),
                // onTap: () async {
                //
                //   // print('selected value....');
                //   // print((_userDetails[index].Name +
                //   //     '  - ' +
                //   //     _userDetails[index].iata));
                //   controller.text = _userDetails[index].Name + '  - ' + _userDetails[index].iata + '  - ' + _userDetails[index].City;
                //   Oneway_Airportnamestr = _userDetails[index].Name;
                //   Oneway_iatacode = _userDetails[index].iata;
                //   Oneway_Cityname = _userDetails[index].City;
                //
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                //   prefs.setString("sourcekey", controller.text);
                //   prefs.setString("Oneway_iatacodekey", Oneway_iatacode);
                //   prefs.setString("Oneway_Citynamekey", Oneway_Cityname);
                //   prefs.setString("Oneway_Oneway_Airportnamestrkey", Oneway_Airportnamestr);
                //
                //
                //
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => FlightSearchVC()),
                //   );
                //
                //
                //
                // }
              ),


              margin: const EdgeInsets.all(0.0),
            );
          },
        )
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, index) {
        multicity_iatacode = _searchResult[index].iata;
        multicity_Cityname = _searchResult[index].City;


        return new Card(
          child: new ListTile(
              leading: Icon(Icons.flight),

              // leading: new CircleAvatar(
              //   // backgroundImage: new NetworkImage(
              //   //   _searchResult[i].profileUrl,
              //   // ),
              // ),
              // title: new Text(
              //     _searchResult[i].firstName),

              title: new Text(_searchResult[index].Name + '  ' + "\($multicity_iatacode)" + ' (' + _searchResult[index].City+ ") " + _searchResult[index].Country,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),

              // title: new Text(
              //     _searchResult[index].Name + '   -' +(_searchResult[index].iata + ' -' + _searchResult[index].City)),
              onTap: () async {
                print('filter....');
                // print(controller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata + '  -' +_searchResult[index].City);
                controller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata + ' -' + _searchResult[index].City;
                multicity_iatacode = _searchResult[index].iata;
                multicity_Cityname = _searchResult[index].City;
                //
                //
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setString("sourcekey", controller.text);
                // prefs.setString("multicity_iatacodekey", multicity_iatacode);
                // prefs.setString("multicity_Citynamekey", multicity_Cityname);
                print('selected city...');
                print(_searchResult[index].City);
                //onAirportSelected(_userDetails[index].City);
                widget.onAirportSelected(_searchResult[index].City);
                Navigator.pop(context);

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => FlightSearchVC()),
                // );
              }
          ),


          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor,

            child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildUsersList()),
      ],
    );
  }
  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            inputFormatters: <TextInputFormatter>[
              UpperCaseTextFormatter()
            ],
            decoration: new InputDecoration(
                hintText: 'Bangalore', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.white, Colors.green]),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white
        ),

        title: const Text('Airport',
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),
      // appBar: new AppBar(
      //   title: new Text('Home'),
      //   elevation: 0.0,
      // ),
      body: _buildBody(),
      // resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.Name.contains(text) ||
          userDetail.iata.contains(text)|| userDetail.City.contains(text) || userDetail.Country.contains(text)) _searchResult.add(userDetail);

    }


    );

    setState(() {});
  }

  void onAirportSelected(String city) {}
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}
String capitalize(String value) {
  if(value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
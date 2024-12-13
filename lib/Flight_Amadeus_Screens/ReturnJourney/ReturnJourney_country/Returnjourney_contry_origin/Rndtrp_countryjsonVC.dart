import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../FlightSearchVC.dart';
import '../../../OneWay_DestinationSelection/Oneway-DestinationcityModel.dart';
import '../../Roundtrip_OriginScreens/Rndtrp_OriginJsonVC.dart';
import 'Rndtrp_countryModelVC.dart';







class RndtrpOriginCountryVC extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<RndtrpOriginCountryVC> {
  List<ContryDetails> _searchResult = [];
  List<ContryDetails> _countryDetails = [];
  final List<String> countrylist = <String>['Most Popular countries...', 'B', 'C'];

  TextEditingController Rndtrpcontroller = new TextEditingController();
  String OnewayDeparturestr = '';
  String OnewayArrivalstr = '';
  String Country_code = '';
  String Country_name = '';
  int selectedIndex = 0;

  bool isLoading = false;

  String RndtrpDeparturestr = '';
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      OnewayDeparturestr = prefs.getString('OnewayDeparturekey') ?? "";
      OnewayArrivalstr = prefs.getString('OnewayArrivalkey') ?? "";
      print('Oneway source and desti');
      print(OnewayDeparturestr);
      print(OnewayArrivalstr);


      RndtrpDeparturestr = prefs.getString('RndtrpDeparturekey') ?? "";
      selectedIndex = prefs.getInt('selectedIndexkey') ?? 0;
      print('index...');
      print(selectedIndex);


    });
  }


  // Get json result and convert it to model. Then add


  // Future<dynamic> getUserDetails() async {
  //
  //   print('calling....');
  //   // final response = await http.get(url as Uri);
  //   // final responseJson = json.decode(response.body);
  //   // print('response data...');
  //   // print(responseJson);
  //   //final String url = 'https://jsonplaceholder.typicode.com/users';
  //
  //
  //   String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airportlist';
  //   http.Response response = await http.get(Uri.parse(baseUrl));
  //   if (response.statusCode == 200) {
  //
  //     List<String> items = [];
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
    // tempList = [];

    //var baseUrl = "https://dog.ceo/api/breeds/list/all";
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/countrylist';


    http.Response response = await http.get(Uri.parse(baseUrl));
    //final response = await http.get('https://dog.ceo/api/breeds/list/all');
    if (response.statusCode == 200) {

      List<String> items = [];
      var jsonData = json.decode(response.body);
      print('country list.....');
      print(jsonData.toString());
      setState(() {
        for (Map user in jsonData) {
          _countryDetails.add(ContryDetails.fromJson(user as Map<String, dynamic>));

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
  //   return new ListView.builder(
  //     itemCount: _userDetails.length,
  //     itemBuilder: (context, index) {
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
  //             onTap: () async {
  //
  //               print('selected value....');
  //               print((_userDetails[index].Name +
  //                   '  - ' +
  //                   _userDetails[index].iata));
  //               Rndtrpcontroller.text = _userDetails[index].Name + '  - ' + _userDetails[index].iata;
  //
  //               Rndtrp_originiatacode = _userDetails[index].iata;
  //               Rndtrp_originCityname = _userDetails[index].Name;
  //
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => FlightSearchVC()),
  //               );
  //               SharedPreferences prefs = await SharedPreferences.getInstance();
  //               prefs.setString("Rndtrp_origincitykey", Rndtrpcontroller.text);
  //               prefs.setString("Rndtrp_originiatacodekey", Rndtrp_originiatacode);
  //               prefs.setString("Rndtrp_originCitynamekey", Rndtrp_originCityname);
  //               prefs.setInt('Roundtripindexkey', selectedIndex);
  //
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

  // Widget _buildSearchResults() {
  //   return new ListView.builder(
  //     itemCount: _searchResult.length,
  //     itemBuilder: (context, index) {
  //
  //       return new Card(
  //         child: new ListTile(
  //             leading: Icon(Icons.flight),
  //
  //             // leading: new CircleAvatar(
  //             //   // backgroundImage: new NetworkImage(
  //             //   //   _searchResult[i].profileUrl,
  //             //   // ),
  //             // ),
  //             // title: new Text(
  //             //     _searchResult[i].firstName),
  //
  //             title: new Text(
  //                 _searchResult[index].Name + '   -' +(_searchResult[index].iata)),
  //             onTap: () async{
  //               print('filter....');
  //               print(Rndtrpcontroller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata);
  //               Rndtrpcontroller.text = _searchResult[index].Name + '  - ' + _searchResult[index].iata;
  //               Rndtrp_originiatacode = _searchResult[index].iata;
  //               Rndtrp_originCityname = _searchResult[index].Name;
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => FlightSearchVC()),
  //               );
  //               SharedPreferences prefs = await SharedPreferences.getInstance();
  //               prefs.setString("Rndtrp_origincitykey", Rndtrpcontroller.text);
  //               prefs.setString("Rndtrp_originiatacodekey", Rndtrp_originiatacode);
  //               prefs.setString("Rndtrp_originCitynamekey", Rndtrp_originCityname);
  //               prefs.setInt('Roundtripindexkey', selectedIndex);
  //
  //
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


  Widget _buildUsersList() {
    return Center(

        child: isLoading?
        CircularProgressIndicator():


        ListView.builder(
          itemCount: countrylist.length,
          itemBuilder: (context, index) {
            // Oneway_Airportnamestr = _userDetails[index].Name;
            // Oneway_iatacode = _userDetails[index].iata;
            // Oneway_Cityname = _userDetails[index].City;
            // Country_name = _countryDetails[index].Country_Name;
            // Country_code = _countryDetails[index].Country_code;

            return new Card(
              child: new ListTile(
                  leading: Icon(Icons.flight),
                 // title: new Text(_countryDetails[index].Country_Name + ' ' + _countryDetails[index].Country_code ),
                 title: Text(countrylist[index],style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black45)),),


                  // onTap: () async {
                  //   print('selected value....');
                  //   print((_countryDetails[index].Country_Name +
                  //       '  - ' +
                  //       _countryDetails[index].Country_code));
                  //   Rndtrpcontroller.text = _countryDetails[index].Country_Name + '  - ' + _countryDetails[index].Country_code;
                  //   Country_code = _countryDetails[index].Country_code;
                  //   Country_name = _countryDetails[index].Country_Name;
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => FlightSearchVC()),
                  //   );
                  //   SharedPreferences prefs = await SharedPreferences.getInstance();
                  //   prefs.setString("Rndtrp_origincitykey", Rndtrpcontroller.text);
                  //
                  //   prefs.setString("Rndtrp_origincountry_codekey", Country_code);
                  //   prefs.setString("Rndtrp_originCountry_namekey", Country_name);
                  //   prefs.setInt('Roundtripindexkey', selectedIndex);
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
        // Oneway_iatacode = _searchResult[index].iata;
        // Oneway_Cityname = _searchResult[index].Name;
        Country_code = _searchResult[index].Country_code;
        Country_name = _searchResult[index].Country_Name;


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

              title: new Text(_searchResult[index].Country_Name + '[ ' + _searchResult[index].Country_code + ']' ,style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black45))),

              // title: new Text(
              //     _searchResult[index].Name + '   -' +(_searchResult[index].iata + ' -' + _searchResult[index].City)),
              onTap: () async{
                print('filter....');
                print(Rndtrpcontroller.text = _searchResult[index].Country_Name + '  - ' + _searchResult[index].Country_code);
                Rndtrpcontroller.text = _searchResult[index].Country_Name + '  - ' + _searchResult[index].Country_code;
                Country_code = _searchResult[index].Country_code;
                Country_name = _searchResult[index].Country_Name;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RndtrpOriginCityVC()),
                );
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("Rndtrp_origincitykey", Rndtrpcontroller.text);
                prefs.setString("Rndtrp_origincountry_codekey", Country_code);
                prefs.setString("Rndtrp_originCountry_namekey", Country_name);
                prefs.setInt('Roundtripindexkey', selectedIndex);


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
            child: _searchResult.length != 0 || Rndtrpcontroller.text.isNotEmpty
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
            controller: Rndtrpcontroller,
            decoration: new InputDecoration(
                hintText: 'Search country', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              Rndtrpcontroller.clear();
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
    _countryDetails.forEach((userDetail) {
      if (userDetail.Country_Name.contains(text) || userDetail.Country_code.contains(text)) _searchResult.add(userDetail);
    }
    );
    setState(() {});
  }
}

import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
import 'package:tourstravels/UserDashboard_Screens/PivoteVC.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';
import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import 'FlightView_Details.dart';
class Flight_BookingVC extends StatefulWidget {
  const Flight_BookingVC({super.key});

  @override
  State<Flight_BookingVC> createState() => _userDashboardState();
}

class _userDashboardState extends State<Flight_BookingVC> {
  final baseDioSingleton = BaseSingleton();

  int bookingID = 0;
  var API = '';
  String status = '';
  int _counter = 0;
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String referenceID ='';

  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  String Statusstr = '';
  String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
  String stsId = '';
  int VehicleId = 0;
  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {


      RetrivedEmail = prefs.getString('emailkey') ?? "";
      RetrivedPwd = prefs.getString('passwordkey') ?? "";
      print('RetrivedEmail in flight booking.');
      print(RetrivedEmail);
      RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      print('token in flights...');
      print(RetrivedBearertoekn);
      VehicleId = prefs.getInt('userbookingId') ?? 0;
    });
  }
//@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    getData();
    //  BookingDashboardUsers = DashboardBooking_fetchUsers();
    //pics = fetchpics();
  }
  // Future<void> _deleteData(int ApartmentId) async {
  //   try {
  //     var url = '';
  //     // url = ('https://staging.abisiniya.com/api/v1/vehicle/delete/$VehicleId');
  //     url = (baseDioSingleton.AbisiniyaBaseurl + 'vehicle/delete/$VehicleId');
  //
  //     print(url);
  //     final response = await http
  //         .delete(Uri.parse(url),
  //       headers: {
  //         // 'Authorization':
  //         // 'Bearer <--your-token-here-->',
  //         "Authorization": "Bearer $RetrivedBearertoekn",
  //
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('vehicle Deleted successfully');
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(
  //       //       builder: (context) => MyVehicleScreen()
  //       //   ),
  //       // );
  //     } else {
  //       throw Exception('Failed to delete data');
  //     }
  //   } catch (error) {
  //     print(error);
  //   }
  // }
  Future<dynamic> getData() async {
    //https://staging.abisiniya.com/api/v1/flight/aflightbookingreqlist
     //String url = 'https://staging.abisiniya.com/api/v1/flight/aflightbookingreqlist';
    //String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/aflightbookingreqlist';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    referenceID = prefs.getString('reference_key') ?? "";
    print('referenceID...');
    print(referenceID);
    // String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/aflightreqshow/' + referenceID;
    String url = baseDioSingleton.AbisiniyaBaseurl + 'flight/aflightbookingreqlist';

    print('rrl....');
    print(url);
    print('RetrivedBearertoekn...');
    print(RetrivedBearertoekn);

    var response = await http.get(
      Uri.parse(
          url),
      headers: {
        // 'Authorization':
        // 'Bearer <--your-token-here-->',
        "Authorization": "Bearer $RetrivedBearertoekn",
      },
    );
    if (response.statusCode == 200) {
      final data1 = jsonDecode(response.body);
      var flightData = data1['data'];
      print('Flight response...');
      print(flightData);

      return json.decode(response.body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  //Alert Dialog box
  DeclinedshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PivotDashboard()),
        );
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => Page1()));
        //Navigator.pushNamed(context, AppRoutes.helpScreen);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
          "Do you want Update Decline!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
//Status Alert
  UpdatedstatusshowAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PivotDashboard()),
        );
        //Navigator.push(
        //context, MaterialPageRoute(builder: (context) => Page1()));
        //Navigator.pushNamed(context, AppRoutes.helpScreen);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(
          "Do you want Update the status!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () async{
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => newuserDashboard()),
            );
          },

        ),
        // iconTheme: IconThemeData(
        //     color: Colors.green,
        // ),
        title: Text('Flight Booking',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.green,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),

      ),
      body: FutureBuilder<dynamic>(

        //future: BookingDashboardUsers,
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                print('imagename......');
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      //Container(color: Colors.red, height: 50),
                      // Container(
                      //   height: 50,
                      //   width: 340,
                      //   color: Colors.black54,
                      //   child: Column(
                      //     children: [
                      //       InkWell(
                      //         child: Container(
                      //           height: 50,
                      //           width: 340,
                      //           color: Colors.black54,
                      //           child: const Align(
                      //             alignment: Alignment.center,
                      //             child: Text('Create',
                      //                 style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w800
                      //                 ),
                      //                 textAlign: TextAlign.center),
                      //           ),
                      //
                      //         ),
                      //         onTap: () async {
                      //           print("Tapped on container");
                      //           SharedPreferences prefs = await SharedPreferences.getInstance();
                      //           prefs.setString('logoutkey', ('LogoutDashboard'));
                      //           prefs.setString('Property_type', ('Apartment'));
                      //           prefs.setString('tokenkey',RetrivedBearertoekn );
                      //           // Navigator.push(
                      //           //   context,
                      //           //   MaterialPageRoute(
                      //           //       builder: (context) => CreateVehice()),
                      //           // );
                      //         },
                      //       )],
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          color: Colors.white70,
                          child: LayoutBuilder(
                            builder: (context, constraint) {
                              return SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: Column(
                                  children: <Widget>[
                                    //Text('Your Apartments'),
                                    //Text('Flights',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                                    ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data['data'].length ?? '',
                                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                                        itemBuilder: (BuildContext context, int index) {
                                          //bookingID = snapshot.data['data'][index]['id'];
                                          return Container(
                                            height: 375,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.white,
                                            child: InkWell(

                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 375,
                                                    width: 340,
                                                    color: Colors.black12,
                                                    child: Column(
                                                      children: [
                                                        // Row(
                                                        //   children: [
                                                        //     Container(
                                                        //       height: 30,
                                                        //       width: 140,
                                                        //       color: Colors.transparent,
                                                        //       child: Text('Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        //     ),
                                                        //     Container(
                                                        //       height: 30,
                                                        //       width: 200,
                                                        //       color: Colors.transparent,
                                                        //       //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                        //       child:Text(snapshot.data['data'][index]['address'],textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                        //     )
                                                        //   ],
                                                        // ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Date:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['created_at'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Reference:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              child:Text(snapshot.data['data'][index]['reference'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                              // child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Fullname:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['userDetail']['name'].toString() +" "+ snapshot.data['data'][index]['userDetail']['surname'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),



                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 60,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('From:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                                                              //  width: 100,
                                                                child: Text(snapshot.data['data'][index]['departure'].toString(),
                                                                    textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis),
                                                              // child:Text(snapshot.data['data'][index]['departure'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),maxLines: 2,
                                                              //   overflow: TextOverflow.ellipsis,),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('To:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 60,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                                                              //  width: 100,
                                                              child: Text(snapshot.data['data'][index]['arrival'].toString(),
                                                                  textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis),
                                                              // child:Text(snapshot.data['data'][index]['departure'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),maxLines: 2,
                                                              //   overflow: TextOverflow.ellipsis,),
                                                            ),
                                                            // Container(
                                                            //   height: 30,
                                                            //   width: 200,
                                                            //   color: Colors.transparent,
                                                            //   //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            //   child:Text(snapshot.data['data'][index]['arrival'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            // )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Airline:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['airline'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Travel Class:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['travel_class'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Flight Option:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['flight_option'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              width: 140,
                                                              color: Colors.transparent,
                                                              child: Text('Status:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                            ),
                                                            Container(
                                                              height: 30,
                                                              width: 200,
                                                              color: Colors.transparent,
                                                              //child: Text('suresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                                              child:Text(snapshot.data['data'][index]['status'].toString(),textAlign: TextAlign.left,style: (TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.black)),),
                                                            )
                                                          ],
                                                        ),

                                                        Row(
                                                          children: [

                                                            Align(
                                                              alignment: Alignment.center,
                                                              child: Container(
                                                                color: Colors.transparent,
                                                                child: Text('Action:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              width: 70,
                                                            ),
                                                            InkWell(
                                                              child: Container(
                                                                color: Colors.cyan,
                                                                child: Container(
                                                                  width: 55,
                                                                  color: Colors.transparent,
                                                                  child: Text('View',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                                ),                                                              ),
                                                              onTap: () async {
                                                                Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                                  builder: (_) => FlightView_DetailsVC(),
                                                                ),);
                                                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                                                print('booking id...');
                                                                print(snapshot.data['data'][index]['flight_request_id']);
                                                                prefs.setInt('flight_request_idkey', snapshot.data['data'][index]['flight_request_id']);
                                                                prefs.setString('reference_key', snapshot.data['data'][index]['reference']);

                                                                prefs.setString('profilenamekey',snapshot.data['data'][index]['userDetail']['name'].toString() +" "+ snapshot.data['data'][index]['userDetail']['surname'].toString());


                                                                // prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                                // prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                                prefs.setString('tokenkey', RetrivedBearertoekn);
                                                                print("value of your text");},
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            // InkWell(
                                                            //   child: Container(
                                                            //     width: 55,
                                                            //     color: Colors.green,
                                                            //     child: Text('Edit',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                            //   ),
                                                            //   onTap: () async{print("value of your text");
                                                            //   // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                            //   //   builder: (_) => VehicleEdit(),
                                                            //   // ),);
                                                            //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            //   print('Edit booking id...');
                                                            //   prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                            //   prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                            //   prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                            //   prefs.setString('countrykey', snapshot.data['data'][index]['country']);
                                                            //
                                                            //   prefs.setString('makekey', snapshot.data['data'][index]['make']);
                                                            //
                                                            //   print('model...');
                                                            //   print(snapshot.data['data'][index]['model']);
                                                            //   prefs.setString('modelkey', snapshot.data['data'][index]['model']);
                                                            //   prefs.setInt('yearkey', snapshot.data['data'][index]['year']);
                                                            //   prefs.setString('engine_sizekey', snapshot.data['data'][index]['engine_size']);
                                                            //   prefs.setString('fuel_typekey', snapshot.data['data'][index]['fuel_type']);
                                                            //   prefs.setString('weightkey', snapshot.data['data'][index]['weight']);
                                                            //   prefs.setString('colorkey', snapshot.data['data'][index]['color']);
                                                            //   prefs.setString('transmissionkey', snapshot.data['data'][index]['transmission']);
                                                            //   prefs.setInt('pricekey', snapshot.data['data'][index]['price']);
                                                            //   prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                            //   print('Edit token');
                                                            //   print(RetrivedBearertoekn);
                                                            //   prefs.setString('tokenkey', RetrivedBearertoekn);
                                                            //   },
                                                            // ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            // InkWell(
                                                            //   child: Container(
                                                            //     width: 65,
                                                            //     color: Colors.red,
                                                            //     child: Text('Delete',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.white),),
                                                            //   ),
                                                            //   onTap: () async{
                                                            //     print("value of your text");
                                                            //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            //     print('booking id...');
                                                            //     print(snapshot.data['data'][index]['id']);
                                                            //     prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                            //     prefs.setString('tokenkey', RetrivedBearertoekn);
                                                            //     // deletePost();
                                                            //     //_deleteData(VehicleId);
                                                            //     VehicleId = (snapshot.data['data'][index]['id']);
                                                            //     try {
                                                            //
                                                            //       print('delete url...');
                                                            //       var url = '';
                                                            //       // url = ('https://staging.abisiniya.com/api/v1/vehicle/delete/$VehicleId');
                                                            //       url = (baseDioSingleton.AbisiniyaBaseurl + 'vehicle/delete/$VehicleId');
                                                            //
                                                            //       print(url);
                                                            //       final response = await http
                                                            //           .delete(Uri.parse(url),
                                                            //         headers: {
                                                            //           // 'Authorization':
                                                            //           // 'Bearer <--your-token-here-->',
                                                            //           "Authorization": "Bearer $RetrivedBearertoekn",
                                                            //
                                                            //         },
                                                            //       );
                                                            //       if (response.statusCode == 200) {
                                                            //         print('vehicle Deleted successfully');
                                                            //         // Navigator.push(
                                                            //         //   context,
                                                            //         //   MaterialPageRoute(
                                                            //         //       builder: (context) => MyVehicleScreen()
                                                            //         //   ),
                                                            //         // );
                                                            //       } else {
                                                            //         throw Exception('Failed to delete data');
                                                            //       }
                                                            //     } catch (error) {
                                                            //       print(error);
                                                            //     }
                                                            //   },
                                                            // ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () async{
                                                if ((snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Awaiting Approval' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Approved' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked In' || (snapshot.data?['data'][index]['bookings'].isEmpty ? Bookingsts
                                                    : snapshot.data?["data"][index]['bookings'][0]['pivot']['status'].toString() ?? 'empty') == 'Checked Out'){
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  print('booking id...');
                                                  print(snapshot.data['data'][index]['id']);
                                                  prefs.setString('namekey', snapshot.data['data'][index]['name']);
                                                  prefs.setString('addresskey', snapshot.data['data'][index]['address']);
                                                  prefs.setString('citykey', snapshot.data['data'][index]['city']);
                                                  prefs.setString('countrykey', snapshot.data['data'][index]['country']);
                                                  prefs.setString('makekey', snapshot.data['data'][index]['make']);
                                                  prefs.setString('modelkey', snapshot.data['data'][index]['model']);
                                                  prefs.setString('yearkey', snapshot.data['data'][index]['year']);
                                                  prefs.setString('engine_sizekey', snapshot.data['data'][index]['engine_size']);
                                                  prefs.setString('fuel_typekey', snapshot.data['data'][index]['fuel_type']);
                                                  prefs.setString('weightkey', snapshot.data['data'][index]['weight']);
                                                  prefs.setString('colorkey', snapshot.data['data'][index]['color']);
                                                  prefs.setString('transmissionkey', snapshot.data['data'][index]['transmission']);
                                                  prefs.setInt('pricekey', snapshot.data['data'][index]['price']);
                                                  prefs.setInt('userbookingId', snapshot.data['data'][index]['id']);
                                                  prefs.setString('tokenkey', RetrivedBearertoekn);
                                                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                    builder: (_) => PivotDashboard(),
                                                  ),);

                                                } else {
                                                  print('failure....');
                                                  final snackBar = SnackBar(
                                                    content: Text('Not booked yet!'),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }
                                              },
                                            ),
                                          );
                                          //return  Text('Some text');
                                        }),

                                    Column(
                                      children:<Widget>[
                                        //Text('second test'),
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (context,index){
                                              return  Text('',style: TextStyle(fontSize: 22),);
                                            }),

                                      ],
                                    )
                                  ],

                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
            }
          }
      ),
    );
  }
}

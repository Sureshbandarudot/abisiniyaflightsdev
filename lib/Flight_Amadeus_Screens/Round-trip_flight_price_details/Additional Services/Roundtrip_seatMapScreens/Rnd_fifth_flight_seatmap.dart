

//import 'dart:html';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
//import 'package:tourstravels/ApartVC/Add_Apartment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:tourstravels/Auth/Login.dart';
import 'dart:convert';
import 'package:tourstravels/ApartVC/Addaprtment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';

import '../../Booking_Screens/Rnd_PassengerDetailsVC.dart';
import 'BackwardJouneySeatmapVC.dart';
import 'Rnd_sixth_flight_seatmap.dart';
import 'Rnd_trp_fourth_flight_seatmap.dart';
void main() {
  runApp(const Round_Trip_Fifth_flight_SeatMapVC());
}

class Round_Trip_Fifth_flight_SeatMapVC extends StatelessWidget {
  const Round_Trip_Fifth_flight_SeatMapVC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'book_my_seat package example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BusLayout(),
    );
  }
}

class BusLayout extends StatefulWidget {
  // final String lable;
  // final bool isAvailable;
  const BusLayout({Key? key}) : super(key: key);

  @override
  State<BusLayout> createState() => _BusLayoutState();
}

class _BusLayoutState extends State<BusLayout> {
  // Set<SeatNumber> selectedSeats = {};
  bool isLoading = false;

  int rows = 0; // Number of rows
  int cols = 0; // Number of columns
  int scrollwidth = 0; // Number of columns
  int Retrived_Passengers_cnt = 0;
  int Retrived_Adult_cnt = 0;
  int Retrived_child_cnt = 0;
  int Retrived_infant_cnt = 0;

  var exitRowsXListArray = [];
  int exitRowsX = 0;
  int exitRowsY = 0;
  var seatID_cnt = [];

  String seatID = '';
  String continuebtn_txt = '';

  // Function to generate seat identifier
  // String getSeatId(int row, int col) {
  //   return 'R$row-C$col';
  // }

  bool isSelected = false;
  late  bool _isSelected = false;


  // Function to toggle seat selection
  // void toggleSeat(String seatId) {
  //   setState(() {
  //     if (selectedSeats.contains(seatId)) {
  //       selectedSeats.remove(seatId);
  //     } else {
  //       selectedSeats.add(seatId);
  //     }
  //   });
  // }
  //
  //
  //

  //var seatLabelList = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P'];

  List Array = ['A','B','C','D','E','f','H','I','J'];

  var seatLabelList = [];
  var seatAvailabilityStatus = [];
  var x_CoordinatesArray = [];
  var y_CoordinatesArray = [];
  //var seatmapArray= [];
  List seatmapArray = [];
  List Connectflightcnt = [];

  int x = 0;
  int y = 0;




  var mynumbers = [];
  var seatnumber = '';




  final baseDioSingleton = BaseSingleton();
  String flightTokenstr = '';
  List travelersArray = [];
  List Convert_segmentArray = [];
  List Convert_AirlineArray = [];
  List Convert_ItineraryArray = [];

  var seatmaptravelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List validatingAirlineCodestrArray = [];


  List convert_travelerPricingsArray = [];
  List seatmap_convert_travelerPricingsArray = [];

  Map<String, dynamic> convert_Currency_PriceArray = {};
  Map<String, dynamic> fareRulesArray = {};

  late final RetrivedSegment_Array ;
  late final validatingAirlineCodestr ;
  late final ItineraryArray;

  bool selectItem = false;
  int selectedGrid = -1;
  String selectedseat = '';
  String Unselectedseat = '';
  List<String> seatnumberListtempArray = [];
  List<String> Add_seatnumberListtempArray = [];
  List<String> Remove_seatnumberListtempArray = [];









//Retrived values
  String flight_ID = '';
  String sourcestr = '';
  String lastTicketing_Datestr = '';
  String lastTicketingDate_Timestr = '';
  String numberOfBookableSeatsstr = '';
  String durationstr = '';
  String Careercodestr = '';
  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Depterminal = '';
  String Arrivalterminal = '';
  String totalpricevalues = '';
  String cabintrvalue = '';
  String Without_seatmap_str = '';
  String seatmap_str = '';

  //Baggage
  int weight = 0;
  int quantity = 0;
  int Passengers_cnt = 0;
  //Cabin Baggage
  int Cabin_weight = 0;
  int Cabin_quantity = 0;

  String Baggagestr = '';
  String Cabin_Baggagestr = '';




  var flight_offer_Array = [];
  var OnwardJourney_Segmentrray = [];
  var Currency_Price_Array = [];
  var Currency_Price_Array_with_seat = [];

  String grandTotalprice = '';
  String totalprice = '';
  String chargeable_Baggage_Amount = '';

  // var grand_totalPricevaluesArray = [];







  String depiataCode = '';
  String Datestr = '';
  String arrivalCode = '';
  String Deptimeconvert = '';
  String Arrivaltimeconvert = '';
  String trimedDuration = '';
  String CurrencyCodestr = '';
  String totalpriceSignvalues = '';
  String airlinestr = '';
  String logostr = '';



  var Departuretextstr = '';
  var flight_departurests = '';

  var travelerIdArray = [];
  String travelerTypestr = '';
  var travelerTypeArray = [];
  //Seat variables
  String firstSeat = '';
  String secondSeat = '';
  String thirdSeat = '';
  String fourthSeat = '';



  late final  segmentDataArray;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Retrived seats from first seatmap
    firstSeat = prefs.getString('selected_firstseatkey') ?? '';
    print('third firstseatnumber..');
    secondSeat = prefs.getString('selected_secondseatkey') ?? '';
    thirdSeat = prefs.getString('selected_thirdseatkey') ?? '';
    fourthSeat = prefs.getString('selected_fourthseatkey') ?? '';
    print(firstSeat);
    print(secondSeat);
    print(thirdSeat);
    print(fourthSeat);
    CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
    flight_ID = prefs.getString('flightid_key') ?? '';
    //prefs.setInt('Passengers_cntkey', Passengers_cnt) ?? 0;
    Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
    print('seat 1 price passengers cnt');
    print(Passengers_cnt);
    Retrived_Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
    Retrived_Adult_cnt = prefs.getInt('Passengers_Adult_cntkey') ?? 0;
    Retrived_child_cnt = prefs.getInt('Passengers_Child_cntkey') ?? 0;
    Retrived_infant_cnt = prefs.getInt('Passengers_infant_cntkey') ?? 0;



    print('seat order passengers cnt value');
    print(Retrived_Passengers_cnt);
    print(Retrived_Adult_cnt);
    print(Retrived_child_cnt);
    print(Retrived_infant_cnt);
    //Chargeable Baggage Value...
    chargeable_Baggage_Amount = prefs.getString('Chargeable_Baggage_Amt_key') ?? '';
    print('chargeable_Baggage_Amount....');
    print(chargeable_Baggage_Amount);



    // print('flight_ID...');
    // print(flight_ID);
    sourcestr = prefs.getString('source_key') ?? '';
    lastTicketing_Datestr = prefs.getString('lastTicketing_Datekey') ?? '';
    lastTicketingDate_Timestr = prefs.getString('lastTicketingDate_Timekey') ?? '';
    numberOfBookableSeatsstr = prefs.getString('numberOfBookableSeatskey') ?? '';
    Careercodestr = prefs.getString('carrierCodekey') ?? '';
    airlinestr = prefs.getString('airlinekey') ?? '';
    logostr = prefs.getString('logokey') ?? '';
    // print('Careercodestr.....');
    // print(Careercodestr);
    RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
    RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';
    Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
    Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';

    // setState(() {
    //   final data = json.decode(RetrivedSegment_Array);
    //   for (var i in data) {
    //     Convert_segmentArray.add(i);
    //   }

    // });
    durationstr = prefs.getString('durationkey') ?? '';

    // prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
    // prefs.setString('durationkey', durationArray[index]);

    //Flight search segment values retriving...
    //final RetrivedSegment_Array ;
    RetrivedSegment_Array = prefs.getString('Segmentkey') ?? '';

    validatingAirlineCodestr = prefs.getString('validatingAirlineCodeskey') ?? '';
    // print('seat validatingAirlineCodestr...');
    // print(validatingAirlineCodestr);
    validatingAirlineCodestrArray = json.decode(validatingAirlineCodestr);
    // print('seat validatingAirlineCodestrArray...');
    // print(validatingAirlineCodestrArray.first);

    //Baggage Data retrived
    //Baggage
    weight = prefs.getInt('weightkey') ?? 0;
    quantity = prefs.getInt('quantitykey') ?? 0;
    // print('Retrived weight...');
    // print(weight);
    // print('Retrived quantity...');
    // print(quantity);




    //print(RetrivedSegment_Array);
    // setState(() {
    //   final data = json.decode(RetrivedSegment_Array);
    //   for (var i in data) {
    //     Convert_segmentArray.add(i);
    //     print('Convert_segmentArray....');
    //     print(Convert_segmentArray);
    //   }
    // });



    //Itinerary Array...
    ItineraryArray = prefs.getString('Itinerarykey') ?? '';
    print('ItineraryArray....');
    print(ItineraryArray);


    setState(() {
      final data = json.decode(ItineraryArray);
      for (var i in data) {
        Convert_ItineraryArray.add(i);
        print('Convert_ItineraryArray....');
        print(Convert_ItineraryArray);
      }
    });


    //travelerPricings values retrived

    final travelerPricings ;
    travelerPricings = prefs.getString('travelerPricingskey') ?? '';
    print(travelerPricings);
    setState(() {
      final data = json.decode(travelerPricings);
      for (var i in data) {
        convert_travelerPricingsArray.add(i);
      }
    });
    setState(() {
      final data = json.decode(travelerPricings);
      for (var i in data) {
        seatmap_convert_travelerPricingsArray.add(i);
      }
    });

    // seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
    //   "chargeableSeatNumber": selectedseat
    // };
    seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
      "chargeableSeatNumber": firstSeat
    };
    seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![1]["additionalServices"] = {
      "chargeableSeatNumber": secondSeat
    };
    seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![2]["additionalServices"] = {
      "chargeableSeatNumber": thirdSeat
    };
    seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![3]["additionalServices"] = {
      "chargeableSeatNumber": fourthSeat
    };
    seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![4]["additionalServices"] = {
      "chargeableSeatNumber": selectedseat
    };
    print('third flight round trip convert_travelerPricingsArray....');
    print(seatmap_convert_travelerPricingsArray);

    prefs.setString('travelerPricingskey', travelerPricings);


    //currency and price values array retriving..
    final Retrived_Currency_PriceArray ;

    Retrived_Currency_PriceArray = prefs.getString('Round_trip_Currency_Pricekey') ?? '';

    // Retrived_Currency_PriceArray = prefs.getString('Currency_Pricekey') ?? '';
    print('seat Retrived_Currency_PriceArray...');
    print(Retrived_Currency_PriceArray);

    convert_Currency_PriceArray = jsonDecode(Retrived_Currency_PriceArray);
    print('seat convert_Currency_PriceArray....');
    print(convert_Currency_PriceArray);

    //FareRules
    final Retrive_fareRules ;
    Retrive_fareRules = prefs.getString('fareRuleskey') ?? '';
    // print('seat fareRuleskey...');
    // print(Retrive_fareRules);
    if(Retrive_fareRules != "") {
      print('seat empty fare values....');
      // fareRulesArray = jsonDecode(Retrive_fareRules);
      // print('Retrive_fareRules....');
      // print(fareRulesArray);
    } else{
      fareRulesArray = jsonDecode(Retrive_fareRules);
      // print('seat Retrive_fareRules....');
      // print(fareRulesArray);

    }

  }


//@override
  initState() {
    // TODO: implement initState
    super.initState();

    _retrieveValues();
    _postData();
    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "domains": ["Data Science", "Mobile", "Web"],
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };

  }


  Without_seatmap_showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.green),),
      onPressed:  () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('seatmapkey', 'Without seatmap');


        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) => Round_trip_Multiple_passengerlistVC()));
        setState((){
          //Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Abisiniya",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24,color: Colors.green),),
      //content: Text("Do you want Login?",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20,color: Colors.black54),),

      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Seat map is not available this route.',style: (TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.red)),),
            // Text('Do you want book flight ticket without Seatmap?'),
            SizedBox(
              height: 20,
            ),
            Text('Do you want book flight ticket without Seatmap?',style: (TextStyle(fontWeight: FontWeight.w800,fontSize: 20,color: Colors.green)),),

          ],
        ),
      ),
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
  Updated_Seat_statusshowAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text(
          "Seat1 ${seatnumberListtempArray.toString()}"),
      actions: [
        // cancelButton,
        // continueButton,
      ],
    );

    // show the dialog
    showDialog(
        context: context,
        builder: (context) {
          print('checking..');
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Seat ${seatnumberListtempArray.toList()}'),
            //content: Text(totalpriceSignvalues),
          );
        });
  }


  Future<void> _postData() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    print(' seat Details Onward journey token1...');
    print(flightTokenstr);
    //{{API_URL}}/v1/shopping/flight-offers/pricing
    //{{API_URL}}/v2/shopping/flight-offers
    //{{API_URL}}/v1/shopping/seatmaps
    final response = await http.post(
      Uri.parse(
          'https://test.travel.api.amadeus.com/v1/shopping/seatmaps'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        //"Authorization": "Bearer ${'oH1yd82b4IjwPQCwO1wajmmouSmM'}",
        "Authorization": "Bearer $flightTokenstr",

      },
      body: jsonEncode(<String, dynamic>
      {
        "data": [
          {
            "type": "flight-offer",
            "id": flight_ID,
            "source": sourcestr,
            "instantTicketingRequired": false,
            "nonHomogeneous": false,
            "oneWay": false,
            "isUpsellOffer": false,
            "lastTicketingDate": lastTicketing_Datestr,
            "lastTicketingDateTime": lastTicketingDate_Timestr,
            "numberOfBookableSeats": numberOfBookableSeatsstr,


            // "type": "flight-offer",
            // "id": "1",
            // "source": "GDS",
            // "instantTicketingRequired": false,
            // "nonHomogeneous": false,
            // "oneWay": false,
            // "isUpsellOffer": false,
            // "lastTicketingDate": "2024-09-12",
            // "lastTicketingDateTime": "2024-09-12",
            // "numberOfBookableSeats": 9,

            "itineraries": Convert_ItineraryArray,
            // "itineraries": [
            //   {
            //     "duration": durationstr,
            //
            //     "segments": Convert_segmentArray,
            //
            //     // "segments": [
            //     //   {
            //     //     "departure": {
            //     //       "iataCode": "BLR",
            //     //       "terminal": "2",
            //     //       "at": "2024-09-25T05:45:00"
            //     //     },
            //     //     "arrival": {
            //     //       "iataCode": "DEL",
            //     //       "terminal": "3",
            //     //       "at": "2024-09-25T08:40:00"
            //     //     },
            //     //     "carrierCode": "AI",
            //     //     "number": "804",
            //     //     "aircraft": {
            //     //       "code": "32N"
            //     //     },
            //     //     "operating": {
            //     //       "carrierCode": "AI"
            //     //     },
            //     //     "duration": "PT2H55M",
            //     //     "id": "41",
            //     //     "numberOfStops": 0,
            //     //     "blacklistedInEU": false
            //     //   }
            //     // ]
            //   }
            // ],

            "price": convert_Currency_PriceArray,



            // "price": {
            //   "currency": "USD",
            //   "total": "79.80",
            //   "base": "64.00",
            //   "fees": [
            //     {
            //       "amount": "0.00",
            //       "type": "SUPPLIER"
            //     },
            //     {
            //       "amount": "0.00",
            //       "type": "TICKETING"
            //     }
            //   ],
            //   "grandTotal": "79.80"
            // },
            "pricingOptions": {
              "fareType": [
                "PUBLISHED"
              ],
              "includedCheckedBagsOnly": true
            },
            "validatingAirlineCodes": [
              //"AI"
              validatingAirlineCodestrArray.first
            ],

            "travelerPricings": convert_travelerPricingsArray,

            // "travelerPricings": [
            //   {
            //     "travelerId": "1",
            //     "fareOption": "STANDARD",
            //     "travelerType": "ADULT",
            //     "price": {
            //       "currency": "USD",
            //       "total": "79.80",
            //       "base": "64.00"
            //     },
            //     "fareDetailsBySegment": [
            //       {
            //         "segmentId": "41",
            //         "cabin": "ECONOMY",
            //         "fareBasis": "UU1YXFII",
            //         "class": "U",
            //         "includedCheckedBags": {
            //           "weight": 15,
            //           "weightUnit": "KG"
            //         },
            //         "includedCabinBags": {
            //           "weight": 7,
            //           "weightUnit": "KG"
            //         }
            //       }
            //     ]
            //   }
            // ],

            //"fareRules": fareRulesArray ?? ''

            // "fareRules": {
            //   "rules": [
            //     {
            //       "category": "EXCHANGE",
            //       "maxPenaltyAmount": "36.00"
            //     },
            //     {
            //       "category": "REFUND",
            //       "maxPenaltyAmount": "48.00"
            //     },
            //     {
            //       "category": "REVALIDATION",
            //       "notApplicable": true
            //     }
            //   ]
            // }
          }
        ]
      }
      ),
    );

    print('rnd trip seat array....');

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      // print('suresh detailes data...');
      // print(responseData);
      var seatData  = responseData['data'];
      // final responseData = jsonDecode(response.body);
      // var flightData = responseData['data'] ?? 'Not found Flights';
      print('round seat Response data...');
      print(seatData);

      for(var decksData in seatData) {
        seatID = decksData['id'];
        print('rnd seatID------');
        print(seatID);
        seatID_cnt.add(seatID);
        print('seatid count....');
        print(seatID_cnt);
        String type = decksData['type'];
        print('type....');
        print(type);
        if (seatID == '5'){
          var decksArray = decksData['decks'];
          // print('decksArray array data...');
          // print(decksArray);

          var Dep = decksData['departure'];
          depiataCode = Dep['iataCode'];

          var arrival = decksData['arrival'];
          arrivalCode = arrival['iataCode'];
          // print('arrival....');
          // print(arrivalCode);


          for(var deckConfigurationstr in decksArray){
            var deckConfiguration = deckConfigurationstr['deckConfiguration'];
            print('deckConfiguration.....');
            print(deckConfiguration);
            int length = 0;
            length = deckConfiguration['length'];
            print('length...');
            print(length);
            int width = 0;
            width = deckConfiguration['width'];
            print('width...');
            print(width);
            var exitrowsstrvalues = deckConfiguration['exitRowsX'] ?? 'Empty';
            print('exitrowsstr...');
            print(exitrowsstrvalues);
            var exitrowsArray = [];
            exitrowsArray.add(exitrowsstrvalues);
            print('exitrows length...');
            print(exitrowsArray.length);
            //Connected flight and direct flight condition
            if(exitrowsstrvalues != 'Empty'){
              if(exitrowsArray.length == 1){
                exitRowsX= exitrowsstrvalues[0] ?? '';
                print('Connected flight..');
                print(exitRowsX);
              } else {
                if(exitrowsstrvalues[0] ?? 0  + 1 == exitrowsstrvalues[1]){
                  exitRowsX= exitrowsstrvalues[0] ?? 0;
                  print('exitRowsXListArra2y..');
                  print(exitRowsX);
                } else{
                  exitRowsX= exitrowsstrvalues[1] ?? 0;
                  print('exitRowsXListArra1y..');
                  print(exitRowsX);
                }
              }
              // if(exitrowsArray.length == 1){
              //   exitRowsX= exitrowsstrvalues[0] ?? '';
              //   print('Connected flight..');
              //   print(exitRowsX);
              // } else {
              //   if(exitrowsstrvalues[0] ?? 0  + 1 == exitrowsstrvalues[1]){
              //     exitRowsX= exitrowsstrvalues[0] ?? 0;
              //     print('exitRowsXListArra2y..');
              //     print(exitRowsX);
              //   } else{
              //     exitRowsX= exitrowsstrvalues[1] ?? 0;
              //     print('exitRowsXListArra1y..');
              //     print(exitRowsX);
              //   }

            }


            // print(exitrowsstrvalues[0] ?? 0);
            // print(exitrowsstrvalues[1] ?? 0);

            //  exitRowsX= exitrowsstrvalues[0] ?? 0;
            // print('exitRowsXListArray..');
            // print(exitRowsX);
            // if(exitrowsstrvalues[0] ?? 0  + 1 == exitrowsstrvalues[1]){
            //   exitRowsX= exitrowsstrvalues[0] ?? 0;
            //   print('exitRowsXListArra2y..');
            //   print(exitRowsX);
            // } else{
            //   exitRowsX= exitrowsstrvalues[1] ?? 0;
            //   print('exitRowsXListArra1y..');
            //   print(exitRowsX);
            // }



            exitRowsXListArray.add(exitrowsstrvalues);


            // print('first value...');
            // print(exitRowsXListArray[0]);
            // print(exitRowsXListArray.length + 1);


            if(width == 7){
              cols = deckConfiguration['width'] - 1;
              print('length1...');
              print(cols);
              int exitrowscnt = 0;
              exitrowscnt = exitRowsXListArray.length;
              print('exitrowscnt.....');
              print(exitrowscnt);
              rows = deckConfiguration['length'] - 10;
              // print('rows...cnt');
              // print(rows);
              scrollwidth = 340;

            } else if(width == 5){
              cols = deckConfiguration['width'] - 1;
              print('jumped length1...');
              print(cols);
              int exitrowscnt = 0;
              exitrowscnt = exitRowsXListArray.length;
              print('exitrowscnt.....');
              print(exitrowscnt);
              rows = deckConfiguration['length'] - 10;
              // rows = 23;

              print('rows...cnt');
              print(rows);
              scrollwidth = 340;

            } else if(width == 6){
              cols = deckConfiguration['width'] - 1;
              print('jumped length1...');
              print(cols);
              int exitrowscnt = 0;
              exitrowscnt = exitRowsXListArray.length;
              print('exitrowscnt.....');
              print(exitrowscnt);
              rows = deckConfiguration['length'] - 10;
              // rows = 23;

              print('rows...cnt');
              print(rows);
              scrollwidth = 340;

            } else {
              cols = deckConfiguration['width'] - exitRowsXListArray.length;
              // print('length2...');
              // print(cols);

              int exitrowscnt = 0;
              exitrowscnt = exitRowsXListArray.length + 1;
              print('exitrowscnt connect.....');
              print(exitrowscnt);
              rows = deckConfiguration['length'] - 15;
              // rows = 4;

              scrollwidth = 550;

            }

          }


          for(var seatlistdata in decksArray) {
            var seatArray = seatlistdata['seats'];
            // print('seatArray...');
            print(seatArray);
            for (var travelerPricingArray in seatArray) {
              var travelerPricingData = [];
              travelerPricingData = travelerPricingArray['travelerPricing'];
              print('travelerPricingData...');
              print(travelerPricingData);
              var seatAvailabilityStatusstr = travelerPricingData.first['seatAvailabilityStatus'];
              print('seatAvailabilityStatusstr....');
              print(seatAvailabilityStatusstr);
              seatAvailabilityStatus.add(seatAvailabilityStatusstr);


              // for (var seatAvailabilityStatusArray in travelerPricingData) {
              //   var seatAvailabilityStatusstr = seatAvailabilityStatusArray['seatAvailabilityStatus'];
              //   print('seatAvailabilityStatusstr....');
              //   print(seatAvailabilityStatusstr);
              //   //seatAvailabilityStatus.add(seatAvailabilityStatusstr);
              // }
              //}

              print('seatAvailabilityStatus.....');
              print(seatAvailabilityStatus);

              for (var seatnumberArray in seatArray) {
                var seatnumberstr = seatnumberArray['number'];
                // print('seatnumberstr...');
                // print(seatnumberstr);
                seatLabelList.add(seatnumberstr);


                //for (var coordinates in seatArray) {
                var coordinatesArray = seatnumberArray['coordinates'];
                print('coordinatesArray.....');
                int x = 0;
                x = coordinatesArray['x'];
                // print('x cordinates');
                // print(x);
                x_CoordinatesArray.add(x);

                int y = 0;
                y = coordinatesArray['y'];
                // print('y cordinates');
                //
                // print(y);
                y_CoordinatesArray.add(y);
                if (x == 0 && y == 1) {
                  seatnumber = seatnumberArray['number'];
                  // print('calling  2 seatnumberstr...');
                  // print(seatnumber);
                  // seatLabelList.add(seatnumberstr2);

                } else if (x == 1 && y == 0) {
                  seatnumber = seatnumberArray['number'];
                  print('calling 1 seatnumberstr...');
                  print(seatnumber);
                  // seatLabelList.add(seatnumberstr2);

                }
              }
            }
          }
        }
      }
      print('seatLabelList....');
      print(seatLabelList);
      print('new seatAvailabilityStatus.....');
      print(seatAvailabilityStatus);
    } else if (response.statusCode == 400) {
      final responseData = jsonDecode(response.body);
      var flighterror_Data = responseData['errors'];
      // print('flighterror_Data...');
      // print(flighterror_Data);
      for (var titledata in flighterror_Data) {
        var titlestr = titledata['title'];
        // print('titlestr...');
        // print(titlestr);
        var detail = titledata['detail'];
        if (titlestr == 'UNABLE TO RETRIEVE SEATMAP DATA') {
          Without_seatmap_showAlertDialog(context);
          // final snackBar = SnackBar(
          //   content: Text(titlestr + ' , ' +
          //       'Seat map is not available'),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: Text(detail + ' , ' + 'Please try again..'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
    else {
      // throw Exception("Failed to load Dogs Breeds.");
      final snackBar = SnackBar(
        content: Text('failed!,please try again'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }



  Future<void> _postData_seatmap_Price() async {
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];
    print('rnd trip call selected seat...');
    print(selectedseat);
    // seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
    //   "chargeableSeatNumber": selectedseat
    // };
    //
    SharedPreferences prefs = await SharedPreferences.getInstance();


    seatmap_str = prefs.getString('seatmapkey') ?? '';




    if (seatmap_str.contains('Without seatmap')) {
      print('This string contains other string.');
      print('without seat number...');
      print(seatmap_convert_travelerPricingsArray);

    } else if (seatmap_str.contains('seatmap')) {
      print('This string contains other string.');
      print('seat number...');
      print(seatmap_convert_travelerPricingsArray);
      print(selectedseat);
      seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
        "chargeableSeatNumber": selectedseat
      };
      print('This string contains other string.');
      print('seat number...');
      print(seatmap_convert_travelerPricingsArray);

    } else {
      print('with seat number with baggage...');
      print(selectedseat);
      seatmap_convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
        "chargeableSeatNumber": selectedseat
      };
    }
    print('seatmap convert_travelerPricingsArray...');
    print(convert_travelerPricingsArray);

    print('convert_travelerPricingsArray....');
    print(convert_travelerPricingsArray);
    print('seatmap_convert_travelerPricingsArray....');
    print(seatmap_convert_travelerPricingsArray);

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    final response = await http.post(
      Uri.parse(
          'https://test.travel.api.amadeus.com/v1/shopping/flight-offers/pricing'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        //"Authorization": "Bearer ${flightTokenstr}",
        "Authorization": "Bearer $flightTokenstr",

      },
      body: jsonEncode(<String, dynamic>
      {
        "data": {
          "type": "flight-offers-pricing",
          "flightOffers": [
            {
              "type": "flight-offer",
              "id": flight_ID,
              "source": sourcestr,
              "instantTicketingRequired": false,
              "nonHomogeneous": false,
              "oneWay": false,
              "isUpsellOffer": false,
              "lastTicketingDate": lastTicketing_Datestr,
              "lastTicketingDateTime": lastTicketingDate_Timestr,
              "numberOfBookableSeats": numberOfBookableSeatsstr,

              "itineraries": Convert_ItineraryArray,


              // "itineraries": [
              //   {
              //     "duration": durationstr,
              //
              //     "segments": Convert_segmentArray,
              //
              //   }
              // ],

              "price": convert_Currency_PriceArray,

              "pricingOptions": {
                "fareType": [
                  "PUBLISHED"
                ],
                "includedCheckedBagsOnly": true
              },
              "validatingAirlineCodes": [
                //"AI"
                validatingAirlineCodestrArray.first
              ],

              "travelerPricings": seatmap_convert_travelerPricingsArray,

            }
          ],
          "bookingRequirements": {
            "emailAddressRequired": true,
            "mobilePhoneNumberRequired": true
          }
        },
      }


      ),
    );

    print('price rnd Details array....');

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      // print('suresh detailes data...');
      // print(responseData);
      var flightData = responseData['data'];
      // print('Response data...');
      // print(flightData);

      var flightOffers = flightData['flightOffers'];
      print('flightOffers...');
      print(flightOffers);
      flight_offer_Array.add(flightOffers);
      for(var itinerariesValues in flightOffers){
        var itinerariesArray = itinerariesValues['itineraries'];
        // print('segmentsvalues...');
        // print(itinerariesArray);
        for(var segmentvalues in itinerariesArray){
          var SegmentArray = segmentvalues['segments'];
          // print('SegmentArray...');
          // print(SegmentArray);
          for(var DeparturArray in SegmentArray){
            var Dep = DeparturArray['departure'] ?? "";
            var depiataCodestr = Dep['iataCode'];
            // print('depiataCodestr..');
            // print(depiataCodestr);
            if(depiataCodestr == Retrived_Oneway_iatacodestr){
              depiataCode = Dep['iataCode'];
              // print('depiataCode.......');
              // print(depiataCode);

              var departuretime = Dep['at'];
              Deptimeconvert =
              (new DateFormat.Hm().format(DateTime.parse(departuretime)));
              Datestr =
              (new DateFormat.yMd().format(DateTime.parse(departuretime)));

            }

            // OnwardJourney_dateArray.add(Datestr);
            // OnwardJourney_DeptimeArray.add(Deptimeconvert);
            Depterminal = Dep['terminal'] ?? "";
            // print('dep terminal...');
            // print(Depterminal);

          }
          for(var ArraivalArray in SegmentArray){
            var Arrival = ArraivalArray['arrival'] ?? "";
            var arrivalstr = Arrival['iataCode'];

            if(arrivalstr == RetrivedOneway_Oneway_Destinationiatacodestr){
              arrivalCode = Arrival['iataCode'];
              // print('arrivalCode...');
              // print(arrivalCode);
              var Arrivaltime = Arrival['at'];
              Arrivaltimeconvert =
              (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
              Datestr =
              (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));
            }
            // print('arrivalCode...');
            // print(arrivalCode);
            Arrivalterminal = Arrival['terminal'] ?? "";
            // print('arrival terminal...');
            // print(Arrivalterminal);
            var Arrivaltime = Arrival['at'];
            Arrivaltimeconvert =
            (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
            Datestr =
            (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));
            // OnwardJourney_dateArray.add(Datestr);
            // OnwardJourney_DeptimeArray.add(Deptimeconvert);
          }
        }
        //for(var Currency_Price in flightData){
        for(var GrandtotalpriceArray in flightOffers){
          var Currency_Pricestr = GrandtotalpriceArray['price'];
          print('price Currency_Pricestr...');
          print(Currency_Pricestr);
          Currency_Price_Array_with_seat.add(Currency_Pricestr);
          totalprice = Currency_Pricestr['grandTotal'];
          print('total price...');
          print(totalprice);
          print(chargeable_Baggage_Amount);
          double n1 = double.tryParse(totalprice) ?? 0.0;
          double n2 = double.tryParse(chargeable_Baggage_Amount) ?? 0.0;
          var result = (n1 + n2).toString();
          grandTotalprice = "$result ";
          String total = '';
          for (var item in Currency_Price_Array) {
            var totalv = item + total;
            print('total...');
            print(totalv);
          }
        }
        //travelerPricings
        for (var priceArray in flightOffers) {
          //travelerPricings
          var travelerPricings_Array = priceArray['travelerPricings'];
          print('passenger price Array...');
          print(travelerPricings_Array);
          seatmaptravelerPricingslistArray.add(travelerPricings_Array);

          for (var price in travelerPricings_Array) {
            var priceArray = price['price'];
            print('passenger priceArray....');
            print(priceArray);
            totalpricevalues = priceArray['total'];
            print('passenger total amt..');
            print(totalpricevalues);
            totalPricevaluesArray.add(totalpricevalues);
            print(totalPricevaluesArray);
          }

          for (var priceArray in flightOffers) {
            //travelerPricings
            var travelerPricings_Array = priceArray['travelerPricings'];
            print('price Array...');
            print(travelerPricings_Array);
            for (var travelidArray in travelerPricings_Array) {
              String travelerId = '';
              travelerId = travelidArray['travelerId'];
              print('travelerId...');
              print(travelerId);
              travelerIdArray.add(travelerId);
              travelerTypestr = travelidArray['travelerType'];
              travelerTypeArray.add(travelerTypestr);
              print('travelerTypeArray...');
              print(travelerTypeArray);
            }
            print('last travelerId...');
            print(travelerIdArray.last);
          }


          seatmaptravelerPricingslistArray.add(travelerPricings_Array);
          List filterpriceArray = travelerPricings_Array.where((
              o) => o['travelerId'] == '1').toList();
          // print('filtered...');
          // print(filterpriceArray);
          for (var price in filterpriceArray) {
            // var priceArray = price['price'];
            // print('total price value..');
            // print(priceArray);
            // totalpricevalues = priceArray['total'];
            // print('total amt..');
            // print(totalpricevalues);
            // totalPricevaluesArray.add(totalpricevalues);
            var cabin_class_array = price['fareDetailsBySegment'];
            // print('cabin_class_array..');
            // print(cabin_class_array);
            for(var cabinvalueArray in cabin_class_array){
              cabintrvalue = cabinvalueArray['cabin'];
              // print('cabin value...');
              // print(cabintrvalue);
              cabintrvalue_Array.add(cabintrvalue);
            }
          }
        }

      }
    }
    else {
      // throw Exception("Failed to load Dogs Breeds.");
      final snackBar = SnackBar(
        content: Text('failed!,please try again'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {



    // print('seatid cnt');
    // print(seatID_cnt.length + 1);

    if(seatID_cnt.length == 5) {
      continuebtn_txt = 'Continue';


    } else{
      continuebtn_txt = 'Next';


    }
    if(CurrencyCodestr == "USD"){
      //totalpricevalues = totalPricevaluesArray[index].toString();
      //print("I have \$$dollars."); // I have $42.
      // totalpriceSignvalues = "\$$totalpricevalues";

      totalpriceSignvalues = "\USD $grandTotalprice";
      print('price value...');
      print(totalpricevalues);
      print(chargeable_Baggage_Amount);
    } else {
      // totalpricevalues = totalPricevaluesArray[index].toString();
      totalpriceSignvalues = "\ZAR $grandTotalprice";
    }




    return Scaffold(

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
        leading: BackButton(
          onPressed: () async{
            print("back Pressed");
            // SharedPreferences prefs = await SharedPreferences.getInstance();
            // prefs.setString('logoutkey', ('LogoutDashboard'));
            // prefs.setString('Property_type', ('Apartment'));
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Rnd_trp_fourth_flight_journey_seatmap()),
            );
          },
        ),
        title: Text('Return 5th flight Seat Selection',textAlign: TextAlign.center,
            style: TextStyle(color:Colors.white,fontFamily: 'Baloo', fontWeight: FontWeight.w900,fontSize: 20)),
      ),




      body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              // Container(
              //   child: Center(
              //     child: Text(
              //       'BLR-CCU',
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontWeight: FontWeight.w500,
              //         fontSize: 18
              //       ),
              //     ),
              //   ),
              //   //color: Colors.grey,
              //   height: 50,
              //   width: 320,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black12),
              //     boxShadow: const [
              //       BoxShadow(
              //         spreadRadius: 5,
              //         blurRadius: 9,
              //
              //         color: Colors.black12,
              //       ),
              //     ],
              //   ),
              // ),



              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      // child: ConstrainedBox(
                      //     constraints: BoxConstraints(
                      //       minHeight: 800, // Set a height greater than the screen height
                      //       minWidth: 1200, // Set a width greater than the screen width
                      //     ),
                      child: SingleChildScrollView(
                        child :Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(9),
                          width: scrollwidth.toDouble(),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey , width: 2.0),
                          ),
                          child: Column(
                            children: [
                              Text(depiataCode + '------------->' + arrivalCode,style: TextStyle(fontSize: 22,color: Colors.red,fontWeight: FontWeight.w600),),
                              const Divider(color: Colors.black,height: 2.0,),
                              Column(
                                children: [
                                  for(int i = 0; i < rows; i++)
                                    Column(
                                        children: [
                                          // if(cols == 9)
                                          //   if( i == 2)

                                          if (cols == 6) ...[
                                            if( i == exitRowsX - 1)
                                              Container(
                                                height: 40,
                                                //width: 200,
                                                //color: Colors.blueAccent,
                                                margin: EdgeInsets.symmetric(horizontal: 5),
                                                padding: EdgeInsets.all(9),
                                                width: MediaQuery.of(context).size.width * 0.90,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(1),
                                                  border: Border.all(color: Colors.grey , width: 1.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "<-  Exit  ->",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            if(i == exitRowsX - 1)
                                              Container(
                                                height: 40,
                                                //width: 200,
                                                //color: Colors.blueAccent,
                                                margin: EdgeInsets.symmetric(horizontal: 5),
                                                padding: EdgeInsets.all(9),
                                                width: MediaQuery.of(context).size.width * 0.90,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(1),
                                                  border: Border.all(color: Colors.grey , width: 1.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "<-  Exit  ->",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                          ] else...[
                                            if( i == 5)

                                              Container(
                                                height: 40,
                                                //width: 200,
                                                //color: Colors.blueAccent,
                                                margin: EdgeInsets.symmetric(horizontal: 5),
                                                padding: EdgeInsets.all(9),
                                                width: scrollwidth.toDouble(),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius: BorderRadius.circular(1),
                                                  border: Border.all(color: Colors.grey , width: 1.0),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "<-  Exit  ->",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
                                                  ),
                                                ),
                                              ),                      ],


                                          // Container(
                                          //   height: 40,
                                          //   //width: 200,
                                          //   //color: Colors.blueAccent,
                                          //   margin: EdgeInsets.symmetric(horizontal: 5),
                                          //   padding: EdgeInsets.all(9),
                                          //   width: MediaQuery.of(context).size.width * 0.90,
                                          //   decoration: BoxDecoration(
                                          //     color: Colors.grey.shade200,
                                          //     borderRadius: BorderRadius.circular(1),
                                          //     border: Border.all(color: Colors.grey , width: 1.0),
                                          //   ),
                                          //   child: Center(
                                          //     child: Text(
                                          //       "<-  Exit  ->",
                                          //       textAlign: TextAlign.center,
                                          //       style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),
                                          //     ),
                                          //   ),
                                          // ),
                                          Row(
                                            //mainAxisSize: MainAxisSize.max,
                                            children: [
                                              for(int j = 0; j < cols; j++)
                                                Row(

                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        //
                                                        // toggleSeat(seatAvailabilityStatus[rows * cols + cols]);
                                                        // isSelected = selectedSeats.contains(seatAvailabilityStatus[rows * cols + cols]);
                                                        // print('selected value');
                                                        // print(isSelected);
                                                        setState(() async {
                                                          // print('values....');
                                                          // print(seatLabelList[i * cols + j]);
                                                          selectedseat = seatLabelList[i * cols + j];
                                                          print('selected seat...');
                                                          print(selectedseat);
                                                          print('seat avl sts....');
                                                          print(seatAvailabilityStatus);


                                                          _postData_seatmap_Price();
                                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          prefs.setString('selected_fifthseatkey', selectedseat);

                                                          // if(seatID_cnt.length == 1) {
                                                          //   _postData_seatmap_Price();
                                                          //   continuebtn_txt = 'Continue';
                                                          // } else{
                                                          //   continuebtn_txt = 'Next';
                                                          //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          //   prefs.setString('selected_firstseatkey', selectedseat);
                                                          //
                                                          // }
                                                          //

                                                          // isSelected = seatnumberListtempArray.contains(seatLabelList[i * cols + j].toString());
                                                          // isSelected = seatnumberListtempArray.contains(seatLabelList[rows * cols + cols].toString());
                                                          //
                                                          // print('selected value');
                                                          // print(isSelected);

                                                          //final _isSelected = seatnumberListtempArray.contains(seatLabelList[index].toString());
                                                          _isSelected = seatnumberListtempArray.contains(seatLabelList[i * cols + j]);
                                                          // print('_isSelected1.........');
                                                          // print(_isSelected);
                                                          print('selected seat cnt...');
                                                          print(seatnumberListtempArray.length + 1);
                                                          print('Retrived_Passengers_cnt........');
                                                          print(Retrived_Passengers_cnt);

                                                          if(Retrived_Passengers_cnt >= seatnumberListtempArray.length + 1) {
                                                            if(_isSelected){
                                                              seatnumberListtempArray.remove(seatLabelList[i * cols + j].toString());
                                                              // print('Removed...');
                                                              // print(seatnumberListtempArray);
                                                              // print(seatnumberListtempArray.length);
                                                              // Add_seatnumberListtempArray.remove(seatLabelList[index].toString());
                                                              Updated_Seat_statusshowAlertDialog(context);
                                                            } else {
                                                              print('selected seat cnt...');
                                                              print(seatnumberListtempArray.length);
                                                              seatnumberListtempArray.add(seatLabelList[i * cols + j].toString());
                                                              Updated_Seat_statusshowAlertDialog(context);

                                                            }
                                                          } else {

                                                            final snackBar = SnackBar(
                                                              content: Text('Cannot select more than Passengers'),
                                                            );
                                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                          }
                                                          //
                                                          //   if(_isSelected){
                                                          //   seatnumberListtempArray.remove(seatLabelList[i * cols + j].toString());
                                                          //   // print('Removed...');
                                                          //   // print(seatnumberListtempArray);
                                                          //   // print(seatnumberListtempArray.length);
                                                          //   // Add_seatnumberListtempArray.remove(seatLabelList[index].toString());
                                                          //   Updated_Seat_statusshowAlertDialog(context);
                                                          // } else {
                                                          //
                                                          //   if(seatnumberListtempArray.length + 1 != Retrived_Passengers_cnt){
                                                          //
                                                          //     print('selected seat cnt...');
                                                          //     print(seatnumberListtempArray.length);
                                                          //     seatnumberListtempArray.add(seatLabelList[i * cols + j].toString());
                                                          //     Updated_Seat_statusshowAlertDialog(context);
                                                          //
                                                          //
                                                          //   } else {
                                                          //     final snackBar = SnackBar(
                                                          //       content: Text('cannot select more than passengers'),
                                                          //     );
                                                          //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                          //   }
                                                          //
                                                          //   //   Remove_seatnumberListtempArray.remove(seatLabelList[index].toString());
                                                          //
                                                          //   // print('Added...');
                                                          //   // print(seatnumberListtempArray.toString());
                                                          //   Updated_Seat_statusshowAlertDialog(context);
                                                          // }
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        margin: const EdgeInsets.all(5.0),
                                                        padding: const EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(
                                                          // color: (seatLabelList[i * cols + j] == selectedseat && !_isSelected)  ? Colors.green : Colors.grey,

                                                          //color: (seatAvailabilityStatus[i * 6 + j] == "AVAILABLE" ) ? Colors.green :  seatAvailabilityStatus[i * 6 + j] =='OCCUPIED' ? Colors.blueAccent : seatAvailabilityStatus[i * 6 + j] =='BLOCKED' ? Colors.red : seatnumberListtempArray.contains(seatLabelList[i * 6 + j].toString()) ? Colors.grey : Colors.green, // last black color will become default color
                                                          // color: (seatAvailabilityStatus[i * cols + j] == "AVAILABLE"  && _isSelected) ? Colors.green :  seatAvailabilityStatus[i * cols + j] =='OCCUPIED' ? Colors.blueAccent : seatAvailabilityStatus[i * cols + j] =='BLOCKED' ? Colors.red : seatnumberListtempArray.contains(seatLabelList[i * cols + j].toString()) ? Colors.grey : Colors.green, // last black color will become default color

                                                          color: (seatAvailabilityStatus[i * cols + j] == "AVAILABLE"  && _isSelected) ? Colors.green :  seatAvailabilityStatus[i * cols + j] =='OCCUPIED' ? Colors.blueAccent : seatAvailabilityStatus[i * cols + j] =='BLOCKED' ? Colors.red : seatnumberListtempArray.contains(seatLabelList[i * cols + j].toString()) ? Colors.grey : Colors.green, // last black color will become default color

                                                        ),


                                                        //color: Colors.red,
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                //Text(seatArragngement[i][j]),
                                                                Align(
                                                                  alignment: Alignment.center,
                                                                  child: Text(
                                                                    '${seatLabelList[i * cols + j]}',
                                                                    style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // if(j == 2)
                                                    //   SizedBox(width:18,),

                                                    if (cols == 4) ...[
                                                      if(j == 1)
                                                        SizedBox(width:75,),
                                                    ] else if (cols == 5) ...[
                                                      if(j == 2)
                                                        SizedBox(width:65,),
                                                    ]else if (cols == 6) ...[
                                                      if(j == 2)
                                                        SizedBox(width:18,),
                                                    ]


                                                    // if(j == 5)
                                                    //   SizedBox(width: 20,),
                                                  ],
                                                )

                                            ],
                                          )
                                        ]
                                    )
                                ],
                              )
                            ],
                          ),
                        ),

                      )
                    //),
                  )),
              Container(

                child: Column(
                  children: [

                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 45,),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          color: Colors.grey,
                        )
                      ],
                    ),

                    Row(
                      children: [
                        SizedBox(width: 30,),
                        Container(
                          height: 30,
                          width: 60,
                          child: Text('Available',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 30,
                          width: 60,
                          child: Text('Blocked',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 30,
                          width: 60,
                          child: Text('Occupaid',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 30,
                          width: 60,
                          child: Text('Selected',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.black),),
                        )
                      ],
                    )

                  ],
                ),
                //color: Colors.white12,
                height: 65,
                width: 320,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                ),
              ),
              Container(
                height: 60,
                width: 320,
                color: Colors.green,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          totalpriceSignvalues,
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color:Colors.red),),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 150,
                          color: Colors.blue,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                continuebtn_txt,
                                style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                                textAlign: TextAlign.center
                            ),
                          )
                      ),
                      onTap: () async {
                        print('continue btn tapped....');
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        // if(seatID_cnt.length == 1) {
                        //   //continuebtn_txt = 'Continue';
                        //
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OnwardJourney_Flight_Details()),
                        //   );
                        //
                        // } else {
                        //   //continuebtn_txt = 'Next';
                        //
                        //   prefs.setString('selectedseatkey', (selectedseat));
                        //   print('selected seat value0...');
                        //   print(selectedseat);
                        //
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ConnectedFlight_firstSegment()),
                        //   );
                        //
                        // }
                        // // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ConnectedFlight_firstSegment()),
                        // );

                        prefs.setString('selected_fifthseatkey', (selectedseat));
                        print('connected selected seat value1...');
                        print(selectedseat);
                        if(selectedseat == ''){

                          final snackBar = SnackBar(
                            content: Text('Please select seat'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          print('seatID_cnt length.');
                          print(seatID_cnt.length);
                          if(seatID_cnt.length == 5) {
                            //continuebtn_txt = 'Continue';

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Round_trip_Multiple_passengerlistVC()),
                            );

                          } else {
                            //continuebtn_txt = 'Next';

                            prefs.setString('selected_fifthseatkey', (selectedseat));
                            print('selected seat value0...');
                            print(selectedseat);

                            Navigator.push (
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Rnd_trp_sixth_flight_journey_seatmap()),
                            );
                            //Rnd_trp_fourth_flight_journey_seatmap
                          }
                        }
                        prefs.setString('totalpriceSignvalueskey', (totalpriceSignvalues));
                        prefs.setString('pricekey', (totalpricevalues));
                        String SegmentData = jsonEncode(Convert_segmentArray);
                        prefs.setString('segmentlistkey', SegmentData);
                        prefs.setString('flight_offer_Array_key', (flight_offer_Array.toString()));
                        // print('SegmentData...');
                        // print(Convert_segmentArray);

                        prefs.setString('flightid_key', flight_ID);
                        prefs.setString('source_key', sourcestr);
                        prefs.setString('lastTicketing_Datekey', lastTicketing_Datestr);
                        prefs.setString('lastTicketingDate_Timekey', lastTicketingDate_Timestr);
                        prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsstr);
                        prefs.setString('carrierCodekey', Careercodestr);
                        prefs.setString('durationkey', durationstr);
                        prefs.setInt('Passengers_cntkey', Passengers_cnt);

                        //Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
                        // print('2 price passengers cnt');
                        // print(Passengers_cnt);
                        //String segJson = jsonEncode(OnwardJourney_Segmentrray.toString());


                        String segJson = jsonEncode(Convert_segmentArray);
                        prefs.setString('Segmentkey', segJson);
                        //Convert_segmentArray
                        //prefs.setString('Segmentkey', Convert_segmentArray.toString());
                        // print('----------seg');
                        // print(Convert_segmentArray);


                        //
                        // String travelerPricings = jsonEncode(travelerPricingslistArray[index]);
                        // prefs.setString('travelerPricingskey', travelerPricings);


                        String convert_travelerPricingJson = jsonEncode(seatmaptravelerPricingslistArray.first);
                        prefs.setString('order_travelerPricing_seatpricekey', convert_travelerPricingJson);
                        String Currency_Price = jsonEncode(Currency_Price_Array_with_seat.first);
                        prefs.setString('Currency_seat_price_key', Currency_Price);
                        print('first seat price....');
                        print(Currency_Price);
                        //Convert_segmentArray
                        //prefs.setString('Segmentkey', Convert_segmentArray.toString());
                        // print('----------order_travelerPricingkey');
                        // print(convert_travelerPricingsArray);




                        String convert_Currency_PriceArrayJson = jsonEncode(convert_Currency_PriceArray);
                        prefs.setString('convert_Currency_PriceArraykey', convert_Currency_PriceArrayJson);
                        // print('----------convert_Currency_PriceArrayJson');
                        // print(convert_Currency_PriceArrayJson);
                        String fareRulesstr = jsonEncode(fareRulesArray);
                        prefs.setString('fareRuleskey', fareRulesstr);
                        prefs.setString('validatingAirlineCodeskey', validatingAirlineCodestr);
                        //Traveller Type
                        String TravellertypejsonParsing = jsonEncode(travelerTypeArray);
                        // print('segJson...');
                        // print(segJson);
                        prefs.setString('TravellertypejsonParsingkey', TravellertypejsonParsing);

                        String priceArray = jsonEncode(totalPricevaluesArray);
                        // print('segJson...');
                        // print(segJson);
                        prefs.setString('priceArrayjsonParsingkey', priceArray);
                      },
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );

  }
}

// int sumUsingLoop(List<double> numbers) {
//   int sum = 0;
//   for (int number in numbers) {
//     sum += number;
//   }
//   return sum;
// }
class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI && colI == other.colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}









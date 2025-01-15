
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
import 'package:tourstravels/UserDashboard_Screens/Apartbooking_Model.dart';
import 'package:tourstravels/UserDashboard_Screens/PivoteVC.dart';
import 'package:tourstravels/UserDashboard_Screens/newDashboard.dart';
import 'package:tourstravels/tabbar.dart';
import 'package:tourstravels/My_Apartments/My_AprtmetsVC.dart';
import 'package:tourstravels/My_Apartments/ViewApartmentVC.dart';

import 'package:tourstravels/Singleton/SingletonAbisiniya.dart';


import 'package:uuid/uuid.dart';
import 'package:uuid/rng.dart';

import '../OnwardJourney_price_DetailsVC.dart';
import '../Round-trip_flight_price_details/Round_trip_price_detailsVC.dart';

class Flight_Multicity_Trip extends StatefulWidget {
  //const Flight_Multicity_Trip({super.key});
  final List<String> Received_departure_Airports;
  final List<String> Received_destination_Airports;
  final List<String> Received_Dates;



  // Constructor to receive the selected airports list
  Flight_Multicity_Trip({required this.Received_departure_Airports, required this.Received_destination_Airports, required this.Received_Dates});


  @override
  State<Flight_Multicity_Trip> createState() => _userDashboardState();
}

class _userDashboardState extends State<Flight_Multicity_Trip> {
  final baseDioSingleton = BaseSingleton();

  int bookingID = 0;
  int numberOfBookableSeats = 0;
  String totalpricevalues = '';
  String totalpriceSignvalues = '';
  List travelersArray = [];
  List originDestinationsArray = [];


  var travelerIdArray = [];
  var segmentValuesAray = [];
  var segmentValuesAraycnt = [];
//Ama client-id
  String amaClientRef = '';

  var firstSegment = '';
  var secongSegment = '';


  List animalArray = [];
  String grandTotalprice = '';
  var grand_totalPricevaluesArray = [];
  List<Map<String, dynamic>> travelers = []; // List to hold traveler data




  var totalPricevaluesArray = [];
  List flight_offerResponse = [];
  var flight_offerResponse_mutable = [];






  var API = '';
  String status = '';
  int _counter = 0;
  int idnum = 0;
  String Date = '';
  int selectedIndex = 0;
  int imageID = 0;
  String citystr = '';
  String RetrivedPwd = '';
  String RetrivedEmail = '';
  String RetrivedBearertoekn = '';
  String Bookingsts = 'Not booked yet!';
  String Statusstr = '';
  String stsbaseurl = 'https://staging.abisiniya.com/api/v1/booking/apartment/';
  String stsId = '';
  int VehicleId = 0;
  String ConvertedDep_Datestr = '';
  String NewdepiataCode = '';

  var controller = ScrollController();
  late Future<List<DashboardApart>> BookingDashboardUsers ;
  int count = 15;
  int Passengers_cnt = 0;

  String flightTokenstr = '';
  String carrierCodestr = '';
  String Airlinecodestr = '';
  String Airlinenamestr = '';
  String Airlinelogostr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';
  String AmadeusAPI_Careercode = '';
  String Oneway_From_Datestr = '';
  String FlightResponsestr = '';
  String cabintrvalue = '';
  String Travel_class_str = '';
  String failurestr = '';



  var cabintrvalue_Array = [];
  var AirportListArray = [];
  var convertedAirlineArray = [];
  var AirlinelogoArray = [];
  var Return_AirportListArray = [];
  var Return_convertedAirlineArray = [];
  var Return_AirlinelogoArray = [];
  var OnwardJourney_postrequestrequestAPI = [];
  var OnwardJourneylist = [];
  var OnwardJourney_depiataCodelist = [];
  var OnwardJourney_arrivaliataCodelist = [];
  var OnwardJourney_DeptimeArray = [];
  var OnwardJourney_ArrivaltimeArray = [];
  //Return journey for first segment
  var first_seg_OnwardJourney_DeptimeArray = [];
  var first_Seg_OnwardJourney_ArrivaltimeArray = [];
  var OnwardJourney_dateArray = [];
  var OnwardJourney_durationArray = [];
  var OnwardJourney_carrierCodeArray = [];
  var OnwardJourney_carrierCodeArray1 = [];


  var OnwardJourney_airlineCodeArray = [];
  var OnwardJourney_airlineNameArray = [];
  var OnwardJourney_airlineLogoArray = [];
  var OnwardJourney_Segmentrray = [];
  var Round_trip_dep_Journey_Segmentrray = [];
  var Round_trip_ItinerariArray = [];
  var Round_trip_Currency_Price_Array = [];
  var Round_trip_fareRulesArray = [];
  var Round_trip_travelerPricingslistArray = [];



  //second flight Journey details
  var SecondJourney_firstflight_depiataCodelist = [];
  var SecondJourney_firstflight_arrivaliataCodelist = [];
  var SecondJourney_firstflight_DeptimeArray = [];
  var SecondJourney_firstflight_ArrivaltimeArray = [];
  var SecondJourney_firstflight_dateArray = [];
  var ScondJourney_firstflight_durationArray = [];
  var SecondJourney_firstflight_carrierCodeArray = [];
  var SecondJourney_firstflight_carrierCodeArray1 = [];


  //Return Journey details
  var ReturnJourney_depiataCodelist = [];
  var ReturnJourney_arrivaliataCodelist = [];
  var ReturnJourney_DeptimeArray = [];
  var ReturnJourney_ArrivaltimeArray = [];
  var ReturnJourney_dateArray = [];
  var ReturnJourney_durationArray = [];
  var ReturnJourney_carrierCodeArray = [];
  var ReturnJourney_carrierCodeArray1 = [];
  //Career code

  var SecondJourney_carrierCodeArray = [];



  //Third Flight details
  //Return Journey details
  var Multi_third_Journey_depiataCodelist = [];
  var Multi_third_Journey_arrivaliataCodelist = [];
  var Multi_third_Journey_DeptimeArray = [];
  var Multi_third_ArrivaltimeArray = [];
  var Multi_third_Journey_dateArray = [];
  var Multi_third_Journey_durationArray = [];
  var Multi_third_Journey_carrierCodeArray = [];
  var Multi_third_Journey_carrierCodeArray1 = [];

  var ReturnJourney_airlineCodeArray = [];
  var ReturnJourney_airlineNameArray = [];
  var ReturnJourney_airlineLogoArray = [];
  var ReturnJourney_Segmentrray = [];







  var FlightEmptyArray = [];
  var flightstatusstr = '';
  var Departuretextstr = '';
  var flight_departurests = '';
  bool isLoading = false;

  var Static_Airline_code_array = [];
  var Static_Airline_name_array = [];
  var priceArray = [];
  var flightoffer_ID_Array = [];
  var lastTicketingDateArray = [];
  var lastTicketingDateTimeArray = [];
  var sourceArray = [];
  var numberOfBookableSeatsArray = [];
  var durationArray = [];
  var validatingAirlineCodesArrayList = [];













  //List<Map<String, dynamic>> mapList = [];
  // Map<String, dynamic> travellers = {};
  String sourcevalue = '';
  String flightoffer_ID = '';
  List<dynamic> travellers = [];
  List returnedList = [];
  List Connectflightcnt_dep = [];
  List Connectflightcnt_Arrival = [];
  String Connectedflightstr = '';





  //Inside widget string values
  String airlinestring = '';
  String departuretimestr = '';
  String arrivaltimestr = '';
  String durationtimestr = '';
  String departureiatacodestr = '';
  String arrivaliatacodestr = '';
  String CareerCountrycodestr = '';
  String Datastr = '';
  String logostr = '';
  String Deptimeconvert = '';
  String arrivalcode = '';
  String Datestr = '';
  String depiataCode = '';
  String CurrencyCodestr = '';
  int weight = 0;
  String weightUnitstr = '';
  int quantity = 0;
  int Cabin_weight = 0;
  String Cabin_weightUnitstr = '';
  int Cabin_quantity = 0;
  int Aduld_cnt = 0;
  int children_cnt = 0;
  int infant_cnt = 0;

  //Round-Trip
  String Retrived_Rndtrp_iatacodestr = '';
  String Retrived_Rndtrp_Citynamestr = '';
  String Retrived_Rndtrp_Destination_iatacodestr = '';
  String Retrived_Rndtrp_Destination_Citynamestr = '';
  String Returnjourney_FromDatestr = '';
  String Returnjourney_ToDatestr = '';






  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print(widget.Received_departure_Airports.first);
      CurrencyCodestr = prefs.getString('currency_code_Rndtrp_dropdownvaluekey') ?? '';
      print('multi Currency code value21...');
      print(CurrencyCodestr);
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      print('Onward journey token...');
      print(flightTokenstr);
      //
      // Oneway_From_Datestr = prefs.getString('from_Datekey') ?? '';
      // print('date calling...');
      // print(Oneway_From_Datestr);
      //
      // Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      // Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      // print('received values in onward...');
      // print(Retrived_Oneway_iatacodestr);
      // print(Retrived_Oneway_Citynamestr);
      //
      // RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      // RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';

      print('received values in dest onward...');
      print(RetrivedOneway_Oneway_Destinationiatacodestr);
      print(RetrivedOnew_Oneway_DestinationCitynamestr);


      Returnjourney_FromDatestr = prefs.getString('returnfrom_Datekey') ?? '';
      Returnjourney_ToDatestr = prefs.getString('returnto_Datekey') ?? '';
      print('return dates...');
      print(Returnjourney_FromDatestr);
      print(Returnjourney_ToDatestr);

      //RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
      Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
      print('Rnd trip origin');
      print(Retrived_Rndtrp_iatacodestr);
      Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';
      //Roundtrip Destination city values
      //RndDestinationAirportcitystr = prefs.getString('Rndtrp_Destinationcitykey') ?? '';
      Retrived_Rndtrp_Destination_iatacodestr = prefs.getString('Rndtrp_Destinationiatacodekey') ?? '';

      print('Rnd trip dest');
      print(Retrived_Rndtrp_Destination_iatacodestr);
      Retrived_Rndtrp_Destination_Citynamestr = prefs.getString('Rndtrp_DestinationCitynamekey') ?? '';
      Travel_class_str = prefs.getString('travel_classstr') ?? '';


      // // RetrivedEmail = prefs.getString('emailkey') ?? "";
      // // RetrivedPwd = prefs.getString('passwordkey') ?? "";
      // // RetrivedBearertoekn = prefs.getString('tokenkey') ?? "";
      // // VehicleId = prefs.getInt('userbookingId') ?? 0;
      // CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
      // // print('Currency code value...');
      // // print(CurrencyCodestr);
      // Travel_class_str = prefs.getString('travel_classstr') ?? '';
      // flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      // // print('Onward journey token...');
      // // print(flightTokenstr);
      //
      // Oneway_From_Datestr = prefs.getString('from_Datekey') ?? '';
      // // print('date calling...');
      // // print(Oneway_From_Datestr);
      //
      // Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      // Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      // // print('received values in onward...');
      // // print(Retrived_Oneway_iatacodestr);
      // // print(Retrived_Oneway_Citynamestr);
      //
      // RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      // RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';

      //Passengerlist
      Aduld_cnt = prefs.getInt('Adult_countkey') ?? 0;
      print('adult cnt...');
      print(Aduld_cnt);
      children_cnt = prefs.getInt('_childrenscounterKey') ?? 0;
      print('children_cnt...');
      print(children_cnt);

      infant_cnt = prefs.getInt('_infantcounter') ?? 0;

      // print('infant_cnt...');
      // print(infant_cnt);
      // if(Aduld_cnt >= 1 && children_cnt == 0 && infant_cnt == 0) {
      //   print('adults.....');
      //
      // } else if(Aduld_cnt == 1 && children_cnt == 1 && infant_cnt == 1) {
      // print('1 adult,1 child and 1 infant');
      //
      // } else {
      // print('1 adult,2 child and 1 infant');
      //
      // }
      // print('received values in dest onward...');
      // print(RetrivedOneway_Oneway_Destinationiatacodestr);
      // print(RetrivedOnew_Oneway_DestinationCitynamestr);



    });
  }




//@override
  initState() {
    // TODO: implement initState
    super.initState();
    _retrieveValues();
    _postData();
    setState(() {
      getUserDetails();
    });


    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "domains": ["Data Science", "Mobile", "Web"],
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };

    List listvalues = [];
    for (var i = 0; i < 5; i++) {
      listvalues.add(i);
    }
    print('values....');
    print(listvalues);
    //return Column(children: list);


    // var list = ["one", "two", "three", "four"];
    //
    // for (var name in list) {
    //   return Text(name);
    // }


    List<dynamic> datalistArray = [];
    //   for (var i = 1; i <= 2; i++) {
    //     print('i value...');
    //     print(i);
    //     if(i == 1) {
    //         travelersArray = <Map<String, dynamic>>[
    //           {
    //             "id": "1",
    //             "travelerType": 'ADULT',
    //             "fareOptions": [
    //               "STANDARD"
    //             ],
    //           },
    //         ];
    //     } else {
    //       travelersArray = <Map<String, dynamic>>[
    // {
    //   "id": "1",
    //   "travelerType": 'ADULT',
    //   "fareOptions": [
    //   "STANDARD"
    //   ]
    //
    //           },
    //
    //         {
    //           "id": "2",
    //           "travelerType": 'ADULT',
    //           "fareOptions": [
    //             "STANDARD"
    //           ]
    //         }
    //
    //       ];
    //     }
    //
    //     print('travelersArray....');
    //     print(travelersArray);
    //     // traveller_datalistArray.add(travelersArray.first);
    //     // print('data list arrray......');
    //     // print(traveller_datalistArray);
    //   }
    //
    // // for (var i=1; i<=2; i++) {
    // //   travelersArray = <Map<String, dynamic>>[
    // //     {
    // //       "id": i,
    // //       "travelerType": 'Adult',
    // //       "fareOptions": [
    // //         "STANDARD"
    // //       ],
    // //     },
    // //   ];
    // //   print('travelersArray....');
    // //   print(travelersArray.toString());
    // //
    // //   datalistArray.add(travelersArray.first);
    // //   print('data list arrray......');
    // //   print(datalistArray.toString());
    // //   // String encodedData = jsonEncode(travelersArray.map((e) => e.toJson()).toList());
    // //   // print('encodedData....');
    // //   // print(encodedData);
    // //
    // //
    // //
    // //
    // // }
    //
    // print('out side area travelersArray....');
    // print(travelersArray.toString());
    //
    // datalistArray.add(travelersArray.first);
    // print('out side data list arrray......');
    // print(datalistArray.toString());
    //
    // var json = '{"id":1,"tags":["a","b","c"]}';
    // var data = jsonDecode(json);
    //
    // List<dynamic> rawTags = data['tags'];
    //
    // List<String> tags = rawTags.map(
    //       (item) {
    //     return item as String;
    //   },
    // ).toList();
    //
    // print('tags...');
    // print(tags);
    //
    //
    //
    //
    // var animalsttest = [
    //   {
    //     "0": ["cow", "chicken", "Fish"]
    //   }
    // ];
    // for (final a in animalsttest) {
    //   for (final x in a.values) {
    //     for (final y in x.asMap().entries) {
    //       print('animalsttest....');
    //
    //       print('${y.key + 1}. ${y.value}');
    //     }
    //   }
    // }
    //
    //
    //
    //
    //
    //
    //
    // // List<dynamic> ListData =
    // // [{"question_id":1,"option_id":2},
    // //   {"question_id":2,"option_id":6}];
    // //
    // // var json = {
    // //   'listKey': json.encode(ListData)
    // // }
    //
    //
    //
    //
    // List<dynamic> animals = [
    //   {
    //     "0": ["cow", "chicken"]
    //   },
    // ];
    // var adults = '';
    // for (var i=1; i<=2; i++) {
    //   for (final a in animals) {
    //     for (final x in a.values) {
    //       for (final y in x
    //           .asMap()
    //           .entries) {
    //         print('animal values...');
    //         print('${y.value}');
    //         adults = ('${y.value}');
    //         print(adults);
    //
    //         var array = [];
    //         array.add(adults);
    //         print('array....');
    //         print(array.toString());
    //         travelersArray = <Map<String, dynamic>>[
    //           {
    //             "id": i,
    //             "travelerType": array.toString(),
    //             "fareOptions": [
    //               "STANDARD"
    //             ],
    //           },
    //         ];
    //       }
    //     }
    //
    //
    //
    //     print('passenger list...');
    //     print(travelersArray);
    //
    //     //travelersArray.add(travellers);
    //     // List<String> strlist = travellers.cast<String>();
    //
    //     // print('loop..');
    //     // print(travelersArray);
    //   }
    // }
    //return travellers;
  }

  Future<dynamic> getUserDetails() async {
    String baseUrl = 'https://staging.abisiniya.com/api/v1/amadeus/airlinelist';
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {

      var jsonData = json.decode(response.body);
      // print('Airport list.....');
      var data = jsonData['data'];
      AirportListArray.add(data);
      setState(() {
        AirportListArray.add(data);
      });
      //return json.decode(response.body);
    }
  }


  // _postData() async{
  //Future<dynamic> _postData(dynamic body) async {
  Future<void> _postData() async {
    print('Received values....');
    // print(widget.Received_departure_Airports.first);
    // print(widget.Received_departure_Airports[1]);
    // print(widget.Received_destination_Airports.first);
    // print(widget.Received_destination_Airports[1]);
    // print(widget.Received_Dates.first);
    // print(widget.Received_Dates[1]);




//         var uuid = Uuid();
//
//         amaClientRef = uuid.v4();  // Generates a random UUID
//         print('amaClientRef2....');
//         print(amaClientRef);
//
//
//         // Generate a v1 (time-based) id
//
//         uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
//         print('time based...');
//         print(uuid.v1());
//
// // Generate a v4 (random) id
//         uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
//         print('random based...');
//         print(uuid.v4());
//
// // Generate a v5 (namespace-name-sha1-based) id
//         uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com'); //
//         print('namespace-name-sha1-based...');
//         print(uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com'));
//



    SharedPreferences prefs = await SharedPreferences.getInstance();
    Aduld_cnt = prefs.getInt('Adult_countkey') ?? 0;
    print('adult cnt...');
    print(Aduld_cnt);
    children_cnt = prefs.getInt('_childrenscounterKey') ?? 0;
    print('children_cnt...');
    print(children_cnt);

    infant_cnt = prefs.getInt('_infantcounter') ?? 0;
    print('infant_cnt...');
    print(infant_cnt);


    // Add adults
    for (int i = 1; i <= Aduld_cnt; i++) {
      travelers.add({
        'id': i,
        'travelerType': 'ADULT'
      });
    }

    // Add children
    for (int i = 1; i <= children_cnt; i++) {
      travelers.add({
        'id': Aduld_cnt + i,
        'travelerType': 'CHILD'
      });
    }

    // Add infants (HELD_INFANT)
    for (int i = 1; i <= infant_cnt; i++) {
      travelers.add({
        'id': Aduld_cnt + children_cnt + i,
        'travelerType': 'HELD_INFANT',
        'associatedAdultId': i
        // This assumes infants are associated with the ith adult
      });
    }

    // Print the travelers list
    print('Added round trip travellers array dynamically...');
    print(travelers);



    //   int adultsCount = 3;  // Example adult count
    //   int childrenCount = 2;  // Example children count
    //   int infantsCount = 1;  // Example infant count
    //
    //   List<Map<String, dynamic>> travelers = []; // List to hold traveler data
    //
    //   // Add adults
    //   for (int i = 1; i <= adultsCount; i++) {
    //     travelers.add({
    //       'id': i,
    //       'travelerType': 'ADULT'
    //     });
    //   }
    //
    //   // Add children
    //   for (int i = 1; i <= childrenCount; i++) {
    //     travelers.add({
    //       'id': adultsCount + i,
    //       'travelerType': 'CHILD'
    //     });
    //   }
    //
    //   // Add infants (HELD_INFANT)
    //   for (int i = 1; i <= infantsCount; i++) {
    //     travelers.add({
    //       'id': adultsCount + childrenCount + i,
    //       'travelerType': 'HELD_INFANT',
    //       'associatedAdultId': i // This assumes infants are associated with the ith adult
    //     });
    //   }
    //
    //   // Print the travelers list
    //   print(travelers);
    // }

    //for (var i = 1; i <= Aduld_cnt; i++) {
    //Passengerlist
    print('i value...');
    print(Aduld_cnt);



    // print('Received values....');
    // print(widget.Received_departure_Airports.first);
    // print(widget.Received_departure_Airports[1]);
    // print('Received_departure_Airports cnt..');
    // print(widget.Received_departure_Airports.length);
    // print(widget.Received_destination_Airports.first);
    // print(widget.Received_destination_Airports[1]);
    // print('widget.Received_destination_Airports cnt');
    // print(widget.Received_destination_Airports.length);
    // print(widget.Received_Dates.first);
    // print(widget.Received_Dates[1]);
      if (widget.Received_departure_Airports.length == 1 && widget.Received_destination_Airports.length == 1) {
        print('Checking with 1 flight...');
        originDestinationsArray = <Map<String, dynamic>>[
          {
            "id": "1",
            "originLocationCode": widget.Received_departure_Airports.first,
            "destinationLocationCode": widget.Received_destination_Airports.first,
            "departureDateTimeRange": {
              "date": widget.Received_Dates.first
            }
          },
        ];
      } else if (widget.Received_departure_Airports.length == 2 && widget.Received_destination_Airports.length == 2) {
        print('Checking with 2 flight...');
      originDestinationsArray = <Map<String, dynamic>>[
        {
          "id": "1",
          "originLocationCode": widget.Received_departure_Airports.first,
          "destinationLocationCode": widget.Received_destination_Airports.first,
          "departureDateTimeRange": {
            "date": widget.Received_Dates.first
          }
        },
        {
          "id": "2",
          "originLocationCode": widget.Received_departure_Airports[1],
          "destinationLocationCode": widget.Received_destination_Airports[1],
          "departureDateTimeRange": {
            "date": widget.Received_Dates[1]
          }
        }
      ];
    } else if(widget.Received_departure_Airports.length == 3 && widget.Received_destination_Airports.length == 3) {
        print('Checking with 3 flight...');
        originDestinationsArray = <Map<String, dynamic>>[
        {
          "id": "1",
          "originLocationCode": widget.Received_departure_Airports.first,
          "destinationLocationCode": widget.Received_destination_Airports.first,
          "departureDateTimeRange": {
            "date": widget.Received_Dates.first
          }
        },
        {
          "id": "2",
          "originLocationCode": widget.Received_departure_Airports[1],
          "destinationLocationCode": widget.Received_destination_Airports[1],
          "departureDateTimeRange": {
            "date": widget.Received_Dates[1]
          }
        },
        {
          "id": "3",
          "originLocationCode": widget.Received_departure_Airports[2],
          "destinationLocationCode": widget.Received_destination_Airports[2],
          "departureDateTimeRange": {
            "date": widget.Received_Dates[2]
          }
        }
      ];
    }



    print('originDestinationsArray....');
    print(originDestinationsArray);

    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    // print('Onward journey token1...');
    // print(flightTokenstr);    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    // print('Onward journey token1...');
    // print(flightTokenstr);
    final response = await http.post(
      Uri.parse('https://test.travel.api.amadeus.com/v2/shopping/flight-offers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Content-Type": "application/json",
        "Accept": "application/json",
        //"Authorization": "Bearer ${flightTokenstr}",
        "Authorization": "Bearer $flightTokenstr",
        //"Ama-Client-Ref": amaClientRef,


      },
      body: jsonEncode(<String, dynamic>
      {
        "currencyCode": "ZAR",
        "originDestinations": originDestinationsArray,
        //
        // "originDestinations": [
        //   {
        //     "id": "1",
        //
        //     //   "originLocationCode": Retrived_Oneway_iatacodestr,
        //     // "destinationLocationCode": RetrivedOneway_Oneway_Destinationiatacodestr,
        //     // // "originLocationCode": "HRE",
        //     // // "destinationLocationCode": "DEL",
        //     // "departureDateTimeRange": {
        //     // "date": Oneway_From_Datestr
        //     "originLocationCode": widget.Received_departure_Airports.first,
        //     "destinationLocationCode": widget.Received_destination_Airports.first,
        //     // "originLocationCode": "HRE",
        //     // "destinationLocationCode": "DEL",
        //     "departureDateTimeRange": {
        //       "date": widget.Received_Dates.first
        //       // "time": "10:00:00"
        //     }
        //   },
        //   {
        //     "id": "2",
        //     "originLocationCode": widget.Received_departure_Airports[1],
        //     "destinationLocationCode": widget.Received_destination_Airports[1],
        //     "departureDateTimeRange": {
        //       "date": widget.Received_Dates[1]
        //       //"time": "17:00:00"
        //     }
        //   }
        //
        // ],

        "travelers": travelers,

        // "travelers": [
        //   {
        //     "id": "1",
        //     "travelerType": "ADULT",
        //     "fareOptions": [
        //       "STANDARD"
        //     ]
        //   },
        //   {
        //     "id": "2",
        //     "travelerType": "CHILD",
        //     "fareOptions": [
        //       "STANDARD"
        //     ]
        //   },
        //   {
        //     "id": "3",
        //     "travelerType": "HELD_INFANT",
        //     "fareOptions": [
        //       "STANDARD"
        //     ],
        //     "associatedAdultId": "1"
        //   }
        // {
        //     "id": "2",
        //     "travelerType": "ADULT",
        //     "fareOptions": [
        //         "STANDARD"
        //     ]
        // }
        //],
        "sources": [
          "GDS"
        ],

        "searchCriteria": {
          "maxFlightOffers": 10,

          "cabinRestrictions": [
            {
              //"cabin": Travel_class_str,
              "cabin": "ECONOMY",

              "coverage": "MOST_SEGMENTS",
              "originDestinationIds": [
                "1"
              ]
            }
          ],
          "additionalInformation": {
            "chargeableCheckedBags": true,
            "brandedFares": false
          },
          "pricingOptions": {
            "fareType": [
              "PUBLISHED",
              "NEGOTIATED"
            ],
            "includedCheckedBagsOnly": true
          }
        }
      }

      ),
    );

    // print('post data api Flight search API response.......');
    //
    // print(response.statusCode);

    if (response.statusCode == 401) {
      print('failed....');
      //failurestr = 'failure';
    }

    if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      var flightData = responseData['data'] ?? 'Not found Flights';
      print('Response data...');
      print(flightData);
      flight_offerResponse.add(flightData);
      flight_offerResponse_mutable.add(flightData);
      // print('lenth...');
      // print(Arraylenth.length);

      if (flightData == []) {
        print('got not empty array...');
      } else {
        print('got empty array...');
        FlightResponsestr = 'Empty';
        final snackBar = SnackBar(
          content: Text('Not found flights in this route'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      FlightEmptyArray.add(flightData);

      // List segmentData = flightData.where((
      //     o) => o['id'] == '1').toList();
      // print('segmentData.....');
      // print(segmentData);


      for (var flightdataArray in flightData) {
        sourcevalue = flightdataArray['source'];
        // print('source value...');
        // print(sourcevalue);
        sourceArray.add(sourcevalue);
        flightoffer_ID = flightdataArray['id'];
        print('flight id..');
        print(flightoffer_ID);
        List FlightDataArray = flightData.where((
            o) => o['id'] == flightoffer_ID).toList();
        print('segmentData123.....');
        print(FlightDataArray);

        var itinerariesArraysegment = flightdataArray['itineraries'];


        // for (var Durationstrv in itinerariesArraysegment) {
        //   String duration = Durationstrv['duration'];
        //   durationArray.add(duration);
        //   // String duration = itinerariesArray['segments'];
        //   print('durationval...');
        //   print(duration);
        //   // for (var SegmentArray in Durationstrv) {
        //   //   segmentValuesAray = SegmentArray['segments'];
        //   for (var SegmentArray in itinerariesArraysegment) {
        //
        //     segmentValuesAray = SegmentArray['segments'];
        //
        //     print('call segments...');
        //     print(segmentValuesAray);
        //     Round_trip_dep_Journey_Segmentrray.add(segmentValuesAray);
        //
        //   }
        // }



        var lastTicketingDatestr = flightdataArray['lastTicketingDate'];
        lastTicketingDateArray.add(lastTicketingDatestr);
        var lastTicketingDateTimestr = flightdataArray['lastTicketingDateTime'];
        lastTicketingDateTimeArray.add(lastTicketingDateTimestr);

        // print('id...');
        // print(flightoffer_ID);
        flightoffer_ID_Array.add(flightoffer_ID);
        OnwardJourneylist.add(sourcevalue);
        numberOfBookableSeats = flightdataArray['numberOfBookableSeats'];
        //print(numberOfBookableSeats);
        numberOfBookableSeatsArray.add(numberOfBookableSeats);
        var itinerariesArray = flightdataArray['itineraries'];
        //print(itinerariesArray);


        for(var FlightDataParsingArray in FlightDataArray){
          var segmentid = FlightDataParsingArray['id'];
          print('segmentFirstArray....');
          print(segmentid);

          var itinerariesArray = FlightDataParsingArray['itineraries'];
          print('itinerariesArray....');
          print(itinerariesArray);
          Round_trip_ItinerariArray.add(itinerariesArray);

          for (var SegmentArray in itinerariesArray) {
            segmentValuesAray = SegmentArray['segments'];
            print('segmentArray...');
            print(segmentValuesAray);
            setState(() {
              print('segmentArray...');
              print('segment cnt ');
              print(segmentValuesAray.length);
              var cnt = '';
              cnt = segmentValuesAray.length.toString();
              segmentValuesAraycnt.add(cnt);
              print('segmentValuesAraycnt....');
              print(segmentValuesAraycnt);
              //Round_trip_dep_Journey_Segmentrray.add(segmentValuesAray);
            });
            // if(segmentValuesAray.length == 1) {
            //   print('calling in 1st loop...');
            //   var carrierCodestr = segmentValuesAray.first['carrierCode'];
            //   print('new carrierCodestr....');
            //   print(carrierCodestr);
            //   setState(() {
            //     OnwardJourney_carrierCodeArray1.add(carrierCodestr);
            //   });
            //
            //   // depiataCode = segmentValuesAray['departure'];
            //   //   print('dep...');
            //   //   print(depiataCode);
            //
            //   for (var DeparturArray in segmentValuesAray) {
            //     var carrierCodestr = DeparturArray['carrierCode'];
            //     print('1st careercode.');
            //     print(carrierCodestr);
            //     setState(() {
            //       getUserDetails();
            //       // print('Array........');
            //       // print(AirportListArray.toString());
            //     });
            //
            //     // setState(() {
            //     //   OnwardJourney_carrierCodeArray.add(carrierCodestr);
            //     // });
            //     var Dep = DeparturArray['departure'];
            //     depiataCode = Dep['iataCode'];
            //     print('1st dep...');
            //     print(depiataCode);
            //
            //     if(widget.Received_departure_Airports.first == depiataCode) {
            //       OnwardJourney_depiataCodelist.add(depiataCode);
            //       print('1st dep array...');
            //       print(OnwardJourney_depiataCodelist);
            //       var departuretime = Dep['at'];
            //       Deptimeconvert =
            //       (new DateFormat.Hm().format(DateTime.parse(departuretime)));
            //       Datestr =
            //       (new DateFormat.yMd().format(DateTime.parse(departuretime)));
            //       OnwardJourney_dateArray.add(Datestr);
            //       print('time12...');
            //       print(Deptimeconvert);
            //       OnwardJourney_DeptimeArray.add(Deptimeconvert);
            //     }
            //
            //     //Return journey
            //     print('second flight details..');
            //     print(depiataCode);
            //     print(widget.Received_departure_Airports[1]);
            //     if(widget.Received_departure_Airports[1] == depiataCode) {
            //       OnwardJourney_depiataCodelist.add(depiataCode);
            //       print('1st dep array...');
            //       print(OnwardJourney_depiataCodelist);
            //       var departuretime = Dep['at'];
            //       Deptimeconvert =
            //       (new DateFormat.Hm().format(DateTime.parse(departuretime)));
            //       Datestr =
            //       (new DateFormat.yMd().format(DateTime.parse(departuretime)));
            //       OnwardJourney_dateArray.add(Datestr);
            //       print('second flight time...');
            //       print(Deptimeconvert);
            //       first_seg_OnwardJourney_DeptimeArray.add(Deptimeconvert);
            //     }
            //
            //
            //     var arrival = DeparturArray['arrival'];
            //     arrivalcode = arrival['iataCode'];
            //     print('1st arrival....');
            //     print(arrivalcode);
            //     Connectflightcnt_Arrival.add(arrivalcode);
            //     if(widget.Received_destination_Airports.first == arrivalcode){
            //       OnwardJourney_arrivaliataCodelist.add(arrivalcode);
            //       // print('arrival array...');
            //       // print(OnwardJourney_arrivaliataCodelist);
            //       var arrivaltime = arrival['at'];
            //       var Arrivaltimeconvert = (new DateFormat.Hm().format(
            //           DateTime.parse(arrivaltime)));
            //       OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
            //       // print('last...');
            //       // print(OnwardJourney_ArrivaltimeArray);
            //     }
            //     //Return journey
            //     print('second flight arrival....');
            //     print(arrivalcode);
            //     print(widget.Received_destination_Airports[1]);
            //     if(widget.Received_destination_Airports[1] == arrivalcode){
            //       OnwardJourney_arrivaliataCodelist.add(arrivalcode);
            //       // print('arrival array...');
            //       // print(OnwardJourney_arrivaliataCodelist);
            //       var arrivaltime = arrival['at'];
            //       var Arrivaltimeconvert = (new DateFormat.Hm().format(
            //           DateTime.parse(arrivaltime)));
            //       first_Seg_OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
            //       // print('last...');
            //       // print(OnwardJourney_ArrivaltimeArray);
            //     }
            //
            //
            //   }
            // }

            // if(segmentValuesAray.length == 2) {

            var carrierCodestr = segmentValuesAray.first['carrierCode'];
            print('new carrierCodestr....');
            print(carrierCodestr);
            setState(() {
              OnwardJourney_carrierCodeArray1.add(carrierCodestr);
            });
            for (var DeparturArray in segmentValuesAray) {
              var carrierCodestr = DeparturArray['carrierCode'];
              print('careercode.');
              print(carrierCodestr);
              setState(() {
                getUserDetails();
                // print('Array........');
                // print(AirportListArray.toString());
              });

              // setState(() {
              //   OnwardJourney_carrierCodeArray.add(carrierCodestr);
              // });
              if (widget.Received_departure_Airports.length == 1 &&
                  widget.Received_destination_Airports.length == 1) {
                var Dep = DeparturArray['departure'];
                depiataCode = Dep['iataCode'];
                print(depiataCode);
                if (widget.Received_departure_Airports.first == depiataCode) {
                  print('First flight..');
                  //first flight data...
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);

                    print('first flight careercode...');
                    print(carrierCodestr);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);

                    print('first flight careercode...1');
                    print(carrierCodestr);
                    print(OnwardJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }

                // if(widget.Received_departure_Airports.first == depiataCode) {
                //   OnwardJourney_depiataCodelist.add(depiataCode);
                //   OnwardJourney_carrierCodeArray1.add(carrierCodestr);
                //
                //   print('2nd dep array...');
                //   print(OnwardJourney_depiataCodelist);
                //   var departuretime = Dep['at'];
                //   Deptimeconvert =
                //   (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                //   Datestr =
                //   (new DateFormat.yMd().format(DateTime.parse(departuretime)));
                //   OnwardJourney_dateArray.add(Datestr);
                //   print('time3...');
                //   print(Deptimeconvert);
                //   OnwardJourney_DeptimeArray.add(Deptimeconvert);
                // }
                // if(widget.Received_departure_Airports[1] == depiataCode) {
                //   ReturnJourney_depiataCodelist.add(depiataCode);
                //   print('return dep array...');
                //   print(ReturnJourney_depiataCodelist);
                //   var departuretime = Dep['at'];
                //   Deptimeconvert =
                //   (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                //   Datestr =
                //   (new DateFormat.yMd().format(DateTime.parse(departuretime)));
                //   ReturnJourney_dateArray.add(Datestr);
                //   print('time4...');
                //   print(Deptimeconvert);
                //   ReturnJourney_DeptimeArray.add(Deptimeconvert);
                // }


                var arrival = DeparturArray['arrival'];
                arrivalcode = arrival['iataCode'];
                print('arrival....');
                print(arrivalcode);
                // Connectflightcnt_Arrival.add(arrivalcode);
                if (widget.Received_destination_Airports.first == arrivalcode) {
                  print('First flight arrival');
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    ReturnJourney_carrierCodeArray1.add(carrierCodestr);
                    print('First flight arrival....');
                    print(ReturnJourney_carrierCodeArray1);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    // print('last...');
                    // print(OnwardJourney_ArrivaltimeArray);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    // print('last...');
                    // print(OnwardJourney_ArrivaltimeArray);
                  }
                }
              }


              //Two flights data...
              if (widget.Received_departure_Airports.length == 2 &&
                  widget.Received_destination_Airports.length == 2) {
                var Dep = DeparturArray['departure'];
                depiataCode = Dep['iataCode'];
                print(depiataCode);
                if (widget.Received_departure_Airports.first == depiataCode) {
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray.add(carrierCodestr);
                    print('second journey1....');
                    print(carrierCodestr);
                    print(OnwardJourney_carrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray.add(carrierCodestr);
                    print('second journey2....');
                    print(carrierCodestr);
                    print(OnwardJourney_carrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }
                var arrival = DeparturArray['arrival'];
                arrivalcode = arrival['iataCode'];
                print('arrival....');
                print(arrivalcode);
                // Connectflightcnt_Arrival.add(arrivalcode);
                if (widget.Received_destination_Airports.first == arrivalcode) {
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    // OnwardJourney_carrierCodeArray.add(carrierCodestr);
                    // print('second journey3....');
                    // print(carrierCodestr);
                    // print(OnwardJourney_carrierCodeArray);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    // print('last...');
                    // print(OnwardJourney_ArrivaltimeArray);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    OnwardJourney_carrierCodeArray.add(carrierCodestr);
                    print('second journey4....');
                    print(carrierCodestr);
                    print(OnwardJourney_carrierCodeArray);
                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    // print('last...');
                    // print(OnwardJourney_ArrivaltimeArray);
                  }
                }

                //Second Journey second flight details

                if (widget.Received_departure_Airports[1] == depiataCode) {
                  if (segmentValuesAray.length == 1) {
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    SecondJourney_carrierCodeArray.add(carrierCodestr);
                    print('second journey 2nd flight...1');
                    print(carrierCodestr);
                    print(SecondJourney_carrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    SecondJourney_carrierCodeArray.add(carrierCodestr);
                    print('second journey 2nd flight...2');
                    print(carrierCodestr);
                    print(SecondJourney_carrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }
                  if (widget.Received_destination_Airports[1] == arrivalcode) {
                    print('.......First flight arrival');
                    if (segmentValuesAray.length == 1) {
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      SecondJourney_carrierCodeArray.add(carrierCodestr);
                      print('second journey 2nd flight...3');
                      print(carrierCodestr);
                      print(SecondJourney_carrierCodeArray);

                      // print('arrival array...');
                      // print(OnwardJourney_arrivaliataCodelist);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                      print('last123...');
                      print(OnwardJourney_ArrivaltimeArray);
                    } else if (segmentValuesAray.length == 2) {
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      // SecondJourney_carrierCodeArray.add(carrierCodestr);
                      // print('second journey 2nd flight...4');
                      // print(carrierCodestr);
                      // print(SecondJourney_carrierCodeArray);

                      // print('arrival array...');
                      // print(OnwardJourney_arrivaliataCodelist);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                      print('rrrrr last...');
                      print(OnwardJourney_ArrivaltimeArray);
                    }
                  }
              }



              //Three fligts data...
              if (widget.Received_departure_Airports.length == 3 &&
                  widget.Received_destination_Airports.length == 3) {
                print('testing with 2 flights....');
                var Dep = DeparturArray['departure'];
                depiataCode = Dep['iataCode'];
                print(depiataCode);
                if (widget.Received_departure_Airports.first == depiataCode) {
                  print('First flight..');
                  //first flight data...
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);
                    print('first flight departure data...');

                    print(OnwardJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);

                    print('2nd dep array...');
                    print(OnwardJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }
                var arrival = DeparturArray['arrival'];
                arrivalcode = arrival['iataCode'];
                print('arrival....');
                print(arrivalcode);
                // Connectflightcnt_Arrival.add(arrivalcode);
                if (widget.Received_destination_Airports.first == arrivalcode) {
                  print('First flight arrival');
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    ReturnJourney_carrierCodeArray1.add(carrierCodestr);
                    print('First flight arrival....');
                    print(ReturnJourney_carrierCodeArray1);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    // print('last...');
                    // print(OnwardJourney_ArrivaltimeArray);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    ReturnJourney_carrierCodeArray1.add(carrierCodestr);
                    print('..segment2 flight arrival....');
                    print(ReturnJourney_carrierCodeArray1);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    // print('last...');
                    // print(OnwardJourney_ArrivaltimeArray);
                  }
                }
                //Second flight details

                if (widget.Received_departure_Airports[1] == depiataCode) {
                  print('ssssss1');
                  //first flight data...
                  if (segmentValuesAray.length == 1) {
                    print('second flight careercode...');
                    print(carrierCodestr);
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    ReturnJourney_depiataCodelist.add(carrierCodestr);
                    print('sssss first flight departure data...');

                    print(ReturnJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);

                    print('2nd dep array...');
                    print(ReturnJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }
                  if (widget.Received_destination_Airports[1] == arrivalcode) {
                    print('.......First flight arrival');
                    if (segmentValuesAray.length == 1) {
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      OnwardJourney_carrierCodeArray1.add(carrierCodestr);
                      print('.......2nd arrival First flight arrival....');
                      print(OnwardJourney_carrierCodeArray1);

                      // print('arrival array...');
                      // print(OnwardJourney_arrivaliataCodelist);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                      print('last123...');
                      print(OnwardJourney_ArrivaltimeArray);
                    } else if (segmentValuesAray.length == 2) {
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      OnwardJourney_carrierCodeArray1.add(carrierCodestr);
                      print('.-.-.segment2 flight arrival....');
                      print(OnwardJourney_carrierCodeArray1);

                      // print('arrival array...');
                      // print(OnwardJourney_arrivaliataCodelist);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                      print('rrrrr last...');
                      print(OnwardJourney_ArrivaltimeArray);
                    }
                  }
                  //Third flight details
                if (widget.Received_departure_Airports[2] == depiataCode) {
                  print('ssssss1');
                  //first flight data...
                  if (segmentValuesAray.length == 1) {
                    Multi_third_Journey_depiataCodelist.add(depiataCode);
                    ReturnJourney_depiataCodelist.add(carrierCodestr);
                    print('sssss first flight departure data...');

                    print(ReturnJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    Multi_third_Journey_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    Multi_third_Journey_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    Multi_third_Journey_depiataCodelist.add(depiataCode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);

                    print('2nd dep array...');
                    print(ReturnJourney_depiataCodelist);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    Multi_third_Journey_dateArray.add(Datestr);
                    print('time3...');
                    print(Deptimeconvert);
                    Multi_third_Journey_DeptimeArray.add(Deptimeconvert);
                  }
                }
                if (widget.Received_destination_Airports[2] == arrivalcode) {
                  print('.......First flight arrival');
                  if (segmentValuesAray.length == 1) {
                    Multi_third_Journey_arrivaliataCodelist.add(arrivalcode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);
                    print('.......2nd arrival First flight arrival....');
                    print(OnwardJourney_carrierCodeArray1);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    Multi_third_ArrivaltimeArray.add(Arrivaltimeconvert);
                    print('last123...');
                    print(OnwardJourney_ArrivaltimeArray);
                  } else if (segmentValuesAray.length == 2) {
                    Multi_third_Journey_arrivaliataCodelist.add(arrivalcode);
                    OnwardJourney_carrierCodeArray1.add(carrierCodestr);
                    print('.-.-.segment2 flight arrival....');
                    print(OnwardJourney_carrierCodeArray1);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    Multi_third_ArrivaltimeArray.add(Arrivaltimeconvert);
                    print('rrrrr last...');
                    print(OnwardJourney_ArrivaltimeArray);
                  }
                }
              }
            }
          }



          // for (var Durationstrv in itinerariesArray) {
          //   String duration = Durationstrv['duration'];
          //   durationArray.add(duration);
          //   // String duration = itinerariesArray['segments'];
          //   print('durationval...');
          //   print(duration);
          //   // for (var SegmentArray in Durationstrv) {
          //   //   segmentValuesAray = SegmentArray['segments'];
          //   for (var SegmentArray in itinerariesArray) {
          //
          //     segmentValuesAray = SegmentArray['segments'];
          //
          //     print('call segments...');
          //     print(segmentValuesAray);
          //     Round_trip_dep_Journey_Segmentrray.add(segmentValuesAray);
          //
          //   }
          // }
          //   // String segmentfirst = Durationstrv['segments'];
          //   // print('segmentfirst....');
          //   // print(segmentfirst);
          //
          //   durationArray.add(duration);
          //   // String duration = itinerariesArray['segments'];
          //   print('durationval...');
          //   print(duration);
          //
          //
          //   String trimedDuration = duration.substring(2);
          //   OnwardJourney_durationArray.add(trimedDuration.toLowerCase());
          //   for (var SegmentArray in itinerariesArray) {
          //
          //     segmentValuesAray = SegmentArray['segments'];
          //      print('segmentArray...');
          //      print(segmentValuesAray);
          //     // print('segment cnt ');
          //     // print(segmentValuesAray.length);
          //     // segmentValuesAraycnt.add(segmentValuesAray.length.toString());
          //     // print('segmentValuesAraycnt....');
          //     // print(segmentValuesAraycnt.length);
          //
          //     setState(() {
          //       print('segmentArray...');
          //       print('segment cnt ');
          //       print(segmentValuesAray.length);
          //       var cnt = '';
          //       cnt = segmentValuesAray.length.toString();
          //       segmentValuesAraycnt.add(cnt);
          //       print('segmentValuesAraycnt....');
          //       print(segmentValuesAraycnt);
          //     });
          //     //print(segmentValuesAray.first);
          //     // firstSegment = segmentValuesAray.first;
          //     // print('firstSegment....');
          //     // print(firstSegment);
          //
          //
          //     OnwardJourney_Segmentrray.add(segmentValuesAray);
          //
          //     if(segmentValuesAray.length == 1) {
          //       var carrierCodestr = segmentValuesAray.first['carrierCode'];
          //       print('new carrierCodestr....');
          //       print(carrierCodestr);
          //       setState(() {
          //         OnwardJourney_carrierCodeArray.add(carrierCodestr);
          //       });
          //
          //       // depiataCode = segmentValuesAray['departure'];
          //       //   print('dep...');
          //       //   print(depiataCode);
          //
          //       for (var DeparturArray in segmentValuesAray) {
          //         var carrierCodestr = DeparturArray['carrierCode'];
          //         print('careercode.');
          //         print(carrierCodestr);
          //         setState(() {
          //           getUserDetails();
          //           // print('Array........');
          //           // print(AirportListArray.toString());
          //         });
          //
          //         // setState(() {
          //         //   OnwardJourney_carrierCodeArray.add(carrierCodestr);
          //         // });
          //         var Dep = DeparturArray['departure'];
          //         depiataCode = Dep['iataCode'];
          //         print('dep...');
          //         print(depiataCode);
          //
          //         if(Retrived_Rndtrp_iatacodestr == depiataCode) {
          //           OnwardJourney_depiataCodelist.add(depiataCode);
          //           print('dep array...');
          //           print(OnwardJourney_depiataCodelist);
          //           var departuretime = Dep['at'];
          //           Deptimeconvert =
          //           (new DateFormat.Hm().format(DateTime.parse(departuretime)));
          //           Datestr =
          //           (new DateFormat.yMd().format(DateTime.parse(departuretime)));
          //           OnwardJourney_dateArray.add(Datestr);
          //           OnwardJourney_DeptimeArray.add(Deptimeconvert);
          //         }
          //
          //         var arrival = DeparturArray['arrival'];
          //         arrivalcode = arrival['iataCode'];
          //         print('arrival....');
          //         print(arrivalcode);
          //         Connectflightcnt_Arrival.add(arrivalcode);
          //         if(Retrived_Rndtrp_Destination_iatacodestr == arrivalcode){
          //           OnwardJourney_arrivaliataCodelist.add(arrivalcode);
          //           // print('arrival array...');
          //           // print(OnwardJourney_arrivaliataCodelist);
          //           var arrivaltime = arrival['at'];
          //           var Arrivaltimeconvert = (new DateFormat.Hm().format(
          //               DateTime.parse(arrivaltime)));
          //           OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
          //           // print('last...');
          //           // print(OnwardJourney_ArrivaltimeArray);
          //         }
          //
          //       }
          //     }
          //
          //     else {
          //
          //       var carrierCodestr = segmentValuesAray.first['carrierCode'];
          //       print('new carrierCodestr....');
          //       print(carrierCodestr);
          //       setState(() {
          //         OnwardJourney_carrierCodeArray.add(carrierCodestr);
          //       });
          //       for (var DeparturArray in segmentValuesAray) {
          //         var carrierCodestr = DeparturArray['carrierCode'];
          //         print('careercode.');
          //         print(carrierCodestr);
          //         setState(() {
          //           getUserDetails();
          //           // print('Array........');
          //           // print(AirportListArray.toString());
          //         });
          //
          //         // setState(() {
          //         //   OnwardJourney_carrierCodeArray.add(carrierCodestr);
          //         // });
          //         var Dep = DeparturArray['departure'];
          //         depiataCode = Dep['iataCode'];
          //         print('dep...');
          //         print(depiataCode);
          //
          //         if(Retrived_Oneway_iatacodestr == depiataCode) {
          //           OnwardJourney_depiataCodelist.add(depiataCode);
          //           print('dep array...');
          //           print(OnwardJourney_depiataCodelist);
          //           var departuretime = Dep['at'];
          //           Deptimeconvert =
          //           (new DateFormat.Hm().format(DateTime.parse(departuretime)));
          //           Datestr =
          //           (new DateFormat.yMd().format(DateTime.parse(departuretime)));
          //           OnwardJourney_dateArray.add(Datestr);
          //           OnwardJourney_DeptimeArray.add(Deptimeconvert);
          //         }
          //
          //         var arrival = DeparturArray['arrival'];
          //         arrivalcode = arrival['iataCode'];
          //         print('arrival....');
          //         print(arrivalcode);
          //         Connectflightcnt_Arrival.add(arrivalcode);
          //         if(RetrivedOneway_Oneway_Destinationiatacodestr == arrivalcode){
          //           OnwardJourney_arrivaliataCodelist.add(arrivalcode);
          //           // print('arrival array...');
          //           // print(OnwardJourney_arrivaliataCodelist);
          //           var arrivaltime = arrival['at'];
          //           var Arrivaltimeconvert = (new DateFormat.Hm().format(
          //               DateTime.parse(arrivaltime)));
          //           OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
          //           // print('last...');
          //           // print(OnwardJourney_ArrivaltimeArray);
          //         }
          //
          //       }
          //     }
          //
          //
          //   }
          // }




        }


      }
      for(var Currency_Price in flightData){
        var Currency_Pricestr = Currency_Price['price'];
        print('Currency_Pricestr...');
        print(Currency_Pricestr);
        grandTotalprice = Currency_Pricestr['grandTotal'];
        print('grandTotalprice...');
        print(grandTotalprice);
        grand_totalPricevaluesArray.add(grandTotalprice);
        Round_trip_Currency_Price_Array.add(Currency_Pricestr);

      }


      //validatingAirlineCodes
      for (var validatingAirlineCodesArray in flightData) {
        //travelerPricings
        var validatingAirlineCodes = validatingAirlineCodesArray['validatingAirlineCodes'];
        print('validatingAirlineCodes...');
        print(validatingAirlineCodes.toString());
        validatingAirlineCodesArrayList.add(validatingAirlineCodes);
        // print('validatingAirlineCodesArrayList...');
        //
        //  print(validatingAirlineCodesArrayList);
        // final removedBrackets = validatingAirlineCodesArrayList.toString().substring(1, validatingAirlineCodesArrayList.toString().length - 1);
        // final parts = removedBrackets.split(', ');
        //
        // var joined = parts.map((part) => "'$part'").join(', ');




      }

      //travelerPricings
      for (var priceArray in flightData) {
        //travelerPricings
        var travelerPricings_Array = priceArray['travelerPricings'];
        print('price Array...');
        print(travelerPricings_Array);
        for(var travelidArray in travelerPricings_Array){
          String travelerId = '';
          travelerId = travelidArray['travelerId'];
          print('travelerId...');
          print(travelerId);
          travelerIdArray.add(travelerId);
        }
        print('last travelerId...');
        print(travelerIdArray.last);

        Round_trip_travelerPricingslistArray.add(travelerPricings_Array);
        List filterpriceArray = travelerPricings_Array.where((
            o) => o['travelerId'] == '1').toList();
        print('filtered...');
        print(filterpriceArray);
        for (var price in filterpriceArray) {
          var priceArray = price['price'];
          print('total price value..');
          print(priceArray);
          totalpricevalues = priceArray['total'];
          print('total amt..');
          print(totalpricevalues);
          totalPricevaluesArray.add(totalpricevalues);
          var cabin_class_array = price['fareDetailsBySegment'];
          print('cabin_class_array..');
          print(cabin_class_array);

          for(var cabinvalueArray in cabin_class_array){
            cabintrvalue = cabinvalueArray['cabin'];
            print('cabin value...');
            print(cabintrvalue);
            var includedCheckedBags = cabinvalueArray['includedCheckedBags'] ?? '';
            // print('includedCheckedBags.

            cabintrvalue_Array.add(cabintrvalue);
          }
        }
      }
      //fareRules
      for(var fareRules in flightData){
        var fareRulesstr = fareRules['fareRules'] ?? '';
        print('fareRulesstr..... empty');
        print(fareRulesstr);
        Round_trip_fareRulesArray.add(fareRulesstr);
      }
    }

    else if (response.statusCode == 401){
      final snackBar = SnackBar(
        content: Text('failed!,please try again...'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
              actions: <Widget>[
              ],
              centerTitle: true,
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
              title: Text('Multi city Flight Search', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.w900,
                      fontSize: 20)),
            ),
            body: Center(
              child: isLoading?
              CircularProgressIndicator():
              Column(
                children: <Widget>[
                  //Container(color: Colors.red, height: 50),
                  new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                    child:Container(
                        width: 400,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Image.asset(
                              "images/aeroplane_image.png",
                              height: 125.0,
                              width: 400.0,
                              fit: BoxFit.fill
                          ),
                        )
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.pinkAccent,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[Colors.white, Colors.white]),
                      ),

                      child: LayoutBuilder(
                        builder: (context, constraint) {
                          // Departuretextstr = 'Departure To ' + ' '+  RetrivedOneway_Oneway_Destinationiatacodestr;
                          //
                          // flight_departurests = 'Price per passenger, taxes and fees included';

                          // if(segmentValuesAray.length == 1){
                          //   Connectedflightstr = 'Non Stop';
                          // } else {
                          //   Connectedflightstr = segmentValuesAray.length.toString() + ' '+ 'Segments';
                          // }

                          var uuid = Uuid();

                          // Generate a v1 (time-based) id
                          // var v1 = uuid.v1(); //
                          // print('ama-c1');
                          // print(v1);
                          // amaClientRef = uuid.v4();  // Generates a random UUID
                          // print('amaClientRef1....');
                          // print(amaClientRef);

                          if(failurestr == ""){
                            if(sourcevalue == "") {
                              flightstatusstr = 'Not found flights this route';
                            } else {
                              flightstatusstr = 'Departure To ' + ' '+  RetrivedOneway_Oneway_Destinationiatacodestr;
                              flight_departurests = 'Price per passenger, taxes and fees included';
                            }
                          } else {
                            print('api failure...');
                            flightstatusstr = 'Please try again...';
                          }
                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                //Text('Your Apartments'),
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                  height: 80,
                                  width: 360,
                                  child: Column(
                                    children: [

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          flightstatusstr,
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          flight_departurests,
                                          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    //itemCount: snapshot.data.length + 1 ?? '',
                                    // itemCount: totalPricevaluesArray.length ,
                                    itemCount: OnwardJourney_ArrivaltimeArray.length ,



                                    // itemCount: totalPricevaluesArray.length ,
                                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                                    itemBuilder: (BuildContext context, int index) {
                                      var Carrercodestr = OnwardJourney_carrierCodeArray1[index].toString();
                                      List newLst_airport = AirportListArray.first.where( (o) => o['airlineCode'] == Carrercodestr).toList();
                                      print('jump code...');
                                      //  print(newLst_airport);
                                      for(var airlinenamearray in newLst_airport){
                                        var Airline_name = airlinenamearray['airlineName'];
                                        convertedAirlineArray.add(Airline_name);
                                        var Airline_logo = airlinenamearray['airlineLogo'];
                                        AirlinelogoArray.add(Airline_logo);
                                      }

                                      //Return Journey

                                      // if(widget.Received_destination_Airports.first == arrivalcode) {
                                      //
                                      //   var Return_Carrercodestr = OnwardJourney_carrierCodeArray1[index].toString() ?? 0;
                                      //   print('Return_Carrercodestr1....');
                                      //   print(OnwardJourney_carrierCodeArray1[index].toString());
                                      //   print('Return_Carrercodestr....');
                                      //   print(Return_Carrercodestr);
                                      //
                                      //   List Return_newLst_airport = AirportListArray.first.where( (o) => o['airlineCode'] == Return_Carrercodestr).toList();
                                      //   print('jump code2...');
                                      //   //  print(newLst_airport);
                                      //   for(var Return_airlinenamearray in Return_newLst_airport){
                                      //     var Return_Airline_name = Return_airlinenamearray['airlineName'];
                                      //     Return_convertedAirlineArray.add(Return_Airline_name);
                                      //     var Return_Airline_logo = Return_airlinenamearray['airlineLogo'];
                                      //     Return_AirlinelogoArray.add(Return_Airline_logo);
                                      //   }
                                      // } else {
                                      //   //var Return_Carrercodestr = OnwardJourney_carrierCodeArray1[index].toString() ?? 'empty';
                                      //   // print('calling Return_Carrercodestr1....');
                                      //   // print(ReturnJourney_carrierCodeArray1[index].toString());
                                      //   // print('Return_Carrercodestr....');
                                      //   // print(Return_Carrercodestr);
                                      //   //
                                      //   // List Return_newLst_airport = AirportListArray.first.where( (o) => o['airlineCode'] == Return_Carrercodestr).toList();
                                      //   // print('jump code2...');
                                      //   //  print(newLst_airport);
                                      //   for(var Return_airlinenamearray in Return_newLst_airport){
                                      //     var Return_Airline_name = Return_airlinenamearray['airlineName'];
                                      //     Return_convertedAirlineArray.add(Return_Airline_name);
                                      //     var Return_Airline_logo = Return_airlinenamearray['airlineLogo'];
                                      //     Return_AirlinelogoArray.add(Return_Airline_logo);
                                      //   }
                                      //
                                      // }






                                      // for (var airlinenameArray in AirportListArray.first){
                                      //
                                      //   var airlineCode = airlinenameArray['airlineCode'];
                                      //   // print('airlineCode...');
                                      //   // print(airlineCode);
                                      //   if(airlineCode == OnwardJourney_carrierCodeArray[index].toString()){
                                      //     var airlineName = airlinenameArray['airlineName'];
                                      //     // print('airlineName...');
                                      //     // print(airlineName);
                                      //     convertedAirlineArray.add(airlineName);
                                      //     var airlineLogo = airlinenameArray['airlineLogo'];
                                      //     AirlinelogoArray.add(airlineLogo);
                                      //   }
                                      // }

                                      // if(CurrencyCodestr == "USD"){
                                      //   totalpricevalues = grand_totalPricevaluesArray[index].toString();
                                      //   //print("I have \$$dollars."); // I have $42.
                                      //   // totalpriceSignvalues = "\$$totalpricevalues";
                                      //   totalpriceSignvalues = "\USD $totalpricevalues";
                                      // } else {
                                      //   totalpricevalues = grand_totalPricevaluesArray[index].toString();
                                      //   totalpriceSignvalues = "\ZAR $totalpricevalues";
                                      // }
                                      return Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Card(
                                          child: Column(
                                            children: <Widget>[
                                              // Column(
                                              InkWell(
                                                child: Column(

                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                        if (widget.Received_departure_Airports.length == 1 && widget.Received_destination_Airports.length == 1) ...[
                                                          Container(
                                                            height: 180,
                                                            width: 300,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: [
                                                                Text('Flight Details                    ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),

                                                                // Text(OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),

                                                                Text(OnwardJourney_DeptimeArray[index].toString() + '---------------------------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),
                                                                SizedBox(),
                                                                Text(OnwardJourney_depiataCodelist[index].toString() + '            '+ segmentValuesAraycnt[index] + ' ' + 'Segments' +'             '+  OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Container(
                                                                  height: 50,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 0,
                                                                      ),
                                                                      Container(
                                                                        height: 45,
                                                                        width: 130,
                                                                        color: Colors.transparent,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(height: 10,),
                                                                            // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                            // ),),
                                                                            Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //SizedBox(width: 40,),
                                                                      // Container(
                                                                      //   height: 45,
                                                                      //   width: 150,
                                                                      //   color: Colors.transparent,
                                                                      //   child: Column(
                                                                      //     children: [
                                                                      //       SizedBox(height: 10,),
                                                                      //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      //       // ),),
                                                                      //       Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 50,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 300,
                                                                  color: Colors.transparent,
                                                                  child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                          ] else if(widget.Received_departure_Airports.length == 2 && widget.Received_destination_Airports.length == 2)...[

                                                          Container(
                                                            height: 180,
                                                            width: 300,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: [
                                                                Text('First Flight Details                    ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),

                                                                // Text(OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),

                                                                Text(OnwardJourney_DeptimeArray[index].toString() + '---------------------------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),
                                                                SizedBox(),
                                                                Text(OnwardJourney_depiataCodelist[index].toString() + '            '+ segmentValuesAraycnt[index] + ' ' + 'Segments' +'             '+  OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Container(
                                                                  height: 50,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 0,
                                                                      ),
                                                                      Container(
                                                                        height: 45,
                                                                        width: 130,
                                                                        color: Colors.transparent,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(height: 10,),
                                                                            // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                            // ),),
                                                                            Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //SizedBox(width: 40,),
                                                                      // Container(
                                                                      //   height: 45,
                                                                      //   width: 150,
                                                                      //   color: Colors.transparent,
                                                                      //   child: Column(
                                                                      //     children: [
                                                                      //       SizedBox(height: 10,),
                                                                      //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      //       // ),),
                                                                      //       Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 50,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 300,
                                                                  color: Colors.transparent,
                                                                  child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          Container(
                                                            height: 180,
                                                            width: 300,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: [
                                                                Text('Second Flight Details                           ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),

                                                                // Text(ReturnJourney_DeptimeArray[index].toString() + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                // ),),

                                                                // Column(
                                                                //   children: [
                                                                //     if (widget.Received_destination_Airports[1] == arrivalcode) ...[
                                                                //
                                                                //
                                                                //       Text(first_seg_OnwardJourney_DeptimeArray[index].toString() + '------------sec----------------------> ' + first_Seg_OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       ),),
                                                                //       //
                                                                //       // Text('------------sec----------------------> ' + first_Seg_OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       // ),),
                                                                //
                                                                //
                                                                //     ] else...[
                                                                //
                                                                //       Text(ReturnJourney_DeptimeArray[index].toString() + '------------------second----------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       ),),
                                                                //     ],
                                                                //   ],
                                                                // ),



                                                                // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),

                                                                Text(ReturnJourney_DeptimeArray[index].toString() + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray[index].toString() ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Text(ReturnJourney_depiataCodelist[index].toString() + '           '+ segmentValuesAraycnt[index] + ' ' + 'Segments' +'             '+  ReturnJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Container(
                                                                  height: 50,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 0,
                                                                      ),
                                                                      Container(
                                                                        height: 45,
                                                                        width: 130,
                                                                        color: Colors.transparent,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(height: 10,),
                                                                            // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                            // ),),
                                                                            Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //SizedBox(width: 40,),
                                                                      // Container(
                                                                      //   height: 45,
                                                                      //   width: 150,
                                                                      //   color: Colors.transparent,
                                                                      //   child: Column(
                                                                      //     children: [
                                                                      //       SizedBox(height: 10,),
                                                                      //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      //       // ),),
                                                                      //       Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   height: 20,
                                                                //   width: 360,
                                                                //   color: Colors.transparent,
                                                                //   child: Row(
                                                                //     children: [
                                                                //       SizedBox(
                                                                //         width: 30,
                                                                //       ),
                                                                // //       Container(
                                                                // //         height: 40,
                                                                // //         width: 50,
                                                                // //         decoration: BoxDecoration(
                                                                // //             image: DecorationImage(image: NetworkImage(Return_AirlinelogoArray[index].toString()),
                                                                // //                 fit: BoxFit.cover)
                                                                // //         ),
                                                                // //       ),
                                                                // //       SizedBox(width: 40,),
                                                                // //
                                                                // //
                                                                // //
                                                                // //       // Column(
                                                                // //       //   children: [
                                                                // //       //     if (widget.Received_destination_Airports.first == depiataCode) ...[
                                                                // //       //       Container(
                                                                // //       //         height: 20,
                                                                // //       //         width: 150,
                                                                // //       //         color: Colors.transparent,
                                                                // //       //         child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //         ),),
                                                                // //       //       )
                                                                // //       //
                                                                // //       //     ] else...[
                                                                // //       //       Container(
                                                                // //       //         height: 20,
                                                                // //       //         width: 150,
                                                                // //       //         color: Colors.transparent,
                                                                // //       //         child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //         ),),
                                                                // //       //       )
                                                                // //       //     ],
                                                                // //       //   ],
                                                                // //       // ),
                                                                // //
                                                                // //
                                                                // //
                                                                // //
                                                                // //       // Container(
                                                                // //       //   height: 20,
                                                                // //       //   width: 150,
                                                                // //       //   color: Colors.transparent,
                                                                // //       //   child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + ReturnJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //   ),),
                                                                // //       // )
                                                                // //     ],
                                                                // //   ),
                                                                // // ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 50,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),


                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        // child:  Text(convertedAirlineArray[index].toString() + "   -" + ReturnJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        // ),),
                                                                        child:  Text( SecondJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 300,
                                                                  color: Colors.transparent,
                                                                  child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                        ] else if(widget.Received_departure_Airports.length == 3 && widget.Received_destination_Airports.length == 3)...[

                                                          Container(
                                                            height: 180,
                                                            width: 300,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: [
                                                                Text('First Flight Details                    ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),

                                                                // Text(OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),

                                                                Text(OnwardJourney_DeptimeArray[index].toString() + '---------------------------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),
                                                                SizedBox(),
                                                                Text(OnwardJourney_depiataCodelist[index].toString() + '            '+ segmentValuesAraycnt[index] + ' ' + 'Segments' +'             '+  OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Container(
                                                                  height: 50,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 0,
                                                                      ),
                                                                      Container(
                                                                        height: 45,
                                                                        width: 130,
                                                                        color: Colors.transparent,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(height: 10,),
                                                                            // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                            // ),),
                                                                            Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //SizedBox(width: 40,),
                                                                      // Container(
                                                                      //   height: 45,
                                                                      //   width: 150,
                                                                      //   color: Colors.transparent,
                                                                      //   child: Column(
                                                                      //     children: [
                                                                      //       SizedBox(height: 10,),
                                                                      //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      //       // ),),
                                                                      //       Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 50,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 300,
                                                                  color: Colors.transparent,
                                                                  child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          Container(
                                                            height: 180,
                                                            width: 300,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: [
                                                                Text('second Flight Details                           ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),

                                                                // Text(ReturnJourney_DeptimeArray[index].toString() + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                // ),),

                                                                // Column(
                                                                //   children: [
                                                                //     if (widget.Received_destination_Airports[1] == arrivalcode) ...[
                                                                //
                                                                //
                                                                //       Text(first_seg_OnwardJourney_DeptimeArray[index].toString() + '------------sec----------------------> ' + first_Seg_OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       ),),
                                                                //       //
                                                                //       // Text('------------sec----------------------> ' + first_Seg_OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       // ),),
                                                                //
                                                                //
                                                                //     ] else...[
                                                                //
                                                                //       Text(ReturnJourney_DeptimeArray[index].toString() + '------------------second----------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       ),),
                                                                //     ],
                                                                //   ],
                                                                // ),



                                                                // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),

                                                                Text(ReturnJourney_DeptimeArray[index].toString() + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Text(ReturnJourney_depiataCodelist[index].toString() + '           '+ segmentValuesAraycnt[index] + ' ' + 'Segments' +'             '+  ReturnJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Container(
                                                                  height: 50,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 0,
                                                                      ),
                                                                      Container(
                                                                        height: 45,
                                                                        width: 130,
                                                                        color: Colors.transparent,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(height: 10,),
                                                                            // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                            // ),),
                                                                            Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //SizedBox(width: 40,),
                                                                      // Container(
                                                                      //   height: 45,
                                                                      //   width: 150,
                                                                      //   color: Colors.transparent,
                                                                      //   child: Column(
                                                                      //     children: [
                                                                      //       SizedBox(height: 10,),
                                                                      //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      //       // ),),
                                                                      //       Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   height: 20,
                                                                //   width: 360,
                                                                //   color: Colors.transparent,
                                                                //   child: Row(
                                                                //     children: [
                                                                //       SizedBox(
                                                                //         width: 30,
                                                                //       ),
                                                                // //       Container(
                                                                // //         height: 40,
                                                                // //         width: 50,
                                                                // //         decoration: BoxDecoration(
                                                                // //             image: DecorationImage(image: NetworkImage(Return_AirlinelogoArray[index].toString()),
                                                                // //                 fit: BoxFit.cover)
                                                                // //         ),
                                                                // //       ),
                                                                // //       SizedBox(width: 40,),
                                                                // //
                                                                // //
                                                                // //
                                                                // //       // Column(
                                                                // //       //   children: [
                                                                // //       //     if (widget.Received_destination_Airports.first == depiataCode) ...[
                                                                // //       //       Container(
                                                                // //       //         height: 20,
                                                                // //       //         width: 150,
                                                                // //       //         color: Colors.transparent,
                                                                // //       //         child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //         ),),
                                                                // //       //       )
                                                                // //       //
                                                                // //       //     ] else...[
                                                                // //       //       Container(
                                                                // //       //         height: 20,
                                                                // //       //         width: 150,
                                                                // //       //         color: Colors.transparent,
                                                                // //       //         child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //         ),),
                                                                // //       //       )
                                                                // //       //     ],
                                                                // //       //   ],
                                                                // //       // ),
                                                                // //
                                                                // //
                                                                // //
                                                                // //
                                                                // //       // Container(
                                                                // //       //   height: 20,
                                                                // //       //   width: 150,
                                                                // //       //   color: Colors.transparent,
                                                                // //       //   child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + ReturnJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //   ),),
                                                                // //       // )
                                                                // //     ],
                                                                // //   ),
                                                                // // ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 50,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 300,
                                                                  color: Colors.transparent,
                                                                  child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                )

                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          Container(
                                                            height: 180,
                                                            width: 300,
                                                            color: Colors.white,
                                                            child: Column(
                                                              children: [
                                                                Text('Third Flight Details                           ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),

                                                                // Text(ReturnJourney_DeptimeArray[index].toString() + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                // ),),

                                                                // Column(
                                                                //   children: [
                                                                //     if (widget.Received_destination_Airports[1] == arrivalcode) ...[
                                                                //
                                                                //
                                                                //       Text(first_seg_OnwardJourney_DeptimeArray[index].toString() + '------------sec----------------------> ' + first_Seg_OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       ),),
                                                                //       //
                                                                //       // Text('------------sec----------------------> ' + first_Seg_OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       // ),),
                                                                //
                                                                //
                                                                //     ] else...[
                                                                //
                                                                //       Text(ReturnJourney_DeptimeArray[index].toString() + '------------------second----------------> ' + ReturnJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                //       ),),
                                                                //     ],
                                                                //   ],
                                                                // ),



                                                                // Text(Retrived_Rndtrp_Destinationiatacodestr[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                                // ),),

                                                                Text(Multi_third_Journey_DeptimeArray[index].toString() + '----------------------------------> ' + Multi_third_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Text(Multi_third_Journey_depiataCodelist[index].toString() + '           '+ segmentValuesAraycnt[index] + ' ' + 'Segments' +'             '+  Multi_third_Journey_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
                                                                Container(
                                                                  height: 50,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 0,
                                                                      ),
                                                                      Container(
                                                                        height: 45,
                                                                        width: 130,
                                                                        color: Colors.transparent,
                                                                        child: Column(
                                                                          children: [
                                                                            SizedBox(height: 10,),
                                                                            // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                            // ),),
                                                                            Text( "Seats:${numberOfBookableSeats}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //SizedBox(width: 40,),
                                                                      // Container(
                                                                      //   height: 45,
                                                                      //   width: 150,
                                                                      //   color: Colors.transparent,
                                                                      //   child: Column(
                                                                      //     children: [
                                                                      //       SizedBox(height: 10,),
                                                                      //       // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      //       // ),),
                                                                      //       Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800,color: Colors.red
                                                                      //       ),),
                                                                      //     ],
                                                                      //   ),
                                                                      // )
                                                                    ],
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   height: 20,
                                                                //   width: 360,
                                                                //   color: Colors.transparent,
                                                                //   child: Row(
                                                                //     children: [
                                                                //       SizedBox(
                                                                //         width: 30,
                                                                //       ),
                                                                // //       Container(
                                                                // //         height: 40,
                                                                // //         width: 50,
                                                                // //         decoration: BoxDecoration(
                                                                // //             image: DecorationImage(image: NetworkImage(Return_AirlinelogoArray[index].toString()),
                                                                // //                 fit: BoxFit.cover)
                                                                // //         ),
                                                                // //       ),
                                                                // //       SizedBox(width: 40,),
                                                                // //
                                                                // //
                                                                // //
                                                                // //       // Column(
                                                                // //       //   children: [
                                                                // //       //     if (widget.Received_destination_Airports.first == depiataCode) ...[
                                                                // //       //       Container(
                                                                // //       //         height: 20,
                                                                // //       //         width: 150,
                                                                // //       //         color: Colors.transparent,
                                                                // //       //         child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //         ),),
                                                                // //       //       )
                                                                // //       //
                                                                // //       //     ] else...[
                                                                // //       //       Container(
                                                                // //       //         height: 20,
                                                                // //       //         width: 150,
                                                                // //       //         color: Colors.transparent,
                                                                // //       //         child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + OnwardJourney_arrivaliataCodelist[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //         ),),
                                                                // //       //       )
                                                                // //       //     ],
                                                                // //       //   ],
                                                                // //       // ),
                                                                // //
                                                                // //
                                                                // //
                                                                // //
                                                                // //       // Container(
                                                                // //       //   height: 20,
                                                                // //       //   width: 150,
                                                                // //       //   color: Colors.transparent,
                                                                // //       //   child:  Text(Return_convertedAirlineArray[index].toString() + "   -" + ReturnJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                // //       //   ),),
                                                                // //       // )
                                                                // //     ],
                                                                // //   ),
                                                                // // ),
                                                                Container(
                                                                  height: 20,
                                                                  width: 360,
                                                                  color: Colors.transparent,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 30,
                                                                      ),
                                                                      Container(
                                                                        height: 40,
                                                                        width: 50,
                                                                        decoration: BoxDecoration(
                                                                            image: DecorationImage(image: NetworkImage(AirlinelogoArray[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray1[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Container(
                                                                  height: 40,
                                                                  width: 300,
                                                                  color: Colors.transparent,
                                                                  child:  Text(cabintrvalue_Array[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                  ),),
                                                                )

                                                              ],
                                                            ),
                                                          )
                                                        ],




                                                        // Text(OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                        // ),),
                                                        // Text(OnwardJourney_dateArray[index].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.black
                                                        // ),),





                                                        // Text(OnwardJourney_arrivaliataCodelist[index].toString() + '                                          ' + OnwardJourney_depiataCodelist[index].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black
                                                        // ),),






                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 360,
                                                          color: Colors.transparent,
                                                          child: Container(
                                                            height: 50,
                                                            width: 250,
                                                            margin: const EdgeInsets.only(left: 25.0, right: 0.0),
                                                            child: Row(
                                                              children: [

                                                                Container(
                                                                  height: 40,
                                                                  width: 150,
                                                                  color: Colors.transparent,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(height: 10,),
                                                                      // Text(convertedAirlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                      // ),),
                                                                      Text( "${totalpriceSignvalues}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.red
                                                                      ),),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(width: 50,),

                                                                InkWell(

                                                                  child: Container(
                                                                      height: 45,
                                                                      width: 100,
                                                                      color: Colors.green,
                                                                      child: Align(
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                            "Select",
                                                                            style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w800,color: Colors.white),
                                                                            textAlign: TextAlign.center
                                                                        ),
                                                                      )
                                                                  ),
                                                                  onTap: () async {
                                                                    print('continue btn tapped....');

                                                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => RoundtripJourney_Flight_Details()),
                                                                    );
                                                                    prefs.setString('flightid_key', flightoffer_ID_Array[index]);;
                                                                    prefs.setString('source_key', sourceArray[index]);
                                                                    prefs.setString('lastTicketing_Datekey', lastTicketingDateArray[index]);
                                                                    prefs.setString('lastTicketingDate_Timekey', lastTicketingDateTimeArray[index]);
                                                                    prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsArray[index].toString());
                                                                    prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray1[index]);
                                                                    prefs.setString('flight_optionkey', 'round-trip');
                                                                    print('index value.....');
                                                                    print(ReturnJourney_carrierCodeArray1.length);


                                                                    if(ReturnJourney_carrierCodeArray1.length == 0) {
                                                                      print('empty calling....');
                                                                    } else {
                                                                      print('not empty ....');

                                                                      prefs.setString('return_carrierCodekey', ReturnJourney_carrierCodeArray1[index] ?? 'empty');

                                                                    }


                                                                    print('career code...');
                                                                    print(OnwardJourney_carrierCodeArray1[index]);
                                                                    // prefs.setString('durationkey', durationArray[index]);
                                                                    String Itinerary_JsonData = jsonEncode(Round_trip_ItinerariArray[index]);
                                                                    print('rnd trip Itinerarykey segJson...');
                                                                    print(Itinerary_JsonData);
                                                                    prefs.setString('Itinerarykey', Itinerary_JsonData);
                                                                    String validatingAirlineCodesArrayData = jsonEncode(validatingAirlineCodesArrayList[index]);
                                                                    prefs.setString('validatingAirlineCodeskey', validatingAirlineCodesArrayData);
                                                                    print('validatingAirlineCodesArrayData......');
                                                                    print(validatingAirlineCodesArrayData);
                                                                    String travelerPricings = jsonEncode(Round_trip_travelerPricingslistArray[index]);
                                                                    prefs.setString('Round_trip_travelerPricingskey', travelerPricings);
                                                                    String Currency_Price = jsonEncode(Round_trip_Currency_Price_Array[index]);
                                                                    prefs.setString('Round_trip_Currency_Pricekey', Currency_Price);
                                                                    String fareRulesstr = jsonEncode(Round_trip_fareRulesArray[index]);
                                                                    print('fareRulesstr...');
                                                                    print(fareRulesstr);
                                                                    prefs.setString('Round_trip_fareRuleskey', fareRulesstr);
                                                                    prefs.setString('airlinekey', convertedAirlineArray[index]);
                                                                    prefs.setString('logokey', AirlinelogoArray[index]);
                                                                    //Return airline name and logo...
                                                                    prefs.setString('return_airlinekey', Return_convertedAirlineArray[index]);
                                                                    prefs.setString('return_logokey', Return_AirlinelogoArray[index]);
                                                                    prefs.setString('return_journey_departure_time_key', OnwardJourney_DeptimeArray[index]);
                                                                    prefs.setString('return_journey_arrival_time_key', OnwardJourney_DeptimeArray[index]);





                                                                    //Baggage
                                                                    // prefs.setInt('weightkey', weight) ?? 0;
                                                                    // prefs.setInt('quantitykey', quantity) ?? 0;
                                                                    Passengers_cnt = Aduld_cnt + children_cnt + infant_cnt;
                                                                    prefs.setInt('Passengers_cntkey', Passengers_cnt) ?? 0;
                                                                    prefs.setInt('Passengers_Adult_cntkey', Aduld_cnt) ?? 0;
                                                                    prefs.setInt('Passengers_Child_cntkey', children_cnt) ?? 0;
                                                                    prefs.setInt('Passengers_infant_cntkey', infant_cnt) ?? 0;



                                                                    print('sent value');
                                                                    print(Passengers_cnt);

                                                                    //Currency code
                                                                    prefs.setString('Rndcurrency_code_dropdownvaluekey', CurrencyCodestr);

                                                                    print('sending Currency code value...');
                                                                    print(CurrencyCodestr);

                                                                    //Cabin Baggage
                                                                    // prefs.setInt('Cabin_weightkey', Cabin_weight) ?? 0;
                                                                    // prefs.setString('Cabin_quantitykey', Cabin_quantity) ?? "";




                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),

                                                onTap: () async{

                                                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  //
                                                  // // Navigator.push(
                                                  // //   context,
                                                  // //   MaterialPageRoute(
                                                  // //       builder: (context) => OnwardJourney_Flight_Details()),
                                                  // // );
                                                  // prefs.setString('flightid_key', flightoffer_ID_Array[index]);;
                                                  // prefs.setString('source_key', sourceArray[index]);
                                                  // prefs.setString('lastTicketing_Datekey', lastTicketingDateArray[index]);
                                                  // prefs.setString('lastTicketingDate_Timekey', lastTicketingDateTimeArray[index]);
                                                  // prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsArray[index].toString());
                                                  // prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray1[index]);
                                                  // prefs.setString('durationkey', durationArray[index]);
                                                  // prefs.setString('flight_optionkey', 'one-way');
                                                  //
                                                  // String validatingAirlineCodesArrayData = jsonEncode(validatingAirlineCodesArrayList[index]);
                                                  // prefs.setString('validatingAirlineCodeskey', validatingAirlineCodesArrayData);
                                                  // // print('validatingAirlineCodesArrayData......');
                                                  // // print(validatingAirlineCodesArrayData);
                                                  // String segJson = jsonEncode(OnwardJourney_Segmentrray[index]);
                                                  // prefs.setString('Segmentkey', segJson);
                                                  // String travelerPricings = jsonEncode(travelerPricingslistArray[index]);
                                                  // prefs.setString('travelerPricingskey', travelerPricings);
                                                  // String Currency_Price = jsonEncode(Round_trip_Currency_Price_Array[index]);
                                                  // prefs.setString('Round_trip_Currency_Pricekey', Currency_Price);
                                                  // String fareRulesstr = jsonEncode(fareRulesArray[index]);
                                                  // print('fareRulesstr1...');
                                                  // print(fareRulesstr);
                                                  // prefs.setString('fareRuleskey', fareRulesstr);

                                                },

                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                Column(
                                  children:<Widget>[
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
              ),
            )
        )
    );
  }
}





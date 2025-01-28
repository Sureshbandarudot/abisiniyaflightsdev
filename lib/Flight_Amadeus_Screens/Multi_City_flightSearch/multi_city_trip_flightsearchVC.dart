
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

import '../Multi_city_Airport_pickup/Multi_city_price_details/Multi_city_price_detailsVC.dart';
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

  // List to hold the departure and destination cities
  List<Map<String, TextEditingController>> flights = [
    {
      "departure": TextEditingController(),
      "destination": TextEditingController(),
      "departureDate": TextEditingController(),

    }
  ];
  // Add a new flight segment
  void _addFlightSegment() {
    setState(() {
      flights.add({
        "departure": TextEditingController(),
        "destination": TextEditingController(),
        "departureDate": TextEditingController(),

      });
    });
  }

  // List<Map<String, String>> flights = [
  //   {
  //     "departure": "New York",
  //     "destination": "Los Angeles",
  //     "departureDate": "2025-05-20",
  //   },
  // ];

  //
  // Date format
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  String multicity_departure_airport = '';
  String multicity_destination_airport = '';
  String multicity_departure_Date = '';
  List<String> departureAirports = [];
  List<String> destinationAirports = [];
  List<String> multicity_dates = [];

  List<String> selected_dates = [];
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
  //multi city if two flights are operating
  var secondJouney_firstflight_airlineArray = [];
  var secondJouney_firstflight_airlinelogo= [];
  var secondJouney_secondflight_airlineArray = [];
  var secondJouney_secondflight_airlinelogo= [];

  //  //multi city if three flights are operating
    var thirdJouney_firstflight_airlineArray = [];
    var thirdJouney_firstflight_airlinelogo= [];
    var thirdJouney_secondflight_airlineArray = [];
    var thirdJouney_secondflight_airlinelogo= [];
  var thirdJouney_thirdflight_airlineArray = [];
  var thirdJouney_thirdflight_airlinelogo= [];



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


  //Departure timings...
  var firstJourney_departure_timeArray = [];
  var secondJourney_first_departure_timeArray = [];
  var secondJourney_second_departure_timeArray = [];
  var thirdJourney_first_departure_timeArray = [];
  var thirdJourney_second_departure_timeArray = [];
  var thirdJourney_third_departure_timeArray = [];
  //Arrival timings...
  var firstJourney_arrival_timeArray = [];
  var secondJourney_first_arrival_timeArray = [];
  var secondJourney_second_arrival_timeArray = [];
  var thirdJourney_first_arrival_timeArray = [];
  var thirdJourney_second_arrival_timeArray = [];
  var thirdJourney_third_arrival_timeArray = [];
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
  //Multi city careercode variables...
  var Multi_third_Journey_firstcarrierCodeArray = [];
  var Multi_third_Journey_secondcarrierCodeArray = [];
  var Multi_third_Journey_thirdcarrierCodeArray = [];



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
      print(widget.Received_departure_Airports[0]);
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
        print('segmentData123 length Array.....');
        print(FlightDataArray.length);

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
            String duration = SegmentArray['duration'];
            print('duration...');
            print(duration);
            durationArray.add(duration);
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
                  } else if (segmentValuesAray.length == 3) {
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
                    print('2nd last...');
                    print(OnwardJourney_ArrivaltimeArray);
                  }else if (segmentValuesAray.length == 3) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                    print('3RD last...');
                    print(OnwardJourney_ArrivaltimeArray);
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
                  } else if (segmentValuesAray.length == 3) {
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
                  } else if (segmentValuesAray.length == 3) {
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
                    print('second journey second flight departure...');
                    print(Deptimeconvert);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    SecondJourney_carrierCodeArray.add(carrierCodestr);
                    print('second journey first flight...2');
                    print(carrierCodestr);
                    print(SecondJourney_carrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    print('second journey second flight departure...');
                    print(Deptimeconvert);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 3) {
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
                      print(ReturnJourney_ArrivaltimeArray);
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
                      print(ReturnJourney_ArrivaltimeArray);
                    } else if (segmentValuesAray.length == 3) {
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
                      print(ReturnJourney_ArrivaltimeArray);
                    }
                  }
              }



              //Three fligts data...
              if (widget.Received_departure_Airports.length == 3 &&
                  widget.Received_destination_Airports.length == 3) {
                var Dep = DeparturArray['departure'];
                depiataCode = Dep['iataCode'];
                print('3re dep..');
                print(depiataCode);
                if (widget.Received_departure_Airports.first == depiataCode) {
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_firstcarrierCodeArray.add(carrierCodestr);
                    print('Multi_third_Journey_firstcarrierCodeArray..1');
                    print(Multi_third_Journey_firstcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_firstcarrierCodeArray.add(carrierCodestr);
                    print('Multi_third_Journey_firstcarrierCodeArray..2');
                    print(Multi_third_Journey_firstcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 3) {
                    OnwardJourney_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_firstcarrierCodeArray.add(carrierCodestr);
                    print('Multi_third_Journey_firstcarrierCodeArray..2');
                    print(Multi_third_Journey_firstcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    OnwardJourney_dateArray.add(Datestr);
                    print(Deptimeconvert);
                    OnwardJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }

                var arrival = DeparturArray['arrival'];
                arrivalcode = arrival['iataCode'];
                print('three flights arrival....');
                print(widget.Received_destination_Airports.first);
                print(arrivalcode);
                if (widget.Received_destination_Airports.first == arrivalcode) {
                  print('First flight arrival');
                  if (segmentValuesAray.length == 1) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    Multi_third_Journey_firstcarrierCodeArray.add(carrierCodestr);
                    print('Multi_third_Journey_firstcarrierCodeArray..3');
                    print(Multi_third_Journey_firstcarrierCodeArray);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    print('2 segments time array1...');
                    print(Arrivaltimeconvert);
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    Multi_third_Journey_firstcarrierCodeArray.add(carrierCodestr);
                    print('Multi_third_Journey_firstcarrierCodeArray..4');
                    print(Multi_third_Journey_firstcarrierCodeArray);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    print('2 segments time array2...');
                    print(Arrivaltimeconvert);
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                  } else if (segmentValuesAray.length == 3) {
                    OnwardJourney_arrivaliataCodelist.add(arrivalcode);
                    Multi_third_Journey_firstcarrierCodeArray.add(carrierCodestr);
                    print('Multi_third_Journey_firstcarrierCodeArray..4');
                    print(Multi_third_Journey_firstcarrierCodeArray);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    print('2 segments time array2...');
                    print(Arrivaltimeconvert);
                    OnwardJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
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
                    Multi_third_Journey_secondcarrierCodeArray.add(carrierCodestr);
                    print('Multi city second flight carrer---1');
                    print(Multi_third_Journey_secondcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_secondcarrierCodeArray.add(carrierCodestr);
                    print('Multi city second flight carrer---2');
                    print(Multi_third_Journey_secondcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 3) {
                    ReturnJourney_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_secondcarrierCodeArray.add(carrierCodestr);
                    print('Multi city second flight carrer---2');
                    print(Multi_third_Journey_secondcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    ReturnJourney_dateArray.add(Datestr);
                    ReturnJourney_DeptimeArray.add(Deptimeconvert);
                  }
                }
                arrivalcode = arrival['iataCode'];
                print('second arrival time...');
                print(arrivalcode);
                print(widget.Received_destination_Airports[1]);
                  if (widget.Received_destination_Airports[1] == arrivalcode) {
                    print('socond flight....1');
                    print(segmentValuesAray.length);
                    if (segmentValuesAray.length == 1) {
                      print('socond flight....2');
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      Multi_third_Journey_secondcarrierCodeArray.add(carrierCodestr);
                      print('Multi city second flight carrer---3');
                      print(Multi_third_Journey_secondcarrierCodeArray);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));

                      print('1st lenth arrival time2...');
                      print(Arrivaltimeconvert);
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);

                      print('ReturnJourney_ArrivaltimeArray....1');
                      print(ReturnJourney_ArrivaltimeArray);
                    } else if (segmentValuesAray.length == 2) {
                      print('2nd socond flight....3');
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      Multi_third_Journey_secondcarrierCodeArray.add(carrierCodestr);
                      print('Multi city second flight carrer---4');
                      print(Multi_third_Journey_secondcarrierCodeArray);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));
                      print('two arrival time2...');
                      print(Arrivaltimeconvert);
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                      print('ReturnJourney_ArrivaltimeArray....2');
                      print(ReturnJourney_ArrivaltimeArray);
                    } else if (segmentValuesAray.length == 3) {
                      print('3rd socond flight....3');
                      ReturnJourney_arrivaliataCodelist.add(arrivalcode);
                      Multi_third_Journey_secondcarrierCodeArray.add(carrierCodestr);
                      print('Multi city second flight carrer---4');
                      print(Multi_third_Journey_secondcarrierCodeArray);
                      var arrivaltime = arrival['at'];
                      var Arrivaltimeconvert = (new DateFormat.Hm().format(
                          DateTime.parse(arrivaltime)));
                      print('three arrival time2...');
                      print(Arrivaltimeconvert);
                      ReturnJourney_ArrivaltimeArray.add(Arrivaltimeconvert);
                      print('ReturnJourney_ArrivaltimeArray....3');
                      print(ReturnJourney_ArrivaltimeArray);
                      print(ReturnJourney_ArrivaltimeArray.last);

                    }
                  }
                  //Third flight details
                if (widget.Received_departure_Airports[2] == depiataCode) {
                  if (segmentValuesAray.length == 1) {
                    Multi_third_Journey_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_thirdcarrierCodeArray.add(carrierCodestr);
                    print('Multi city 3rd flight carrer-.-.1');
                    print(Multi_third_Journey_thirdcarrierCodeArray);
                    var departuretime = Dep['at'];
                    Deptimeconvert =
                    (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                    Datestr =
                    (new DateFormat.yMd().format(
                        DateTime.parse(departuretime)));
                    Multi_third_Journey_dateArray.add(Datestr);
                    Multi_third_Journey_DeptimeArray.add(Deptimeconvert);
                  } else if (segmentValuesAray.length == 2) {
                    Multi_third_Journey_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_thirdcarrierCodeArray.add(carrierCodestr);
                    print('Multi city 3rd flight carrer-.-.2');
                    print(Multi_third_Journey_thirdcarrierCodeArray);
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
                  } else if (segmentValuesAray.length == 3) {
                    Multi_third_Journey_depiataCodelist.add(depiataCode);
                    Multi_third_Journey_thirdcarrierCodeArray.add(carrierCodestr);
                    print('Multi city 3rd flight carrer-.-.2');
                    print(Multi_third_Journey_thirdcarrierCodeArray);
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
                    Multi_third_Journey_thirdcarrierCodeArray.add(carrierCodestr);
                    print('Multi city 3rd flight carrer-.-.3');
                    print(Multi_third_Journey_thirdcarrierCodeArray);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    Multi_third_ArrivaltimeArray.add(Arrivaltimeconvert);
                    print('jkjkjk last123...');
                    print(Arrivaltimeconvert);
                    print(Multi_third_ArrivaltimeArray);
                  } else if (segmentValuesAray.length == 2) {
                    Multi_third_Journey_arrivaliataCodelist.add(arrivalcode);
                    Multi_third_Journey_thirdcarrierCodeArray.add(carrierCodestr);
                    print('Multi city 3rd flight carrer-.-.4');
                    print(Multi_third_Journey_thirdcarrierCodeArray);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    Multi_third_ArrivaltimeArray.add(Arrivaltimeconvert);
                    print('rrrrr kkkkkk last...');
                    print(Arrivaltimeconvert);
                    print(Multi_third_ArrivaltimeArray);
                  } else if (segmentValuesAray.length == 3) {
                    Multi_third_Journey_arrivaliataCodelist.add(arrivalcode);
                    Multi_third_Journey_thirdcarrierCodeArray.add(carrierCodestr);
                    print('Multi city 3rd flight carrer-.-.4');
                    print(Multi_third_Journey_thirdcarrierCodeArray);

                    // print('arrival array...');
                    // print(OnwardJourney_arrivaliataCodelist);
                    var arrivaltime = arrival['at'];
                    var Arrivaltimeconvert = (new DateFormat.Hm().format(
                        DateTime.parse(arrivaltime)));
                    Multi_third_ArrivaltimeArray.add(Arrivaltimeconvert);
                    print(' lm...rrrrr last...');
                    print(Arrivaltimeconvert);
                    print(Multi_third_ArrivaltimeArray);
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
                                      // var Carrercodestr = OnwardJourney_carrierCodeArray1[index].toString();
                                      // List newLst_airport = AirportListArray.first.where( (o) => o['airlineCode'] == Carrercodestr).toList();
                                      // print('jump code...');
                                      // //  print(newLst_airport);
                                      // for(var airlinenamearray in newLst_airport){
                                      //   var Airline_name = airlinenamearray['airlineName'];
                                      //   convertedAirlineArray.add(Airline_name);
                                      //   var Airline_logo = airlinenamearray['airlineLogo'];
                                      //   AirlinelogoArray.add(Airline_logo);
                                      // }

    if (widget.Received_departure_Airports.length == 1 &&
    widget.Received_destination_Airports.length == 1) {
      var Carrercodestr = OnwardJourney_carrierCodeArray1[index].toString();
      List newLst_airport = AirportListArray.first.where( (o) => o['airlineCode'] == Carrercodestr).toList();
      for(var airlinenamearray in newLst_airport){
        var Airline_name = airlinenamearray['airlineName'];
        convertedAirlineArray.add(Airline_name);
        var Airline_logo = airlinenamearray['airlineLogo'];
        AirlinelogoArray.add(Airline_logo);
      }

    }  else if (widget.Received_departure_Airports.length == 2 &&
    widget.Received_destination_Airports.length == 2) {
      //if (segmentValuesAray.length == 1) {
    var firstflight_Carrercodestr = OnwardJourney_carrierCodeArray[index]
        .toString();
    List newLst_airport = AirportListArray.first.where((
    o) => o['airlineCode'] == firstflight_Carrercodestr).toList();
    //  print(newLst_airport);
    for (var airlinenamearray in newLst_airport) {
    var firstflight_Airline_name = airlinenamearray['airlineName'];
    secondJouney_firstflight_airlineArray.add(firstflight_Airline_name);

    var firstflight_Airline_logo = airlinenamearray['airlineLogo'];
    secondJouney_firstflight_airlinelogo.add(firstflight_Airline_logo);


    }
    //}

        //second flight airline name and airline logo
        //if (widget.Received_departure_Airports[1] == depiataCode) {
          var secondflight_Carrercodestr = SecondJourney_carrierCodeArray[index]
              .toString();
          List newLst_airport1 = AirportListArray.first.where((
              o) => o['airlineCode'] == secondflight_Carrercodestr).toList();
          //  print(newLst_airport);
          for (var airlinenamearray in newLst_airport1) {
            var secondflight_Airline_name = airlinenamearray['airlineName'];
            secondJouney_secondflight_airlineArray.add(
                secondflight_Airline_name);
            // print('secondJouney_secondflight_airlineArray...');
            // print(secondJouney_secondflight_airlineArray);
            var secondflight_Airline_logo = airlinenamearray['airlineLogo'];
            secondJouney_secondflight_airlinelogo.add(
                secondflight_Airline_logo);
            // print('secondJouney_secondflight_airlinelogo...2');
            // print(secondJouney_secondflight_airlinelogo);
          }
        //}
      }
    // 3 flights
    else if (widget.Received_departure_Airports.length == 3 && //if we are using 3 flights
        widget.Received_destination_Airports.length == 3) {
      print('3 rd journey');
      var firstflight_Carrercodestr = Multi_third_Journey_firstcarrierCodeArray[index]
          .toString();
      List newLst_airport = AirportListArray.first.where((
          o) => o['airlineCode'] == firstflight_Carrercodestr).toList();
      //  print(newLst_airport);
      for (var airlinenamearray in newLst_airport) {
        var firstflight_Airline_name = airlinenamearray['airlineName'];
        thirdJouney_firstflight_airlineArray.add(firstflight_Airline_name);
        print(thirdJouney_firstflight_airlineArray);
        var firstflight_Airline_logo = airlinenamearray['airlineLogo'];
        thirdJouney_firstflight_airlinelogo.add(firstflight_Airline_logo);
      }
      //}

      //second flight airline name and airline logo
      //if (widget.Received_departure_Airports[1] == depiataCode) {
      print('3rd journey second flight...');
      var secondflight_Carrercodestr = Multi_third_Journey_secondcarrierCodeArray[index]
          .toString();
      List newLst_airport1 = AirportListArray.first.where((
          o) => o['airlineCode'] == secondflight_Carrercodestr).toList();
      //  print(newLst_airport);
      for (var airlinenamearray in newLst_airport1) {
        var secondflight_Airline_name = airlinenamearray['airlineName'];
        thirdJouney_secondflight_airlineArray.add(
            secondflight_Airline_name);
        var secondflight_Airline_logo = airlinenamearray['airlineLogo'];
        thirdJouney_secondflight_airlinelogo.add(
            secondflight_Airline_logo);
      }

    //second flight airline name and airline logo
    //if (widget.Received_departure_Airports[1] == depiataCode) {
    print('3rd journey third flight...');
    var thirdflight_Carrercodestr = Multi_third_Journey_thirdcarrierCodeArray[index]
        .toString();
    List newLst_airport2 = AirportListArray.first.where((
    o) => o['airlineCode'] == thirdflight_Carrercodestr).toList();
    //  print(newLst_airport);
    for (var airlinenamearray in newLst_airport2) {
    var thirdflight_Airline_name = airlinenamearray['airlineName'];
    thirdJouney_thirdflight_airlineArray.add(
        thirdflight_Airline_name);
    var thirdflight_Airline_logo = airlinenamearray['airlineLogo'];
    thirdJouney_thirdflight_airlinelogo.add(
        thirdflight_Airline_logo);
    }
    }


    //price
    if(CurrencyCodestr == "USD"){
      totalpricevalues = grand_totalPricevaluesArray[index].toString();
      //print("I have \$$dollars."); // I have $42.
      // totalpriceSignvalues = "\$$totalpricevalues";
      totalpriceSignvalues = "\USD $totalpricevalues";
    } else {
      totalpricevalues = grand_totalPricevaluesArray[index].toString();
      totalpriceSignvalues = "\ZAR $totalpricevalues";
    }

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
                                                                Text(OnwardJourney_DeptimeArray[index].toString() + '---------------------------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
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
                                                                Text(OnwardJourney_DeptimeArray[index].toString() + '---------------------------------> ' + OnwardJourney_ArrivaltimeArray[index],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                                                ),),
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
                                                                            image: DecorationImage(image: NetworkImage(secondJouney_firstflight_airlinelogo[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(secondJouney_firstflight_airlineArray[index].toString() + "   -" + OnwardJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
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
                                                                Text(ReturnJourney_DeptimeArray[index].toString() + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray.last.toString() ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
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
                                                                            image: DecorationImage(image: NetworkImage(secondJouney_secondflight_airlinelogo[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),


                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(secondJouney_secondflight_airlineArray[index].toString() + "   -" + SecondJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        ),),
                                                                        // child:  Text( SecondJourney_carrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                                                        // ),),
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

                                                                Text(OnwardJourney_DeptimeArray.first + '---------------------------------> ' + OnwardJourney_ArrivaltimeArray.last,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
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
                                                                            image: DecorationImage(image: NetworkImage(thirdJouney_firstflight_airlinelogo[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(thirdJouney_firstflight_airlineArray[index].toString() + "   -" + Multi_third_Journey_firstcarrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
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
                                                                Text(ReturnJourney_DeptimeArray.first + '----------------------------------> ' + ReturnJourney_ArrivaltimeArray.last,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
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
                                                                            image: DecorationImage(image: NetworkImage(thirdJouney_secondflight_airlinelogo[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(thirdJouney_secondflight_airlineArray[index].toString() + "   -" + Multi_third_Journey_secondcarrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
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
                                                                Text(Multi_third_Journey_DeptimeArray.first + '----------------------------------> ' + Multi_third_ArrivaltimeArray.last,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
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
                                                                            image: DecorationImage(image: NetworkImage(thirdJouney_thirdflight_airlinelogo[index].toString()),
                                                                                fit: BoxFit.cover)
                                                                        ),
                                                                      ),
                                                                      SizedBox(width: 40,),
                                                                      Container(
                                                                        height: 20,
                                                                        width: 150,
                                                                        color: Colors.transparent,
                                                                        child:  Text(thirdJouney_thirdflight_airlineArray[index].toString() + "   -" + Multi_third_Journey_thirdcarrierCodeArray[index].toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
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

     if (widget.Received_departure_Airports.length == 1 &&
    widget.Received_destination_Airports.length == 1) {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       print(widget.Received_departure_Airports.length);
       int k = 0;
       k = widget.Received_departure_Airports.length;
       for (int i = 0; i < k; i++) {
         print('Departure Item at index $i: ${widget.Received_departure_Airports[i]}');
         // Increase index (optional, as 'i' automatically increases in a for loop)
         departureAirports.add(widget.Received_departure_Airports[i]);
         destinationAirports.add(widget.Received_destination_Airports[i]);

       }
       print('departure airport1111...');
       print(departureAirports);

       print('destination airport1111...');
       print(destinationAirports);



       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => Multi_city_Flight_Details(
             Received_departure_Airports: departureAirports,
             Received_destination_Airports: destinationAirports,
           ), // Pass airport here
         ),
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
       // prefs.setString('return_airlinekey', Return_convertedAirlineArray[index]);
       // prefs.setString('return_logokey', Return_AirlinelogoArray[index]);
       // prefs.setString('return_journey_departure_time_key', OnwardJourney_DeptimeArray[index]);
       // prefs.setString('return_journey_arrival_time_key', OnwardJourney_DeptimeArray[index]);
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
     } else if (widget.Received_departure_Airports.length == 2 &&
    widget.Received_destination_Airports.length == 2) {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       print(widget.Received_departure_Airports.length);
       int k = 0;
       k = widget.Received_departure_Airports.length;
       for (int i = 0; i < k; i++) {
         print('Departure Item at index $i: ${widget.Received_departure_Airports[i]}');
         // Increase index (optional, as 'i' automatically increases in a for loop)
         departureAirports.add(widget.Received_departure_Airports[i]);
         destinationAirports.add(widget.Received_destination_Airports[i]);

       }
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => Multi_city_Flight_Details(
             Received_departure_Airports: departureAirports,
             Received_destination_Airports: destinationAirports,
           ), // Pass airport here
         ),
       );




       prefs.setString('flightid_key', flightoffer_ID_Array[index]);;
       prefs.setString('source_key', sourceArray[index]);
       prefs.setString('lastTicketing_Datekey', lastTicketingDateArray[index]);
       prefs.setString('lastTicketingDate_Timekey', lastTicketingDateTimeArray[index]);
       prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsArray[index].toString());
       //Career codes
       prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
       prefs.setString('flight_optionkey', 'round-trip');
       prefs.setString('secondJourney_carrierCodekey', SecondJourney_carrierCodeArray[index]);


       prefs.setString('durationkey', durationArray[index]);
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
       prefs.setString('airlinekey', secondJouney_firstflight_airlineArray[index]);
       prefs.setString('logokey', secondJouney_firstflight_airlinelogo[index]);
       prefs.setString('secondJourney_airlinekey', secondJouney_secondflight_airlineArray[index]);
       prefs.setString('secondeJourney_logokey', secondJouney_secondflight_airlinelogo[index]);
       //Return airline name and logo...
       // prefs.setString('return_airlinekey', Return_convertedAirlineArray[index]);
       // prefs.setString('return_logokey', Return_AirlinelogoArray[index]);
       // prefs.setString('return_journey_departure_time_key', OnwardJourney_DeptimeArray[index]);
       // prefs.setString('return_journey_arrival_time_key', OnwardJourney_DeptimeArray[index]);
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


     } else if (widget.Received_departure_Airports.length == 3 &&
    widget.Received_destination_Airports.length == 3) {

       SharedPreferences prefs = await SharedPreferences.getInstance();
       print(widget.Received_departure_Airports.length);
       int k = 0;
       k = widget.Received_departure_Airports.length;
       for (int i = 0; i < k; i++) {
         print('Departure Item at index $i: ${widget.Received_departure_Airports[i]}');
         // Increase index (optional, as 'i' automatically increases in a for loop)
         departureAirports.add(widget.Received_departure_Airports[i]);
         destinationAirports.add(widget.Received_destination_Airports[i]);

       }
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => Multi_city_Flight_Details(
             Received_departure_Airports: departureAirports,
             Received_destination_Airports: destinationAirports,
           ), // Pass airport here
         ),
       );




       prefs.setString('flightid_key', flightoffer_ID_Array[index]);;
       prefs.setString('source_key', sourceArray[index]);
       prefs.setString('lastTicketing_Datekey', lastTicketingDateArray[index]);
       prefs.setString('lastTicketingDate_Timekey', lastTicketingDateTimeArray[index]);
       prefs.setString('numberOfBookableSeatskey', numberOfBookableSeatsArray[index].toString());
       //prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
       prefs.setString('flight_optionkey', 'round-trip');
       prefs.setString('thirdJourney_firstflight_carrierCodekey', Multi_third_Journey_firstcarrierCodeArray[index]);
       prefs.setString('thirdJourney_secondflight_carrierCodekey', Multi_third_Journey_secondcarrierCodeArray[index]);
       prefs.setString('thirdJourney_thirdflight_carrierCodekey', Multi_third_Journey_thirdcarrierCodeArray[index]);


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
       // prefs.setString('airlinekey', secondJouney_firstflight_airlineArray[index]);
       // prefs.setString('logokey', secondJouney_firstflight_airlinelogo[index]);
       prefs.setString('thirdJourney_firstflight__airlinekey', thirdJouney_firstflight_airlineArray[index]);
       prefs.setString('thirdJourney_firstflightflight_logokey', thirdJouney_firstflight_airlinelogo[index]);
       prefs.setString('thirdJourney_secondflight__airlinekey', thirdJouney_secondflight_airlineArray[index]);
       prefs.setString('thirdJourney_secondflight_logokey', thirdJouney_secondflight_airlinelogo[index]);
       prefs.setString('thirdJourney_thirdflight_airlinekey', thirdJouney_thirdflight_airlineArray[index]);
       prefs.setString('thirdJourney_thirdflight_logokey', thirdJouney_thirdflight_airlinelogo[index]);


       //Return airline name and logo...
       // prefs.setString('return_airlinekey', Return_convertedAirlineArray[index]);
       // prefs.setString('return_logokey', Return_AirlinelogoArray[index]);
       // prefs.setString('return_journey_departure_time_key', OnwardJourney_DeptimeArray[index]);
       // prefs.setString('return_journey_arrival_time_key', OnwardJourney_DeptimeArray[index]);
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


     }


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





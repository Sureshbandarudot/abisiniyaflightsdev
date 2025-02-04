
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

import '../../Multi_City_flightSearch/Multi_city_additional services/multi_city_additionalSevicesVC.dart';

class Multi_city_Flight_Details extends StatefulWidget {
  //const Flight_Multicity_Trip({super.key});
  final List<String> Received_departure_Airports;
  final List<String> Received_destination_Airports;

  // const Multi_city_Flight_Details({super.key});
  Multi_city_Flight_Details({required this.Received_departure_Airports, required this.Received_destination_Airports});


  @override
  State<Multi_city_Flight_Details> createState() => _userDashboardState();
}

class _userDashboardState extends State<Multi_city_Flight_Details> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String flightTokenstr = '';
  List travelersArray = [];
  List travelersfareDetailsBySegmentArray = [];

  List Convert_segmentArray = [];
  List Convert_ItineraryArray = [];

  List Convert_AirlineArray = [];
  var travelerPricingslistArray = [];
  var totalPricevaluesArray = [];
  var cabintrvalue_Array = [];
  List validatingAirlineCodestrArray = [];

  Map<String, dynamic> priceArray = {};
  Map<String, dynamic> includedCheckedBags = {};
  Map<String, dynamic> includedCabinBags = {};
  List convert_travelerPricingsArray = [];
  Map<String, dynamic> convert_Currency_PriceArray = {};
  Map<String, dynamic> fareRulesArray = {};
  late final RetrivedSegment_Array ;
  late final validatingAirlineCodestr ;
  late final ItineraryArray;
//Retrived values
  String flight_ID = '';
  String sourcestr = '';
  String lastTicketing_Datestr = '';
  String lastTicketingDate_Timestr = '';
  String numberOfBookableSeatsstr = '';
  String durationstr = '';
  String Careercodestr = '';
  String return_Careercodestr = '';
  //departure time variables
  String departure_time = '';
  String arrival_time = '';
  //return time variables
  String return_departure_time = '';
  String return_arrival_time = '';




  // String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  // String RetrivedOnew_Oneway_DestinationCitynamestr = '';
  //Round-trip
  String Retrived_round_trip_dep_originiatacodestr = '';

  String Retrived_round_trip_dep_Destinationiatacodestr = '';
  String Retrived_Rndtrp_Destination_Citynamestr = '';
  String Retrived_Rndtrp_Citynamestr = '';
  //String Retrived_Oneway_iatacodestr = '';
  String Depterminal = '';
  var firstflightDepterminalArry = [];
  String Arrivalterminal = '';
  var firstflightArravalterminalArry = [];
  //Array duration...
  var firstflightDurationArray = [];
  var secondJourneyfirstflightDurationArray = [];
  var secondJourneysecondflightDurationArray = [];
  var thirdJourneyfirstflightDurationArray = [];
  var thirdJourneysecondflightDurationArray = [];
  var thirdJourneythirdflightDurationArray = [];
  //Stops:
  var firstJouney_strops = [];
  var secondJourney_firstflightstops = [];
  var secondJourney_secondflightstops = [];
  var thirdJourney_firstflightstops = [];
  var thirdJourney_secondflightstops = [];
  var thirdJourney_thirdflightstops = [];




  //return
  String return_Depterminal = '';
  String return_Arrivalterminal = '';
  String totalpricevalues = '';
  String cabintrvalue = '';
  String segmentId = '';
  //Baggage
  int weight = 0;
  int quantity = 0;
  int Passengers_cnt = 0;
  //Cabin Baggage
  int Cabin_weight = 0;
  int Cabin_quantity = 0;

  String Baggagestr = '';
  String Cabin_Baggagestr = '';
  String Without_seatmap_str = '';




  var flight_offer_Array = [];
  var OnwardJourney_Segmentrray = [];
  var Currency_Price_Array = [];
  String grandTotalprice = '';
  // var grand_totalPricevaluesArray = [];
  String weightUnitstr = '';
  String selectedseat = '';
  String depiataCode = '';
  String Datestr = '';
  String arrivalCode = '';
  String Deptimeconvert = '';
  String Arrivaltimeconvert = '';
  //Departure and arrival time arrays
  var firstJourney_Departure_timeArray = [];
  var secondJourney_firstflight_Departure_timeArray = [];
  var secondJourney_secondflight_Departure_timeArray = [];
  var thirdJourney_firstflight_Departure_timeArray = [];
  var thirdJourney_secondflight_Departure_timeArray = [];
  var thirdJourney_thirdflight_Departure_timeArray = [];

  //Arrival time arrays
  var firstJourney_Arrival_timeArray = [];
  var secondJourney_firstflight_Arrival_timeArray = [];
  var secondJourney_secondflight_Arrival_timeArray = [];
  var thirdJourney_firstflight_Arrival_timeArray = [];
  var thirdJourney_secondflight_Arrival_timeArray = [];
  var thirdJourney_thirdflight_Arrival_timeArray = [];



  String trimedDuration = '';
  String CurrencyCodestr = '';
  String totalpriceSignvalues = '';
  String airlinestr = '';
  String logostr = '';
  //Arrays...
  var arrivaltime = [];
  var departuretime = [];
  var secondJourneydeparturearray = [];
  var secondJourneyarrivalarray = [];
  var thirdJourneydeparturearray = [];
  //if 3 flights are operating
  var thirdJourney_second_flight_departurearray = [];
  var thirdJourney_third_flight_departurearray = [];
  var thirdJourneyarrivalarray = [];
  var thirdJourney_second_flight_arrivalarray = [];
  var thirdJourney_third_flight_arrivalarray = [];


  String secondJourney_firstdepartureterminal = '';
  String secondJourney_seconddepartureterminal = '';
  var secondJourney_firstdepartureterminalArray = [];
  var secondJourney_seconddepartureterminalArray = [];
  String secondJourney_firstArrvailterminal = '';
  String secondJourney_secondArrivalterminal = '';
  var secondJourney_firstArrivalterminalArray = [];
  var secondJourney_secondArrivalterminalArray = [];

  //Third journey flight details variables declarations
  String thirdJourney_firstdepartureterminal = '';
  String thirdJourney_seconddepartureterminal = '';
  String thirdJourney_thirddepartureterminal = '';

  var thirdJourney_firstdepartureterminalArray = [];
  var thirdJourney_seconddepartureterminalArray = [];
  var thirdJourney_thirddepartureterminalArray = [];

  String thirdJourney_firstArrvailterminal = '';
  String thirdJourney_secondArrivalterminal = '';
  String thirdJourney_thirdArrivalterminal = '';

  var thirdJourney_firstArrivalterminalArray = [];
  var thirdJourney_secondArrivalterminalArray = [];
  var thirdJourney_thirdArrivalterminalArray = [];



  //return airline and logo variable declaration..
  String multi_secondJourney_airlinestr = '';
  String multi_secondJourney_logostr = '';
  //Retriving second journey career codes
  String multi_secondJourney_firstCareercode = '';
  String multi_secondJourney_secondCareercode = '';

  //Multi city 3 flight variables
  String multi_thirdJourney_firstCareercode = '';
  String multi_thirdJourney_secondCareercode = '';
  String multi_thirdJourney_thirdCareercode = '';
  String multi_thirdJourney_firstflight_airlinestr = '';
  String multi_thirdJourney_firstflight_logostr = '';
  String multi_thirdJourney_secondflight_airlinestr = '';
  String multi_thirdJourney_secondflight_logostr = '';
  String multi_thirdJourney_thirdflight_airlinestr = '';
  String multi_thirdJourney_thirdflight_logostr = '';










  var Departuretextstr = '';
  var flight_departurests = '';
  //
  var secondJourney_secondflight_Departuretextstr = '';
  var secondJourney_secondflight_departurests = '';

  var thirdJourney_thirdflight_Departuretextstr = '';
  var thirdJourney_thirdflight_departurests = '';

  var travelerIdArray = [];
  String travelerTypestr = '';
  var travelerTypeArray = [];



  late final  segmentDataArray;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CurrencyCodestr = prefs.getString('Rndcurrency_code_dropdownvaluekey') ?? '';
    print('rnd trip currency code1....');
    print(CurrencyCodestr);
    selectedseat = prefs.getString('selectedseatkey') ?? '';
    print('price screen seat');
    print(selectedseat);



    flight_ID = prefs.getString('flightid_key') ?? '';
    //prefs.setInt('Passengers_cntkey', Passengers_cnt) ?? 0;
    Passengers_cnt = prefs.getInt('Passengers_cntkey') ?? 0;
    print('1 price passengers cnt');
    print(Passengers_cnt);
    Without_seatmap_str = prefs.getString('without_seatmapbookingkey') ?? '';
    print('Without_seatmap_str....');
    print(Without_seatmap_str);


    // print('flight_ID...');
    // print(flight_ID);
    sourcestr = prefs.getString('source_key') ?? '';
    lastTicketing_Datestr = prefs.getString('lastTicketing_Datekey') ?? '';
    lastTicketingDate_Timestr = prefs.getString('lastTicketingDate_Timekey') ?? '';
    numberOfBookableSeatsstr = prefs.getString('numberOfBookableSeatskey') ?? '';
    Careercodestr = prefs.getString('carrierCodekey') ?? '';
    airlinestr = prefs.getString('airlinekey') ?? '';
    logostr = prefs.getString('logokey') ?? '';
    //second flight airline and logo retrived...
    multi_secondJourney_airlinestr = prefs.getString('secondJourney_airlinekey') ?? '';
    multi_secondJourney_logostr = prefs.getString('secondeJourney_logokey') ?? '';
    multi_secondJourney_firstCareercode = prefs.getString('carrierCodekey') ?? '';
    multi_secondJourney_secondCareercode = prefs.getString('secondJourney_carrierCodekey') ?? '';


//Multi city 3 flights data retriving...
    multi_thirdJourney_firstflight_airlinestr = prefs.getString('thirdjourney_firstflightAirlinekey') ?? '';
    multi_thirdJourney_firstflight_logostr = prefs.getString('thirdjourney_firstflightArilinelogokey') ?? '';

    print('multi_thirdJourney_firstflight_airlinestr.......');
    print(multi_thirdJourney_firstflight_airlinestr);
    print('multi_thirdJourney_firstflight_logostr........');
    print(multi_thirdJourney_firstflight_logostr);
     multi_thirdJourney_firstCareercode = prefs.getString('thirdJourney_firstflight_carrierCodekey') ?? '';

    multi_thirdJourney_secondflight_airlinestr = prefs.getString('thirdJourney_secondflightairlinekey') ?? '';
    multi_thirdJourney_secondflight_logostr = prefs.getString('thirdJourney_secondflightlogokey') ?? '';

    multi_thirdJourney_thirdflight_airlinestr = prefs.getString('thirdJourney_thirdflightairlinekey') ?? '';
    print('multi_thirdJourney_thirdflight_airlinestr...');
    print(multi_thirdJourney_thirdflight_airlinestr);
    multi_thirdJourney_thirdflight_logostr = prefs.getString('thirdJourney_thirdflightlogokey') ?? '';
    print('multi_thirdJourney_thirdflight_logostr....');
    print(multi_thirdJourney_thirdflight_logostr);
    multi_thirdJourney_firstCareercode = prefs.getString('thirdJourney_firstflight_carrierCodekey') ?? '';
    multi_thirdJourney_secondCareercode = prefs.getString('thirdJourney_secondflight_carrierCodekey') ?? '';
    multi_thirdJourney_thirdCareercode = prefs.getString('thirdJourney_thirdflight_carrierCodekey') ?? '';



    Retrived_round_trip_dep_originiatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';

    Retrived_round_trip_dep_Destinationiatacodestr = prefs.getString('Rndtrp_Destinationiatacodekey') ?? '';
    Retrived_Rndtrp_Destination_Citynamestr = prefs.getString('Rndtrp_DestinationCitynamekey') ?? '';
    //Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
    //Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
    Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';

    //Round-trip timings
    //departure flight timings:-
    departure_time = prefs.getString('return_journey_departure_time_key') ?? '';
    arrival_time = prefs.getString('return_journey_arrival_time_key') ?? '';



    // setState(() {
    //   final data = json.decode(RetrivedSegment_Array);
    //   for (var i in data) {
    //     Convert_segmentArray.add(i);
    //   }

    // });
    // durationstr = prefs.getString('durationkey') ?? '';
    // print('duration....');
    // print(durationstr);

    // prefs.setString('carrierCodekey', OnwardJourney_carrierCodeArray[index]);
    // prefs.setString('durationkey', durationArray[index]);

    //Flight search segment values retriving...
    //final RetrivedSegment_Array ;
    RetrivedSegment_Array = prefs.getString('Segmentkey') ?? '';
    ItineraryArray = prefs.getString('Itinerarykey') ?? '';
    print('multi ItineraryArray....');
    print(ItineraryArray);


    setState(() {
      final data = json.decode(ItineraryArray);
      for (var i in data) {
        Convert_ItineraryArray.add(i);
        print('Convert_ItineraryArray....');
        print(Convert_ItineraryArray);
      }
    });
    validatingAirlineCodestr = prefs.getString('validatingAirlineCodeskey') ?? '';
    print('retrived  validatingAirlineCodestr...');
    print(validatingAirlineCodestr);
    validatingAirlineCodestrArray = json.decode(validatingAirlineCodestr);
    print('validatingAirlineCodestrArray...');
    print(validatingAirlineCodestrArray.first);

    //Baggage Data retrived
    //Baggage
    // weight = prefs.getInt('weightkey') ?? 0;
    // quantity = prefs.getInt('quantitykey') ?? 0;
    // print('Retrived weight...');
    // print(weight);
    // print('Retrived quantity...');
    // print(quantity);

    //Cabin Baggage
    // Cabin_weight = prefs.getInt('Cabin_weightkey') ?? 0;
    // print('Retrived Cabin_weight.... ');
    // print(Cabin_weight);
    // Cabin_quantity = prefs.getInt('Cabin_quantitykey') ?? 0;
    // print('Retrived Cabin_quantity.... ');
    // print(Cabin_quantity);



    //print(RetrivedSegment_Array);
    // setState(() {
    //   final data = json.decode(RetrivedSegment_Array);
    //   for (var i in data) {
    //     Convert_segmentArray.add(i);
    //     // print('Convert_segmentArray....');
    //     // print(Convert_segmentArray);
    //   }
    // });

    //travelerPricings values retrived

    final travelerPricings ;
    travelerPricings = prefs.getString('Round_trip_travelerPricingskey') ?? '';
    print('multi travelerPricings....');
    print(travelerPricings);





    // final Map<String, dynamic> tournament = {
    //       "travelerId": "1",
    //       "fareOption": "STANDARD",
    //       "travelerType": "ADULT",
    //       "price": {
    //         "currency": "USD",
    //         "total": "79.80",
    //         "base": "64.00"
    //       },
    //       "fareDetailsBySegment": [
    //         {
    //           "segmentId": "35",
    //           "cabin": "ECONOMY",
    //           "fareBasis": "UU1YXFII",
    //           "class": "U",
    //           "includedCheckedBags": {
    //             "weight": 15,
    //             "weightUnit": "KG"
    //           },
    //           "includedCabinBags": {
    //             "weight": 7,
    //             "weightUnit": "KG"
    //           },
    //           // "additionalServices": {
    //           //   "chargeableSeatNumber": "11D"
    //           // }
    //         }
    //       ]
    //     };




    // Map<String, dynamic> _portaInfoMap = {
    //   "noOfArticles": [
    //     travelerPricings,
    //     {"type": "web", "count": 75}
    //   ]
    // };
    setState(() {
      final data = json.decode(travelerPricings);
      for (var i in data) {
        convert_travelerPricingsArray.add(i);
      }
    });



    // Without_seatmap_str = prefs.getString('without_seatmapbookingkey') ?? '';
    // print('Without_seatmap_str1....');
    // print(Without_seatmap_str);
    //
    //   if (Without_seatmap_str.contains('Without seatmap')) {
    //     print('This string contains other string.');
    //     print('without seat number...');
    //     print(convert_travelerPricingsArray);
    //
    //   } else {
    //     print('This string does not contain other string.');
    //     print('with seat number...');
    //     print(selectedseat);
    //     convert_travelerPricingsArray[0]['fareDetailsBySegment']![0]["additionalServices"] = {
    //       "chargeableSeatNumber": selectedseat
    //     };
    //   }
    print('price convert_travelerPricingsArray...');
    print(convert_travelerPricingsArray);


    travelersfareDetailsBySegmentArray = <Map<String, dynamic>>[

      // {
      //   "travelerId": "1",
      //   "fareOption": "STANDARD",
      //   "travelerType": "ADULT",
      //
      //    "price": priceArray,
      //convert_travelerPricingsArray....
      //   // "price": {
      //   //   "currency": "USD",
      //   //   "total": "79.80",
      //   //   "base": "64.00"
      //   // },
      //   "fareDetailsBySegment": [
      //     {
      //       "segmentId": "39",
      //       "cabin": "ECONOMY",
      //       "fareBasis": "UU1YXFII",
      //       "class": "U",
      //       "includedCheckedBags": {
      //         "weight": 15,
      //         "weightUnit": "KG"
      //       },
      //       "includedCabinBags": {
      //         "weight": 7,
      //         "weightUnit": "KG"
      //       },
      //       "additionalServices": {
      //         "chargeableSeatNumber": selectedseat
      //       }
      //     }
      //   ]
      // }

      {
        "travelerId": "1",
        "fareOption": "STANDARD",
        "travelerType": travelerTypestr,
        "price": priceArray,

        // "price": {
        //   "currency": "USD",
        //   "total": "79.90",
        //   "base": "64.00"
        // },
        "fareDetailsBySegment": [
          {
            "segmentId": segmentId,
            "cabin": cabintrvalue,
            "fareBasis": "UU1YXFII",
            "class": "U",
            "includedCheckedBags": includedCheckedBags,
            // "includedCheckedBags": {
            //   "weight": 15,
            //   "weightUnit": "KG"
            // },
            "includedCabinBags": includedCabinBags,
            "additionalServices": {
              "chargeableSeatNumber": selectedseat
            }
            // "includedCabinBags": {
            //   "weight": 7,
            //   "weightUnit": "KG"
            // }
          }
        ]
      }
    ];
    // print('travelersfareDetailsBySegmentArray....');
    // print(travelersfareDetailsBySegmentArray);



    //prefs.setString('travelerPricingskey', travelerPricings);


    //currency and price values array retriving..
    final Retrived_Currency_PriceArray ;
    Retrived_Currency_PriceArray = prefs.getString('Round_trip_Currency_Pricekey') ?? '';
    print('p_Retrived_Currency_PriceArray...');
    print(Retrived_Currency_PriceArray);

    convert_Currency_PriceArray = jsonDecode(Retrived_Currency_PriceArray);
    print('convert_Currency_PriceArray....');
    print(convert_Currency_PriceArray);



    //FareRules
    final Retrive_fareRules ;
    Retrive_fareRules = prefs.getString('Round_trip_fareRuleskey') ?? '';
    print('price fareRuleskey...');
    print(Retrive_fareRules);
    if(Retrive_fareRules != ""){
      print('empty fare values....');
      // fareRulesArray = jsonDecode(Retrive_fareRules);
      // print('Retrive_fareRules....');
      // print(fareRulesArray);
    } else{
      fareRulesArray = jsonDecode(Retrive_fareRules);
      print('price Retrive_fareRules....');
      print(fareRulesArray);
    }

  }


//@override
  initState() {
    // TODO: implement initState
    super.initState();

    _retrieveValues();
    _postData();

    // Map<String, dynamic> _portaInfoMap = {
    //   "name": "Vitalflux.com",
    //   "domains": ["Data Science", "Mobile", "Web"],
    //   "noOfArticles": [
    //     {"type": "data science", "count": 50},
    //     {"type": "web", "count": 75}
    //   ]
    // };
    Map<String, dynamic> _portaInfoMap = {
      "name": "Vitalflux.com",
      "noOfArticles": [
        {"type": "data science", "count": 50},
        {"type": "web", "count": 75}
      ]
    };
    print('mapping...');
    print(_portaInfoMap);



    // for (var i=1; i<3; i++) {
    //   print('i values...');
    //   print(i);
    //
    //   var lst = <String>[]; // creates an empty list with the int data type
    //
    //   travelersArray = <Map<String, dynamic>>[
    //     {
    //       "id": i,
    //       "travelerType": "ADULT",
    //       "fareOptions": [
    //         "STANDARD"
    //       ],
    //     },
    //   ];

    //travelersArray.add(travellers);
    // List<String> strlist = travellers.cast<String>();

    // print('loop..');
    // print(travelersArray);
  }

  //return travellers;


  //_postData() async {
  //Future<dynamic> _postData(dynamic body) async {
  Future<void> _postData() async {
    setState(() {
      isLoading = true;
    });
    //tempList = List<String>();
    //List<String> tempList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
    selectedseat = prefs.getString('selectedseatkey') ?? '';
    print('price screen seat');
    print(selectedseat);
    print('multi city price Received values....');
    print(widget.Received_departure_Airports.first);
    print(widget.Received_destination_Airports.first);
    print(widget.Received_departure_Airports.length);
    print(widget.Received_destination_Airports.length);
    // print(widget.Received_destination_Airports.first);
    // print(widget.Received_destination_Airports[1]);
    // print(widget.Received_Dates.first);
    // print(widget.Received_Dates[1]);
    // print(' Details Onward journey token1...');
    // print(flightTokenstr);
    //{{API_URL}}/v1/shopping/flight-offers/pricing
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
            // {
            //   "type": "flight-offer",
            //   "id": flight_ID,
            //   "source": sourcestr,
            //   "instantTicketingRequired": false,
            //   "nonHomogeneous": false,
            //   "oneWay": false,
            //   "isUpsellOffer": false,
            //   "lastTicketingDate": lastTicketing_Datestr,
            //   "lastTicketingDateTime": lastTicketingDate_Timestr,
            //   "numberOfBookableSeats": numberOfBookableSeatsstr,
            //   // "type": "flight-offer",
            //   // "id": "1",
            //   // "source": "GDS",
            //   // "instantTicketingRequired": false,
            //   // "nonHomogeneous": false,
            //   // "oneWay": false,
            //   // "isUpsellOffer": false,
            //   // "lastTicketingDate": "2024-10-29",
            //   // "lastTicketingDateTime": "2024-10-29",
            //   // "numberOfBookableSeats": 6,
            //
            //   "itineraries": Convert_ItineraryArray,
            //
            //   // "itineraries": [
            //   //   {
            //   //     "duration": durationstr,
            //   //
            //   //     "segments": Convert_segmentArray
            //   //
            //   //     // "segments": [
            //   //     //   {
            //   //     //     "departure": {
            //   //     //       "iataCode": "CDG",
            //   //     //       "terminal": "3",
            //   //     //       "at": "2024-11-02T07:00:00"
            //   //     //     },
            //   //     //     "arrival": {
            //   //     //       "iataCode": "MAD",
            //   //     //       "terminal": "4",
            //   //     //       "at": "2024-11-02T09:10:00"
            //   //     //     },
            //   //     //     "carrierCode": "IB",
            //   //     //     "number": "592",
            //   //     //     "aircraft": {
            //   //     //       "code": "321"
            //   //     //     },
            //   //     //     "operating": {
            //   //     //       "carrierCode": "IB"
            //   //     //     },
            //   //     //     "duration": "PT2H10M",
            //   //     //     "id": "5",
            //   //     //     "numberOfStops": 0,
            //   //     //     "blacklistedInEU": false
            //   //     //   }
            //   //     // ]
            //   //   }
            //   // ],
            //   "price": convert_Currency_PriceArray,
            //
            //
            //   // "price": {
            //   //   "currency": "ZAR",
            //   //   "total": "1536.00",
            //   //   "base": "890.00",
            //   //   "fees": [
            //   //     {
            //   //       "amount": "0.00",
            //   //       "type": "SUPPLIER"
            //   //     },
            //   //     {
            //   //       "amount": "0.00",
            //   //       "type": "TICKETING"
            //   //     }
            //   //   ],
            //   //   "grandTotal": "1536.00",
            //   //   "additionalServices": [
            //   //     {
            //   //       "amount": "1075.00",
            //   //       "type": "CHECKED_BAGS"
            //   //     }
            //   //   ]
            //   // },
            //   "pricingOptions": {
            //     "fareType": [
            //       "PUBLISHED"
            //     ],
            //     "includedCheckedBagsOnly": true
            //   },
            //   "validatingAirlineCodes": [
            //     //"IB"
            //     validatingAirlineCodestrArray.first
            //   ],
            //
            //   "travelerPricings": convert_travelerPricingsArray,
            //
            //   // "travelerPricings": [
            //   //   {
            //   //     "travelerId": "1",
            //   //     "fareOption": "STANDARD",
            //   //     "travelerType": "ADULT",
            //   //     "price": {
            //   //       "currency": "ZAR",
            //   //       "total": "1536.00",
            //   //       "base": "890.00"
            //   //     },
            //   //     "fareDetailsBySegment": [
            //   //       {
            //   //         "segmentId": "5",
            //   //         "cabin": "ECONOMY",
            //   //         "fareBasis": "ADNNAOB4",
            //   //         "class": "A",
            //   //         "includedCheckedBags": {
            //   //           "quantity": 0
            //   //         }
            //   //       }
            //   //     ]
            //   //   }
            //   // ]
            // }


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
              // "lastTicketingDate": "2024-11-27",
              // "lastTicketingDateTime": "2024-11-27",
              // "numberOfBookableSeats": 7,
              "itineraries": Convert_ItineraryArray,


              // "itineraries": [
              //   {
              //     "duration": "PT16H25M",
              //     "segments": [
              //       {
              //         "departure": {
              //           "iataCode": "JNB",
              //           "at": "2024-11-28T04:00:00"
              //         },
              //         "arrival": {
              //           "iataCode": "LFW",
              //           "at": "2024-11-28T10:20:00"
              //         },
              //         "carrierCode": "KP",
              //         "number": "75",
              //         "aircraft": {
              //           "code": "737"
              //         },
              //         "operating": {
              //           "carrierCode": "KP"
              //         },
              //         "duration": "PT8H20M",
              //         "stops": [
              //           {
              //             "iataCode": "LBV",
              //             "duration": "PT45M",
              //             "arrivalAt": "2024-11-28T08:35:00",
              //             "departureAt": "2024-11-28T09:20:00"
              //           }
              //         ],
              //         "id": "7",
              //         "numberOfStops": 1,
              //         "blacklistedInEU": false
              //       },
              //       {
              //         "departure": {
              //           "iataCode": "LFW",
              //           "at": "2024-11-28T12:40:00"
              //         },
              //         "arrival": {
              //           "iataCode": "NBO",
              //           "terminal": "1E",
              //           "at": "2024-11-28T21:25:00"
              //         },
              //         "carrierCode": "KP",
              //         "number": "78",
              //         "aircraft": {
              //           "code": "737"
              //         },
              //         "operating": {
              //           "carrierCode": "KP"
              //         },
              //         "duration": "PT5H45M",
              //         "id": "8",
              //         "numberOfStops": 0,
              //         "blacklistedInEU": false
              //       }
              //     ]
              //   },
              //   {
              //     "duration": "PT6H20M",
              //     "segments": [
              //       {
              //         "departure": {
              //           "iataCode": "NBO",
              //           "at": "2024-11-30T06:15:00"
              //         },
              //         "arrival": {
              //           "iataCode": "LLW",
              //           "at": "2024-11-30T07:30:00"
              //         },
              //         "carrierCode": "ET",
              //         "number": "51",
              //         "aircraft": {
              //           "code": "738"
              //         },
              //         "duration": "PT2H15M",
              //         "id": "15",
              //         "numberOfStops": 0,
              //         "blacklistedInEU": false
              //       },
              //       {
              //         "departure": {
              //           "iataCode": "LLW",
              //           "at": "2024-11-30T08:10:00"
              //         },
              //         "arrival": {
              //           "iataCode": "JNB",
              //           "at": "2024-11-30T11:35:00"
              //         },
              //         "carrierCode": "ET",
              //         "number": "20",
              //         "aircraft": {
              //           "code": "738"
              //         },
              //         "duration": "PT3H25M",
              //         "stops": [
              //           {
              //             "iataCode": "BLZ",
              //             "duration": "PT30M",
              //             "arrivalAt": "2024-11-30T08:50:00",
              //             "departureAt": "2024-11-30T09:20:00"
              //           }
              //         ],
              //         "id": "16",
              //         "numberOfStops": 1,
              //         "blacklistedInEU": false
              //       }
              //     ]
              //   }
              // ],

              "price": convert_Currency_PriceArray,

              // "price": {
              //   "currency": "USD",
              //   "total": "444.00",
              //   "base": "108.00",
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
              //   "grandTotal": "444.00"
              // },
              "pricingOptions": {
                "fareType": [
                  "PUBLISHED"
                ],
                "includedCheckedBagsOnly": true
              },
              "validatingAirlineCodes": [
                //"KP"
                validatingAirlineCodestrArray.first
              ],
              "travelerPricings": convert_travelerPricingsArray

              // "travelerPricings": [
              //   {
              //     "travelerId": "1",
              //     "fareOption": "STANDARD",
              //     "travelerType": "ADULT",
              //     "price": {
              //       "currency": "USD",
              //       "total": "444.00",
              //       "base": "108.00"
              //     },
              //     "fareDetailsBySegment": [
              //       {
              //         "segmentId": "7",
              //         "cabin": "ECONOMY",
              //         "fareBasis": "UXPX3M",
              //         "class": "U",
              //         "includedCheckedBags": {
              //           "quantity": 2
              //         }
              //       },
              //       {
              //         "segmentId": "8",
              //         "cabin": "ECONOMY",
              //         "fareBasis": "UXPX3M",
              //         "class": "U",
              //         "includedCheckedBags": {
              //           "quantity": 2
              //         }
              //       },
              //       {
              //         "segmentId": "15",
              //         "cabin": "ECONOMY",
              //         "fareBasis": "LESMWQ",
              //         "class": "L",
              //         "includedCheckedBags": {
              //           "quantity": 2
              //         }
              //       },
              //       {
              //         "segmentId": "16",
              //         "cabin": "ECONOMY",
              //         "fareBasis": "LESMWQ",
              //         "class": "L",
              //         "includedCheckedBags": {
              //           "quantity": 2
              //         }
              //       }
              //     ]
              //   }
              // ]
            },


            // {
            //   "type": "flight-offer",
            //   "id": flight_ID,
            //           "source": sourcestr,
            //           "instantTicketingRequired": false,
            //           "nonHomogeneous": false,
            //           "oneWay": false,
            //           "isUpsellOffer": false,
            //           "lastTicketingDate": lastTicketing_Datestr,
            //           "lastTicketingDateTime": lastTicketingDate_Timestr,
            //           "numberOfBookableSeats": numberOfBookableSeatsstr,
            //   // "id": "1",
            //   // "source": "GDS",
            //   // "instantTicketingRequired": false,
            //   // "nonHomogeneous": false,
            //   // "oneWay": false,
            //   // "isUpsellOffer": false,
            //   // "lastTicketingDate": "2024-09-19",
            //   // "lastTicketingDateTime": "2024-09-19",
            //   // "numberOfBookableSeats": 9,
            //   "itineraries": [
            //     {
            //       // "duration": "PT2H55M",
            //       //  "segments": se
            //       "duration": durationstr,
            //       "segments": Convert_segmentArray
            //
            //       // "segments": [
            //       //   {
            //       //     "departure": {
            //       //       "iataCode": "BLR",
            //       //       "terminal": "2",
            //       //       "at": "2024-09-25T05:45:00"
            //       //     },
            //       //     "arrival": {
            //       //       "iataCode": "DEL",
            //       //       "terminal": "3",
            //       //       "at": "2024-09-25T08:40:00"
            //       //     },
            //       //     "carrierCode": "AI",
            //       //     "number": "804",
            //       //     "aircraft": {
            //       //       "code": "32N"
            //       //     },
            //       //     "operating": {
            //       //       "carrierCode": "AI"
            //       //     },
            //       //     "duration": "PT2H55M",
            //       //     "id": "39",
            //       //     "numberOfStops": 0,
            //       //     "blacklistedInEU": false
            //       //   }
            //       // ]
            //     }
            //   ],
            //    "price": convert_Currency_PriceArray,
            //   // "price": {
            //   //   "currency": "USD",
            //   //   "total": "79.80",
            //   //   "base": "64.00",
            //   //   "fees": [
            //   //     {
            //   //       "amount": "0.00",
            //   //       "type": "SUPPLIER"
            //   //     },
            //   //     {
            //   //       "amount": "0.00",
            //   //       "type": "TICKETING"
            //   //     }
            //   //   ],
            //   //   "grandTotal": "79.80"
            //   // },
            //   "pricingOptions": {
            //     "fareType": [
            //       "PUBLISHED"
            //     ],
            //     "includedCheckedBagsOnly": true
            //   },
            //   "validatingAirlineCodes": [
            //     //"AI"
            //     validatingAirlineCodestrArray.first
            //   ],
            //
            //
            //   "travelerPricings": convert_travelerPricingsArray,
            //
            //   // "travelerPricings": [
            //   //   {
            //   //     "travelerId": "1",
            //   //     "fareOption": "STANDARD",
            //   //     "travelerType": "ADULT",
            //   //
            //   //      "price": priceArray,
            //   //
            //   //     // "price": {
            //   //     //   "currency": "USD",
            //   //     //   "total": "79.80",
            //   //     //   "base": "64.00"
            //   //     // },
            //   //     "fareDetailsBySegment": [
            //   //       {
            //   //         "segmentId": "39",
            //   //         "cabin": "ECONOMY",
            //   //         "fareBasis": "UU1YXFII",
            //   //         "class": "U",
            //   //         "includedCheckedBags": {
            //   //           "weight": 15,
            //   //           "weightUnit": "KG"
            //   //         },
            //   //         "includedCabinBags": {
            //   //           "weight": 7,
            //   //           "weightUnit": "KG"
            //   //         },
            //   //         "additionalServices": {
            //   //           "chargeableSeatNumber": selectedseat
            //   //         }
            //   //       }
            //   //     ]
            //   //   }
            //   // ],
            //    "fareRules": fareRulesArray ?? ''
            //   //   "rules": [
            //   //     {
            //   //       "category": "EXCHANGE",
            //   //       "maxPenaltyAmount": "36.00"
            //   //     },
            //   //     {
            //   //       "category": "REFUND",
            //   //       "maxPenaltyAmount": "48.00"
            //   //     },
            //   //     {
            //   //       "category": "REVALIDATION",
            //   //       "notApplicable": true
            //   //     }
            //   //   ]
            //   // }
            // }
          ]
        }
      }
        // {
        //   "data": {
        //     "type": "flight-offers-pricing",
        //     "flightOffers": [
        //       {
        //         "type": "flight-offer",
        //         "id": flight_ID,
        //         "source": sourcestr,
        //         "instantTicketingRequired": false,
        //         "nonHomogeneous": false,
        //         "oneWay": false,
        //         "isUpsellOffer": false,
        //         "lastTicketingDate": lastTicketing_Datestr,
        //         "lastTicketingDateTime": lastTicketingDate_Timestr,
        //         "numberOfBookableSeats": numberOfBookableSeatsstr,
        //         "itineraries": [
        //           {
        //             "duration": durationstr,
        //              "segments": Convert_segmentArray
        //
        //
        //             // "segments": [
        //             //   {
        //             //     "departure": {
        //             //       "iataCode": "BLR",
        //             //       "terminal": "2",
        //             //       "at": "2024-07-23T11:30:00"
        //             //     },
        //             //     "arrival": {
        //             //       "iataCode": "DEL",
        //             //       "terminal": "3",
        //             //       "at": "2024-07-23T14:10:00"
        //             //     },
        //             //     "carrierCode": "AI",
        //             //     "number": "2816",
        //             //     "aircraft": {
        //             //       "code": "32N"
        //             //     },
        //             //     "operating": {
        //             //       "carrierCode": "AI"
        //             //     },
        //             //     "duration": "PT2H40M",
        //             //     "id": "1",
        //             //     "numberOfStops": 0,
        //             //     "blacklistedInEU": false
        //             //   }
        //             // ]
        //           }
        //         ],
        //
        //          "price": convert_Currency_PriceArray,
        //
        //         // "price": {
        //         //   "currency": "USD",
        //         //   "total": "205.00",
        //         //   "base": "169.00",
        //         //   "fees": [
        //         //     {
        //         //       "amount": "0.00",
        //         //       "type": "SUPPLIER"
        //         //     },
        //         //     {
        //         //       "amount": "0.00",
        //         //       "type": "TICKETING"
        //         //     }
        //         //   ],
        //         //   "grandTotal": "205.00"
        //         // },
        //         "pricingOptions": {
        //           "fareType": [
        //             "PUBLISHED"
        //           ],
        //           "includedCheckedBagsOnly": false
        //         },
        //         "validatingAirlineCodes": [
        //           //"AI"
        //           validatingAirlineCodestrArray.first,
        //         ],
        //          "travelerPricings": convert_travelerPricingsArray,
        //         "additionalServices": {
        //           "chargeableSeatNumber": selectedseat
        //         },
        //
        //
        //         // "travelerPricings": [
        //         //   {
        //         //     "travelerId": "1",
        //         //     "fareOption": "STANDARD",
        //         //     "travelerType": "ADULT",
        //         //     "price": {
        //         //       "currency": "USD",
        //         //       "total": "95.70",
        //         //       "base": "79.00"
        //         //     },
        //         //     "fareDetailsBySegment": [
        //         //       {
        //         //         "segmentId": "1",
        //         //         "cabin": "ECONOMY",
        //         //         "fareBasis": "UIP",
        //         //         "class": "U",
        //         //         "includedCheckedBags": {
        //         //           "weight": 15,
        //         //           "weightUnit": "KG"
        //         //         },
        //         //         "includedCabinBags": {
        //         //           "quantity": 0
        //         //         }
        //         //       }
        //         //     ]
        //         //   },
        //         //   {
        //         //     "travelerId": "2",
        //         //     "fareOption": "STANDARD",
        //         //     "travelerType": "CHILD",
        //         //     "price": {
        //         //       "currency": "USD",
        //         //       "total": "88.30",
        //         //       "base": "72.00"
        //         //     },
        //         //     "fareDetailsBySegment": [
        //         //       {
        //         //         "segmentId": "1",
        //         //         "cabin": "ECONOMY",
        //         //         "fareBasis": "UIPCH",
        //         //         "class": "U"
        //         //       }
        //         //     ]
        //         //   },
        //         //   {
        //         //     "travelerId": "3",
        //         //     "fareOption": "STANDARD",
        //         //     "travelerType": "HELD_INFANT",
        //         //     "associatedAdultId": "1",
        //         //     "price": {
        //         //       "currency": "USD",
        //         //       "total": "21.00",
        //         //       "base": "18.00"
        //         //     },
        //         //     "fareDetailsBySegment": [
        //         //       {
        //         //         "segmentId": "1",
        //         //         "cabin": "ECONOMY",
        //         //         "fareBasis": "UIPIN",
        //         //         "class": "U"
        //         //       }
        //         //     ]
        //         //   }
        //         // ],
        //          "fareRules": fareRulesArray ?? ''
        //
        //
        //         // "fareRules": {
        //         //   "rules": [
        //         //     {
        //         //       "category": "EXCHANGE",
        //         //       "maxPenaltyAmount": "36.00"
        //         //     },
        //         //     {
        //         //       "category": "REFUND",
        //         //       "maxPenaltyAmount": "48.00"
        //         //     },
        //         //     {
        //         //       "category": "REVALIDATION",
        //         //       "notApplicable": true
        //         //     }
        //         //   ]
        //         // }
        //       }
        //     ]
        //   }
        // }


      ),
    );

    print('multi - trip Details array....');

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      // print('suresh detailes data...');
      // print(responseData);
      var flightData = responseData['data'];
      print('price Response data...');
      print(flightData);

      var flightOffers = flightData['flightOffers'];
      print('flightOffers...');
      print(flightOffers);
      flight_offer_Array.add(flightOffers);
      for(var itinerariesValues in flightOffers){
        var itinerariesArray = itinerariesValues['itineraries'];

        print(itinerariesArray);
        for(var segmentvalues in itinerariesArray){


          var SegmentArray = segmentvalues['segments'];
          print('price . SegmentArray...');
          print(SegmentArray);
          // String duration = SegmentArray['duration'];
          // print('duration........-');
          // print(duration);
          // firstflightDurationArray.add(duration);
          // int stops = 0;
          // stops = SegmentArray['numberOfStops'];
          // print('stops...');
          // print(stops);

          for(var DeparturArray in SegmentArray){

            var carrierCodestr = DeparturArray['carrierCode'];
            print('multi generated carrierCode...');
            print(carrierCodestr);

            var Dep = DeparturArray['departure'] ?? "";
            var depiataCodestr = Dep['iataCode'];
            print('depiataCodestr..');
            print(depiataCodestr);

            if (widget.Received_departure_Airports.length == 1 && widget.Received_destination_Airports.length == 1) {

              if(depiataCodestr == widget.Received_departure_Airports[0]) {
                var durationstr = DeparturArray['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                firstflightDurationArray.add(durationstr);
                int stops = 0;
                stops = DeparturArray['numberOfStops'] ?? 0;
                print('stops ...');
                print(stops);
                firstJouney_strops.add(stops);
                print(firstJouney_strops);
                depiataCode = Dep['iataCode'];
                print('depiataCode.......');
                print(depiataCode);
                var departuretime = Dep['at'];
                Deptimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                firstJourney_Departure_timeArray.add(Deptimeconvert);
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));
              }

              //departure flight terminel
              Depterminal = Dep['terminal'] ?? "";
              print('dep terminal2...');
              print(Depterminal);
              firstflightDepterminalArry.add(Depterminal);
            } else if (widget.Received_departure_Airports.length == 2 && widget.Received_destination_Airports.length == 2) {

              if(depiataCodestr == widget.Received_departure_Airports[0]){
                var durationstr = DeparturArray['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                secondJourneyfirstflightDurationArray.add(durationstr);
                int stops = 0;
                stops = DeparturArray['numberOfStops'] ?? 0;
                print('stops11 ...');
                print(stops);
                secondJourney_firstflightstops.add(stops);
                print(secondJourney_firstflightstops);
                depiataCode = Dep['iataCode'];
                print('depiataCode111.......');
                print(depiataCode);
                secondJourneydeparturearray.add(depiataCode);

                var departuretime = Dep['at'];
                Deptimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                secondJourney_firstflight_Departure_timeArray.add(Deptimeconvert);
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));
              }

              //departure flight terminel
              secondJourney_firstdepartureterminal = Dep['terminal'] ?? "";
              print('dep terminal2...');
              print(secondJourney_firstdepartureterminal);
              secondJourney_firstdepartureterminalArray.add(secondJourney_firstdepartureterminal);



              //return flight departure
              if(depiataCodestr == widget.Received_departure_Airports[1]){

                var durationstr = DeparturArray['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                secondJourneysecondflightDurationArray.add(durationstr);
                int stops = 0;
                stops = DeparturArray['numberOfStops'] ?? 0;
                print('stops22 ...');
                print(stops);
                secondJourney_secondflightstops.add(stops);
                print(secondJourney_secondflightstops);
                depiataCode = Dep['iataCode'];
                print('depiataCode21111.......');
                print(depiataCode);
                secondJourneydeparturearray.add(depiataCode);

                var departuretime = Dep['at'];
                return_departure_time =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));

                secondJourney_secondflight_Departure_timeArray.add(return_departure_time);

                secondJourney_seconddepartureterminal = Dep['terminal'] ?? "";
                print('secondJourney_seconddepartureterminal');
                print(secondJourney_seconddepartureterminal);
                secondJourney_seconddepartureterminalArray.add(secondJourney_seconddepartureterminal);

                // OnwardJourney_dateArray.add(Datestr);
                // OnwardJourney_DeptimeArray.add(Deptimeconvert);
                Depterminal = Dep['terminal'] ?? "";
                print('dep terminal4...');
                print(Depterminal);

              }

            } else if (widget.Received_departure_Airports.length == 3 && widget.Received_destination_Airports.length == 3) {

              if(depiataCodestr == widget.Received_departure_Airports[0]){
                var durationstr = DeparturArray['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                thirdJourneyfirstflightDurationArray.add(durationstr);
                int stops = 0;
                stops = DeparturArray['numberOfStops'] ?? 0;
                print('stops11 ...');
                print(stops);
                thirdJourney_firstflightstops.add(stops);
                print(thirdJourney_firstflightstops);
                depiataCode = Dep['iataCode'];
                print('depiataCode111.......');
                print(depiataCode);
                thirdJourneydeparturearray.add(depiataCode);

                var departuretime = Dep['at'];
                Deptimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                thirdJourney_firstflight_Departure_timeArray.add(Deptimeconvert);
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));
              }

              //departure flight terminel
              thirdJourney_firstdepartureterminal = Dep['terminal'] ?? "";
              print('dep terminal2...');
              print(thirdJourney_firstdepartureterminal);
              thirdJourney_firstdepartureterminalArray.add(thirdJourney_firstdepartureterminal);



             // second flight departure
              if(depiataCodestr == widget.Received_departure_Airports[1]){

                var durationstr = DeparturArray['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                thirdJourneysecondflightDurationArray.add(durationstr);
                int stops = 0;
                stops = DeparturArray['numberOfStops'] ?? 0;
                print('stops22 ...');
                print(stops);
                thirdJourney_secondflightstops.add(stops);
                print(thirdJourney_secondflightstops);
                depiataCode = Dep['iataCode'];
                print('depiataCode21111.......');
                print(depiataCode);
                thirdJourney_second_flight_departurearray.add(depiataCode);
                var departuretime = Dep['at'];
                return_departure_time =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));
                thirdJourney_secondflight_Departure_timeArray.add(return_departure_time);
                print('thirdJourney_secondflight_Departure_timeArray........');
                print(thirdJourney_secondflight_Departure_timeArray);
                thirdJourney_seconddepartureterminal = Dep['terminal'] ?? "";
                print('thirdJourney_seconddepartureterminal');
                print(thirdJourney_seconddepartureterminal);
                thirdJourney_seconddepartureterminalArray.add(thirdJourney_seconddepartureterminal);
              }
              //third flight details
              if(depiataCodestr == widget.Received_departure_Airports[2]){

                var durationstr = DeparturArray['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                thirdJourneythirdflightDurationArray.add(durationstr);
                int stops = 0;
                stops = DeparturArray['numberOfStops'] ?? 0;
                print('stops22 ...');
                print(stops);
                thirdJourney_thirdflightstops.add(stops);
                print(thirdJourney_thirdflightstops);
                depiataCode = Dep['iataCode'];
                print('depiataCode21111.......');
                print(depiataCode);
                thirdJourneydeparturearray.add(depiataCode);

                var departuretime = Dep['at'];
                return_departure_time =
                (new DateFormat.Hm().format(DateTime.parse(departuretime)));
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(departuretime)));

                thirdJourney_thirdflight_Departure_timeArray.add(return_departure_time);

                thirdJourney_thirddepartureterminal = Dep['terminal'] ?? "";
                print('thirdJourney_seconddepartureterminal');
                print(thirdJourney_thirddepartureterminal);
                thirdJourney_thirddepartureterminalArray.add(thirdJourney_thirddepartureterminal);
              }



            }
          }

          //Arrival flights
          for(var ArraivalArray in SegmentArray){
            var Arrival = ArraivalArray['arrival'] ?? "";
            var arrivalstr = Arrival['iataCode'];
            print('arrivalstr.....');
            print(arrivalstr);
            print(widget.Received_destination_Airports[0]);


            if (widget.Received_departure_Airports.length == 1 && widget.Received_destination_Airports.length == 1) {
//departure flight arrival time
            print('destination....');
              if(arrivalstr == widget.Received_destination_Airports[0]){
                arrivalCode = Arrival['iataCode'];
                print('arrivalCode...');
                print(arrivalCode);
                var Arrivaltime = Arrival['at'];
                Arrivaltimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
                firstJourney_Arrival_timeArray.add(Arrivaltimeconvert);
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));


                print('arrival time...');
                print(Arrivaltimeconvert);

              }

              Arrivalterminal = Arrival['terminal'] ?? "";
              print('arrival terminal...');
              print(Arrivalterminal);
              firstflightArravalterminalArry.add(Arrivalterminal);

            } else if (widget.Received_departure_Airports.length == 2 && widget.Received_destination_Airports.length == 2) {

              //departure flight arrival time
              if(arrivalstr == widget.Received_destination_Airports[0]) {
                arrivalCode = Arrival['iataCode'];
                print('2nd arrivalCode...');
                print(arrivalCode);
                secondJourneyarrivalarray.add(arrivalCode);
                print('arrival value...');
                print(secondJourneyarrivalarray[0]);
                var Arrivaltime = Arrival['at'];
                Arrivaltimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
                secondJourney_firstflight_Arrival_timeArray.add(Arrivaltimeconvert);
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));

                secondJourney_firstArrvailterminal = Arrival['terminal'] ?? "";
                print('arrival terminal...');
                print(secondJourney_firstArrvailterminal);
                secondJourney_firstArrivalterminalArray.add(secondJourney_firstArrvailterminal);

              }



              if(arrivalstr == widget.Received_destination_Airports[1]) {
                arrivalCode = Arrival['iataCode'];
                print('arrivalCode...');
                secondJourneyarrivalarray.add(arrivalCode);
                var Arrivaltime = Arrival['at'];
                return_arrival_time =
                (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));

                secondJourney_secondflight_Arrival_timeArray.add(return_arrival_time);
                Datestr =
                (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));

                secondJourney_secondArrivalterminal = Arrival['terminal'] ?? "";
                print('secondJourney_secondArrivalterminal...');
                print(secondJourney_secondArrivalterminal);
                secondJourney_secondArrivalterminalArray.add(secondJourney_secondArrivalterminal);
              }
              // print('arrivalCode...');
              // print(arrivalCode);

              var Arrivaltime = Arrival['at'];
              Arrivaltimeconvert =
              (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
              Datestr =
              (new DateFormat.yMd().format(DateTime.parse(Arrivaltime)));
              // OnwardJourney_dateArray.add(Datestr);
              // OnwardJourney_DeptimeArray.add(Deptimeconvert);
            } else if (widget.Received_departure_Airports.length == 3 && widget.Received_destination_Airports.length == 3) {

              if(arrivalstr == widget.Received_destination_Airports[0]){
                var durationstr = Arrival['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                thirdJourneyfirstflightDurationArray.add(durationstr);
                int stops = 0;
                stops = Arrival['numberOfStops'] ?? 0;
                print('stops11 ...');
                print(stops);
                // thirdJourney_firstflightstops.add(stops);
                // print(thirdJourney_firstflightstops);
                arrivalCode = Arrival['iataCode'];
                print('3rd flight arrival code...');
                print(arrivalCode);
                thirdJourneyarrivalarray.add(arrivalCode);
                print('thirdJourneyarrivalarray......');
                print(thirdJourneyarrivalarray);

                var Arrivaltime = Arrival['at'];

                Arrivaltimeconvert =
                (new DateFormat.Hm().format(DateTime.parse(Arrivaltime)));
                print('Arrivaltimeconvert.32');
                print(Arrivaltimeconvert);
                thirdJourney_firstflight_Arrival_timeArray.add(Arrivaltimeconvert);
                print('thirdJourney_firstflight_Arrival_timeArray....');
                print(thirdJourney_firstflight_Arrival_timeArray.first);

                // var arrivaltime = Arrival['at'];
                // arrivaltime =
                // (new DateFormat.Hm().format(DateTime.parse(arrivaltime)));
                // thirdJourney_firstflight_Arrival_timeArray.add(arrivaltime);
                // Datestr =
                // (new DateFormat.yMd().format(DateTime.parse(arrivaltime)));
              }

              //departure flight terminel
              thirdJourney_firstArrvailterminal = Arrival['terminal'] ?? "";
              print('dep terminal2...');
              print(thirdJourney_firstArrvailterminal);
              thirdJourney_firstArrivalterminalArray.add(thirdJourney_firstArrvailterminal);



              //second flight departure
              if(arrivalstr == widget.Received_destination_Airports[1]){

                var durationstr = Arrival['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                thirdJourneysecondflightDurationArray.add(durationstr);
                int stops = 0;
                stops = Arrival['numberOfStops'] ?? 0;
                print('stops22 ...');
                print(stops);
                thirdJourney_secondflightstops.add(stops);
                print(thirdJourney_secondflightstops);
                arrivalCode = Arrival['iataCode'];
                print('depiataCode21111.......');
                print(arrivalCode);
                thirdJourney_second_flight_arrivalarray.add(arrivalCode);

                var arrivaltime = Arrival['at'];
                arrivaltime =
                (new DateFormat.Hm().format(DateTime.parse(arrivaltime)));
                // Datestr =
                // (new DateFormat.yMd().format(DateTime.parse(arrivaltime)));

                thirdJourney_secondflight_Arrival_timeArray.add(arrivaltime);
                print('thirdJourney_secondflight_Arrival_timeArray........');
                print(thirdJourney_secondflight_Arrival_timeArray);

                thirdJourney_secondArrivalterminal = Arrival['terminal'] ?? "";
                print('thirdJourney_secondArrivalterminal');
                print(thirdJourney_secondArrivalterminal);
                thirdJourney_secondArrivalterminalArray.add(thirdJourney_secondArrivalterminal);
              }
              // //third flight details
              if(arrivalstr == widget.Received_destination_Airports[2]) {
                var durationstr = Arrival['duration'];
                print('multi generated carrierCode...');
                print(durationstr);
                thirdJourneythirdflightDurationArray.add(durationstr);
                int stops = 0;
                stops = Arrival['numberOfStops'] ?? 0;
                print('stops22 ...');
                print(stops);
                thirdJourney_thirdflightstops.add(stops);
                print(thirdJourney_thirdflightstops);
                arrivalCode = Arrival['iataCode'];
                print('depiataCode21111.......');
                print(arrivalCode);
                thirdJourneyarrivalarray.add(arrivalCode);
                var arrivaltime = Arrival['at'];
                arrivaltime =
                (new DateFormat.Hm().format(DateTime.parse(arrivaltime)));
                print('arrivaltime....');
                print(arrivaltime);
                // Datestr =
                // (new DateFormat.yMd().format(DateTime.parse(arrivaltime)));
                thirdJourney_thirdflight_Arrival_timeArray.add(arrivaltime);
                thirdJourney_thirddepartureterminal = Arrival['terminal'] ?? "";
                print('thirdJourney_seconddepartureterminal');
                print(thirdJourney_thirdArrivalterminal);
                thirdJourney_thirdArrivalterminalArray.add(thirdJourney_thirdArrivalterminal);
              }


            }
          }
        }
        //for(var Currency_Price in flightData){
        for(var GrandtotalpriceArray in flightOffers) {
          var Currency_Pricestr = GrandtotalpriceArray['price'];
          print('price Currency_Pricestr...');
          print(Currency_Pricestr);
          grandTotalprice = Currency_Pricestr['grandTotal'];
          print('grandTotalprice...');
          print(grandTotalprice);
          Currency_Price_Array.add(Currency_Pricestr);
        }



        //travelerPricings
        for (var priceArray in flightOffers) {
          //travelerPricings
          var travelerPricings_Array = priceArray['travelerPricings'];
          print('passenger price Array...');
          print(travelerPricings_Array);
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


          travelerPricingslistArray.add(travelerPricings_Array);
          List filterpriceArray = travelerPricings_Array.where((
              o) => o['travelerId'] == '1').toList();
          // print('filtered...');
          // print(filterpriceArray);
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

              print('cabin value...');
              print(cabintrvalue);
              var includedCheckedBags = cabinvalueArray['includedCheckedBags'] ?? '';
              print('p includedCheckedBags...');
              print(includedCheckedBags);
              if(weightUnitstr == 'KG'){
                print('true weight...');
                print(weightUnitstr);
                weight = includedCheckedBags['weight'] ?? '';
                print('weight...');
                print(weight);
              } else{
                print('false calling....');
                quantity = includedCheckedBags['quantity'] ?? 0;
                print('quantity...');
                print(quantity);
              }
              weightUnitstr = includedCheckedBags['weightUnit'] ?? "";
              print('weightUnitstr...');
              print(weightUnitstr);
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
              title: Text(
                  'Flight Details Summary', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      fontFamily: 'Baloo',
                      fontWeight: FontWeight.w900,
                      fontSize: 20)),
            ),
            body: Center(
              child: isLoading ?
              CircularProgressIndicator() :
              Column(
                children: <Widget>[
                  //Container(color: Colors.red, height: 50),
                  new Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 6.0),
                    child: Container(
                        width: 320,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Image.asset(
                              "images/aeroplane_image.png",
                              height: 125.0,
                              width: 320.0,
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

                          if(quantity >= 0 && weight == 0){
                            print('quantity wise');
                            Baggagestr = quantity.toString() + ' ' + 'Piece';

                          } else {
                            print('kg wise');
                            Baggagestr = weight.toString() + ' ' + 'kg per person';
                          }
                          if(Cabin_quantity != ''){
                            print('Cabin_quantity wise');
                            Cabin_Baggagestr = Cabin_quantity.toString() + ' ' + 'Piece';

                          }else{
                            print(' Cabinkg wise');
                            Cabin_Baggagestr = Cabin_weight.toString() + ' ' + 'KG';

                          }

                          if (widget.Received_departure_Airports.length == 1 && widget.Received_destination_Airports.length == 1) {
                            Departuretextstr = 'Departure To ' + ' '+  widget.Received_destination_Airports[0];

                          } else if (widget.Received_departure_Airports.length == 2 && widget.Received_destination_Airports.length == 2) {
                            Departuretextstr = 'Departure To ' + ' '+  widget.Received_destination_Airports[0];
                            secondJourney_secondflight_Departuretextstr = 'Departure To ' + ' '+  widget.Received_destination_Airports[1];

                          } else if (widget.Received_departure_Airports.length == 3 && widget.Received_destination_Airports.length == 3) {
                            Departuretextstr = 'Departure To ' + ' '+  widget.Received_destination_Airports[0];
                            secondJourney_secondflight_Departuretextstr = 'Departure To ' + ' '+  widget.Received_destination_Airports[1];
                            thirdJourney_thirdflight_departurests = 'Departure To ' + ' '+  widget.Received_destination_Airports[2];

                          }



                          flight_departurests = 'Price per passenger, taxes and fees included';

                         // trimedDuration = durationstr.substring(2);

                          print('currency code checking...');
                          print(CurrencyCodestr);
                          if(CurrencyCodestr == "USD"){
                            //totalpricevalues = totalPricevaluesArray[index].toString();
                            //print("I have \$$dollars."); // I have $42.
                            // totalpriceSignvalues = "\$$totalpricevalues";
                            totalpriceSignvalues = "\USD $grandTotalprice";
                          } else {
                            // totalpricevalues = totalPricevaluesArray[index].toString();
                            totalpriceSignvalues = "\ZAR $grandTotalprice";
                          }
                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: <Widget>[

                                //Multi city flight search only one source and one destination...

    if (widget.Received_departure_Airports.length == 1 && widget.Received_destination_Airports.length == 1) ...[

      //First flight User Interface..
      Container(
        margin: const EdgeInsets.only(
            left: 5.0, right: 5.0),
        height: 450,
        width: 320,
        child: Column(
          children: [

            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                Departuretextstr,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                flight_departurests,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
            ),
            Container(
              height: 380,
              width: 320,
              color: Colors.black12,
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 320,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 50,
                            width: 300,
                            child: Text(depiataCode + ' ---> ' + arrivalCode,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                            )
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  Container(
                    height: 300,
                    width: 320,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          width: 320,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                height: 350,
                                width: 80,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Text(depiataCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                    ),),

                                    SizedBox(height: 10,),
                                    Text(firstJourney_Departure_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Stops: ${firstJouney_strops.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    Text("Duration: ${firstflightDurationArray.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(firstJourney_Arrival_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),
                                    Text(arrivalCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                    ),),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                height: 350,
                                width: 30,
                                color: Colors.transparent,
                                child:Container(
                                    width: 40,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50.0,
                                      child: Image.asset(
                                          "images/flight-path-icon.png",
                                          height: 300.0,
                                          width: 300.0,
                                          fit: BoxFit.fill
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                height: 350,
                                width: 200,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.topLeft,
                                    //   child: Text(
                                    //     Retrived_round_trip_dep_originiatacodestr,
                                    //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    // ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.Received_departure_Airports.first,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),

                                    Container(
                                      height: 50,
                                      width: 220,
                                      color: Colors.transparent,
                                      child: Text('Terminal:' + "   " + firstflightDepterminalArry.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                    ),

                                    Container(
                                      alignment: FractionalOffset.centerLeft,

                                      height: 135,
                                      width: 200,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Container(
                                            alignment: FractionalOffset.centerLeft,

                                            height: 70,
                                            width: 130,
                                            //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: NetworkImage(logostr),
                                                    fit: BoxFit.cover)
                                            ),
                                          ),
                                          SizedBox(width: 0,),
                                          Container(
                                            height: 45,
                                            width: 140,
                                            color: Colors.transparent,
                                            child:  Text(airlinestr + "   -" + Careercodestr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                            ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Retrived_round_trip_dep_Destinationiatacodestr,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.Received_destination_Airports.first,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Terminal:' + "   " + firstflightArravalterminalArry.last,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),

                                  ] else if(widget.Received_departure_Airports.length == 2 && widget.Received_destination_Airports.length == 2)...[

                                    //Second User Interface
      Container(
        margin: const EdgeInsets.only(
            left: 5.0, right: 5.0),
        height: 460,
        width: 320,
        child: Column(
          children: [

            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                Departuretextstr,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                flight_departurests,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
            ),
            Container(
              height: 400,
              width: 320,
              color: Colors.black12,
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 320,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),




                        Container(
                            height: 50,
                            width: 300,
                            child: Text(secondJourneydeparturearray[0] + ' ---> ' + secondJourneyarrivalarray[0],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                            )
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  Container(
                    height: 320,
                    width: 320,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          width: 320,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                height: 300,
                                width: 80,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Text(secondJourneydeparturearray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                    ),),

                                    SizedBox(height: 10,),
                                    Text(secondJourney_firstflight_Departure_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Stops: ${secondJourney_firstflightstops.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    Text("Duration: ${secondJourneyfirstflightDurationArray.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(secondJourney_firstflight_Arrival_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),
                                    Text(secondJourneyarrivalarray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                    ),),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                height: 350,
                                width: 30,
                                color: Colors.transparent,
                                child:Container(
                                    width: 40,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50.0,
                                      child: Image.asset(
                                          "images/flight-path-icon.png",
                                          height: 300.0,
                                          width: 300.0,
                                          fit: BoxFit.fill
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                height: 350,
                                width: 200,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.topLeft,
                                    //   child: Text(
                                    //     Retrived_round_trip_dep_originiatacodestr,
                                    //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    // ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.Received_departure_Airports.first,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),

                                    Container(
                                      height: 50,
                                      width: 220,
                                      color: Colors.transparent,
                                      child: Text('Terminal:' + "   " + secondJourney_firstdepartureterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                    ),

                                    Container(
                                      alignment: FractionalOffset.centerLeft,

                                      height: 135,
                                      width: 200,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Container(
                                            alignment: FractionalOffset.centerLeft,

                                            height: 70,
                                            width: 130,
                                            //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: NetworkImage(logostr),
                                                    fit: BoxFit.cover)
                                            ),
                                          ),
                                          SizedBox(width: 0,),
                                          Container(
                                            height: 45,
                                            width: 140,
                                            color: Colors.transparent,
                                            child:  Text(airlinestr + "   -" + multi_secondJourney_firstCareercode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                            ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Retrived_round_trip_dep_Destinationiatacodestr,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        widget.Received_destination_Airports.first,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Terminal:' + "   " + secondJourney_firstArrivalterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
      //return flight
      Container(
        margin: const EdgeInsets.only(
            left: 5.0, right: 5.0),
        height: 455,
        width: 320,
        child: Column(
          children: [

            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                secondJourney_secondflight_Departuretextstr,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                flight_departurests,
                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
            ),
            Container(
              height: 400,
              width: 320,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 320,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            height: 50,
                            width: 300,
                            child: Text(secondJourneydeparturearray[1] + '---> ' + secondJourneyarrivalarray[1],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                            )
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2,),
                  Container(
                    height: 300,
                    width: 320,
                    color: Colors.black12,
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          width: 320,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                height: 300,
                                width: 80,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Text(secondJourneydeparturearray[1],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                    ),),

                                    SizedBox(height: 10,),
                                    Text(secondJourney_secondflight_Departure_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),

                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Stops: ${secondJourney_secondflightstops.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),

                                    SizedBox(
                                      height: 30,
                                    ),

                                    Text("Duration: ${secondJourneysecondflightDurationArray.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text(secondJourney_secondflight_Arrival_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                    ),),
                                    Text(arrivalCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                    ),),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                height: 350,
                                width: 30,
                                color: Colors.transparent,
                                child:Container(
                                    width: 40,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 50.0,
                                      child: Image.asset(
                                          "images/flight-path-icon.png",
                                          height: 300.0,
                                          width: 300.0,
                                          fit: BoxFit.fill
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                height: 350,
                                width: 200,
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    // Align(
                                    //   alignment: Alignment.topLeft,
                                    //   child: Text(
                                    //     Retrived_round_trip_dep_originiatacodestr,
                                    //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    // ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Retrived_Rndtrp_Citynamestr,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),

                                    Container(
                                      height: 50,
                                      width: 220,
                                      color: Colors.transparent,
                                      child: Text('Terminal2:' + "   " + secondJourney_seconddepartureterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                    ),

                                    Container(
                                      alignment: FractionalOffset.centerLeft,

                                      height: 135,
                                      width: 200,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 0,
                                          ),
                                          Container(
                                            alignment: FractionalOffset.centerLeft,

                                            height: 70,
                                            width: 130,
                                            //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: NetworkImage(multi_secondJourney_logostr),
                                                    fit: BoxFit.cover)
                                            ),
                                          ),
                                          SizedBox(width: 0,),
                                          Container(
                                            height: 45,
                                            width: 140,
                                            color: Colors.transparent,
                                            child:  Text(multi_secondJourney_airlinestr + "   -" + multi_secondJourney_secondCareercode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                            ),),
                                          )
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Retrived_round_trip_dep_Destinationiatacodestr,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        Retrived_Rndtrp_Destination_Citynamestr,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text('Terminal:' + "   " + secondJourney_secondArrivalterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                    ),
                                  ],
                                ),



                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
                                  ]

                          //else ...[
                          else if(widget.Received_departure_Airports.length == 3 && widget.Received_destination_Airports.length == 3) ...[
      //3 flights are operating User Interface


        Container(
          margin: const EdgeInsets.only(
              left: 5.0, right: 5.0),
          height: 460,
          width: 320,
          child: Column(
            children: [

              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Departuretextstr,
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  flight_departurests,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ),
              Container(
                height: 400,
                width: 320,
                color: Colors.black12,
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      width: 320,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),




                          Container(
                              height: 50,
                              width: 300,
                              child: Text(thirdJourneydeparturearray[0] + ' ---> ' + thirdJourneyarrivalarray[0],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                              )
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2,),
                    Container(
                      height: 320,
                      width: 320,
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: 320,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                  height: 300,
                                  width: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Text(thirdJourneydeparturearray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                      ),),

                                      SizedBox(height: 10,),
                                      Text(thirdJourney_firstflight_Departure_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),

                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text("Stops: ${thirdJourney_firstflightstops.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),

                                      SizedBox(
                                        height: 30,
                                      ),

                                      Text("Duration: ${thirdJourneyfirstflightDurationArray.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(thirdJourney_firstflight_Arrival_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),
                                      Text(thirdJourneyarrivalarray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                  height: 350,
                                  width: 30,
                                  color: Colors.transparent,
                                  child:Container(
                                      width: 40,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 50.0,
                                        child: Image.asset(
                                            "images/flight-path-icon.png",
                                            height: 300.0,
                                            width: 300.0,
                                            fit: BoxFit.fill
                                        ),
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                  height: 350,
                                  width: 200,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     Retrived_round_trip_dep_originiatacodestr,
                                      //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      // ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          widget.Received_departure_Airports.first,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),

                                      Container(
                                        height: 50,
                                        width: 220,
                                        color: Colors.transparent,
                                        child: Text('Terminal:' + "   " + thirdJourney_firstdepartureterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                      ),

                                      Container(
                                        alignment: FractionalOffset.centerLeft,

                                        height: 135,
                                        width: 200,
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Container(
                                              alignment: FractionalOffset.centerLeft,

                                              height: 70,
                                              width: 130,
                                              //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: NetworkImage(multi_thirdJourney_firstflight_logostr),
                                                      fit: BoxFit.cover)
                                              ),
                                            ),
                                            SizedBox(width: 0,),
                                            Container(
                                              height: 45,
                                              width: 140,
                                              color: Colors.transparent,
                                              child:  Text(multi_thirdJourney_firstflight_airlinestr + "   -" + multi_thirdJourney_firstCareercode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                              ),),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_round_trip_dep_Destinationiatacodestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          widget.Received_destination_Airports.first,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Terminal:' + "   " + thirdJourney_firstArrivalterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
        //second flight
        Container(
          margin: const EdgeInsets.only(
              left: 5.0, right: 5.0),
          height: 455,
          width: 320,
          child: Column(
            children: [

              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  secondJourney_secondflight_Departuretextstr,
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  flight_departurests,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ),
              Container(
                height: 400,
                width: 320,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      width: 320,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: 50,
                              width: 300,
                              child: Text(thirdJourney_second_flight_departurearray.first + '---> ' + thirdJourney_second_flight_arrivalarray.first,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                              )
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2,),
                    Container(
                      height: 300,
                      width: 320,
                      color: Colors.black12,
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: 320,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                  height: 300,
                                  width: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Text(thirdJourney_second_flight_departurearray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                      ),),

                                      SizedBox(height: 10,),
                                      Text(thirdJourney_secondflight_Departure_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),

                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text("Stops: ${thirdJourney_secondflightstops.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),

                                      SizedBox(
                                        height: 30,
                                      ),

                                      Text("Duration: ${thirdJourneysecondflightDurationArray.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(thirdJourney_secondflight_Arrival_timeArray.last,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),
                                      Text(thirdJourney_second_flight_arrivalarray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                  height: 350,
                                  width: 30,
                                  color: Colors.transparent,
                                  child:Container(
                                      width: 40,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 50.0,
                                        child: Image.asset(
                                            "images/flight-path-icon.png",
                                            height: 300.0,
                                            width: 300.0,
                                            fit: BoxFit.fill
                                        ),
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                  height: 350,
                                  width: 200,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     Retrived_round_trip_dep_originiatacodestr,
                                      //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      // ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_Rndtrp_Citynamestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),

                                      Container(
                                        height: 50,
                                        width: 220,
                                        color: Colors.transparent,
                                        child: Text('Terminal:' + "   " + thirdJourney_seconddepartureterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                      ),

                                      Container(
                                        alignment: FractionalOffset.centerLeft,

                                        height: 135,
                                        width: 200,
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Container(
                                              alignment: FractionalOffset.centerLeft,

                                              height: 70,
                                              width: 130,
                                              //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: NetworkImage(multi_thirdJourney_secondflight_logostr),
                                                      fit: BoxFit.cover)
                                              ),
                                            ),
                                            SizedBox(width: 0,),
                                            Container(
                                              height: 45,
                                              width: 140,
                                              color: Colors.transparent,
                                              child:  Text(multi_thirdJourney_secondflight_airlinestr + "   -" + multi_thirdJourney_secondCareercode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                              ),),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_round_trip_dep_Destinationiatacodestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_Rndtrp_Destination_Citynamestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Terminal:' + "   " + thirdJourney_secondArrivalterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                      ),
                                    ],
                                  ),



                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),



        //third flight
        Container(
          margin: const EdgeInsets.only(
              left: 5.0, right: 5.0),
          height: 455,
          width: 320,
          child: Column(
            children: [

              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  thirdJourney_thirdflight_departurests,
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  flight_departurests,
                  style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
              ),
              Container(
                height: 400,
                width: 320,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      height: 65,
                      width: 320,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: 50,
                              width: 300,
                              child: Text(thirdJourneydeparturearray[1] + '---> ' + thirdJourneyarrivalarray[1],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                              )
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2,),
                    Container(
                      height: 300,
                      width: 320,
                      color: Colors.black12,
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: 320,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                  height: 300,
                                  width: 80,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      Text(thirdJourneydeparturearray[2],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                      ),),

                                      SizedBox(height: 10,),
                                      Text(thirdJourney_thirdflight_Departure_timeArray.last,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),

                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text("Stops: ${thirdJourney_thirdflightstops.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),

                                      SizedBox(
                                        height: 30,
                                      ),

                                      Text("Duration: ${thirdJourneythirdflightDurationArray.first}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Text(thirdJourney_thirdflight_Arrival_timeArray.first,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                      ),),
                                      Text(arrivalCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                      ),),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                  height: 350,
                                  width: 30,
                                  color: Colors.transparent,
                                  child:Container(
                                      width: 40,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 50.0,
                                        child: Image.asset(
                                            "images/flight-path-icon.png",
                                            height: 300.0,
                                            width: 300.0,
                                            fit: BoxFit.fill
                                        ),
                                      )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 0.0, right: 0.0),

                                  height: 350,
                                  width: 200,
                                  color: Colors.transparent,
                                  child: Column(
                                    children: [
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     Retrived_round_trip_dep_originiatacodestr,
                                      //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      // ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_Rndtrp_Citynamestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),

                                      Container(
                                        height: 50,
                                        width: 220,
                                        color: Colors.transparent,
                                        child: Text('Terminal:' + "   " + thirdJourney_thirddepartureterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                      ),

                                      Container(
                                        alignment: FractionalOffset.centerLeft,

                                        height: 135,
                                        width: 200,
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: 0,
                                            ),
                                            Container(
                                              alignment: FractionalOffset.centerLeft,

                                              height: 70,
                                              width: 130,
                                              //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image: NetworkImage(multi_thirdJourney_thirdflight_logostr),
                                                      fit: BoxFit.cover)
                                              ),
                                            ),
                                            SizedBox(width: 0,),
                                            Container(
                                              height: 45,
                                              width: 140,
                                              color: Colors.transparent,
                                              child:  Text(multi_thirdJourney_thirdflight_airlinestr + "   -" + multi_thirdJourney_thirdCareercode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                              ),),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_round_trip_dep_Destinationiatacodestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          Retrived_Rndtrp_Destination_Citynamestr,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Terminal:' + "   " + thirdJourney_thirdArrivalterminalArray[0],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                      ),
                                    ],
                                  ),



                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),





                                ],

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
                                                  "Continue",
                                                  style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w900,color: Colors.white),
                                                  textAlign: TextAlign.center
                                              ),
                                            )
                                        ),
                                        onTap: () async {
                                          print('continue btn tapped....');
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setString('totalpriceSignvalueskey', (totalpriceSignvalues));
                                          prefs.setString('pricekey', (totalpricevalues));
                                          prefs.setString('Additional_services_currencycodekey', (CurrencyCodestr));




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
                                          print('2 price passengers cnt');
                                          print(Passengers_cnt);
                                          //String segJson = jsonEncode(OnwardJourney_Segmentrray.toString());

                                          //Baggage
                                          prefs.setInt('weightkey', weight) ?? 0;
                                          prefs.setInt('quantitykey', quantity) ?? 0;

                                          String segJson = jsonEncode(Convert_segmentArray);
                                          prefs.setString('Segmentkey', segJson);
                                          //Convert_segmentArray
                                          //prefs.setString('Segmentkey', Convert_segmentArray.toString());
                                          // print('----------seg');
                                          // print(Convert_segmentArray);

                                          String convert_travelerPricingJson = jsonEncode(convert_travelerPricingsArray);
                                          prefs.setString('order_travelerPricingkey', convert_travelerPricingJson);
                                          //Convert_segmentArray
                                          //prefs.setString('Segmentkey', Convert_segmentArray.toString());
                                          // print('----------order_travelerPricingkey');
                                          // print(convert_travelerPricingsArray);




                                          // String Currency_Price = jsonEncode(Currency_Price_Array[index]);
                                          // prefs.setString('Currency_Pricekey', Currency_Price);
                                          print('Currency_Price_Array....');
                                          print(Currency_Price_Array.first);
                                          String convert_Currency_PriceArrayJson = jsonEncode(Currency_Price_Array.first);
                                          prefs.setString('convert_Currency_PriceArraykey', convert_Currency_PriceArrayJson);
                                          print('----------convert_Currency_PriceArrayJson');
                                          print(convert_Currency_PriceArrayJson);
                                          String fareRulesstr = jsonEncode(fareRulesArray);
                                          print('price fareRulesstr....');
                                          print(fareRulesstr);
                                          prefs.setString('fareRuleskey', fareRulesstr);
                                          prefs.setString('validatingAirlineCodeskey', validatingAirlineCodestr);


                                          //Traveller Type
                                          String TravellertypejsonParsing = jsonEncode(travelerTypeArray);
                                          print('TravellertypejsonParsing...');
                                          print(TravellertypejsonParsing);
                                          prefs.setString('TravellertypejsonParsingkey', TravellertypejsonParsing);

                                          String priceArray = jsonEncode(totalPricevaluesArray);
                                          prefs.setString('priceArrayjsonParsingkey', priceArray);
                                                    print('continue btn tapped....');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Multi_city_Add_OnsVC()),
                                                    );

                                          //
                                          //
                                          // String travelerPricings = jsonEncode(travelerPricingslistArray);
                                          // prefs.setString('travelerPricingskey', travelerPricings);
                                          // String Currency_Price = jsonEncode(Currency_Price_Array);
                                          // prefs.setString('Currency_Pricekey', Currency_Price);
                                          // String fareRulesstr = jsonEncode(fareRulesArray);
                                          // prefs.setString('fareRuleskey', fareRulesstr);
                                          // // prefs.setString('airlinekey', convertedAirlineArray.toString());
                                          // // prefs.setString('logokey', AirlinelogoArray[index]);
                                          //
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) => Round_Trip_Add_OnsVC()),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                ),








                                Column(
                                  children: <Widget>[
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Text('', style: TextStyle(
                                              fontSize: 22),);
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

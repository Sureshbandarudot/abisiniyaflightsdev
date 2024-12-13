
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

import 'BaggageDetails/BaggagedetailsVC.dart';
import 'Oneway_journey_update_PassengerslistVC.dart';
import 'OnwardJourney_NewpassengerlistVC.dart';
import 'OnwardJourney_PassengerlistVC.dart';
import 'SeatMap/seatMapVC.dart';
class Add_OnsVC extends StatefulWidget {
  const Add_OnsVC({super.key});

  @override
  State<Add_OnsVC> createState() => _userDashboardState();
}

class _userDashboardState extends State<Add_OnsVC> {
  final baseDioSingleton = BaseSingleton();
  bool isLoading = false;
  String flightTokenstr = '';
  List travelersArray = [];
  List travelersfareDetailsBySegmentArray = [];

  List Convert_segmentArray = [];
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
  String Baggage_Addstr = '';
  String Extra_baggageAmt = '';
  String Extra_secondbaggageAmt = '';
  String Extra_thirdbaggageAmt = '';
  int Extra_baggagequantity = 0;
  int Extra_second_baggagequantity = 0;
  int Extra_third_baggagequantity = 0;
  String Extra_baggage_currency = '';
  String Baggage_Addstrmessage = '';
  String Extra_Baggage_status = '';
  String First_Baggage_status = '';
  String Second_Baggage_status = '';
  String Third_Baggage_status = '';
  String selectedBaggagestatus = '';
  String seatmapstatus = '';
  String SelectedBaggageAmtstr = '';

  var First_Baggage_status_Array = [];
  var  Second_Baggage_status_Array = [];
  var Third_Baggage_status_Array = [];



  var includedArray = '';






  var flight_offer_Array = [];
  var OnwardJourney_Segmentrray = [];
  var Currency_Price_Array = [];
  String grandTotalprice = '';
  // var grand_totalPricevaluesArray = [];







  String selectedseat = '';
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



  late final  segmentDataArray;
  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    CurrencyCodestr = prefs.getString('currency_code_dropdownvaluekey') ?? '';
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
    // print('validatingAirlineCodestr...');
    // print(validatingAirlineCodestr);
    validatingAirlineCodestrArray = json.decode(validatingAirlineCodestr);
    // print('validatingAirlineCodestrArray...');
    // print(validatingAirlineCodestrArray.first);

    //Baggage Data retrived
    //Baggage
    weight = prefs.getInt('weightkey') ?? 0;
    quantity = prefs.getInt('quantitykey') ?? 0;
    print('Retrived weight...');
    print(weight);
    print('Retrived quantity...');
    print(quantity);

    //Cabin Baggage
    // Cabin_weight = prefs.getInt('Cabin_weightkey') ?? 0;
    // print('Retrived Cabin_weight.... ');
    // print(Cabin_weight);
    // Cabin_quantity = prefs.getInt('Cabin_quantitykey') ?? 0;
    // print('Retrived Cabin_quantity.... ');
    // print(Cabin_quantity);



    //print(RetrivedSegment_Array);
    setState(() {
      final data = json.decode(RetrivedSegment_Array);
      for (var i in data) {
        Convert_segmentArray.add(i);
        // print('Convert_segmentArray....');
        // print(Convert_segmentArray);
      }
    });

    //travelerPricings values retrived

    final travelerPricings ;
    travelerPricings = prefs.getString('travelerPricingskey') ?? '';
    print('travelerPricings....');
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
    // print('price convert_travelerPricingsArray...');
    // print(convert_travelerPricingsArray);
    //


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
    print('travelersfareDetailsBySegmentArray....');
    print(travelersfareDetailsBySegmentArray);



    prefs.setString('travelerPricingskey', travelerPricings);


    //currency and price values array retriving..
    final Retrived_Currency_PriceArray ;
    Retrived_Currency_PriceArray = prefs.getString('Currency_Pricekey') ?? '';
    print('p_Retrived_Currency_PriceArray...');
    print(Retrived_Currency_PriceArray);

    convert_Currency_PriceArray = jsonDecode(Retrived_Currency_PriceArray);
    print('convert_Currency_PriceArray....');
    print(convert_Currency_PriceArray);
    grandTotalprice = convert_Currency_PriceArray['grandTotal'];
            print('grandTotalprice...');
            print(grandTotalprice);

   var Additionalservices = convert_Currency_PriceArray['additionalServices'];
   print('Additionalservices...');
   print(Additionalservices);
   // for(var BaggageAmt_Array in Additionalservices){
   //   Extra_baggageAmt = BaggageAmt_Array['amount'];
   //   print('Extra_baggageAmt...');
   //   print(Extra_baggageAmt);
   // }





    //FareRules
    final Retrive_fareRules ;
    Retrive_fareRules = prefs.getString('fareRuleskey') ?? '';
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
    // print(' Details Onward journey token1...');
    // print(flightTokenstr);
    //{{API_URL}}/v1/shopping/flight-offers/pricing

    //v1/shopping/flight-offers/pricing?include=bags
    final response = await http.post(
      Uri.parse(
          'https://test.travel.api.amadeus.com/v1/shopping/flight-offers/pricing?include=bags'),
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
              // "type": "flight-offer",
              // "id": "1",
              // "source": "GDS",
              // "instantTicketingRequired": false,
              // "nonHomogeneous": false,
              // "oneWay": false,
              // "isUpsellOffer": false,
              // "lastTicketingDate": "2024-10-29",
              // "lastTicketingDateTime": "2024-10-29",
              // "numberOfBookableSeats": 6,
              "itineraries": [
                {
                  "duration": durationstr,

                  "segments": Convert_segmentArray

                  // "segments": [
                  //   {
                  //     "departure": {
                  //       "iataCode": "CDG",
                  //       "terminal": "3",
                  //       "at": "2024-11-02T07:00:00"
                  //     },
                  //     "arrival": {
                  //       "iataCode": "MAD",
                  //       "terminal": "4",
                  //       "at": "2024-11-02T09:10:00"
                  //     },
                  //     "carrierCode": "IB",
                  //     "number": "592",
                  //     "aircraft": {
                  //       "code": "321"
                  //     },
                  //     "operating": {
                  //       "carrierCode": "IB"
                  //     },
                  //     "duration": "PT2H10M",
                  //     "id": "5",
                  //     "numberOfStops": 0,
                  //     "blacklistedInEU": false
                  //   }
                  // ]
                }
              ],
              "price": convert_Currency_PriceArray,


              // "price": {
              //   "currency": "ZAR",
              //   "total": "1536.00",
              //   "base": "890.00",
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
              //   "grandTotal": "1536.00",
              //   "additionalServices": [
              //     {
              //       "amount": "1075.00",
              //       "type": "CHECKED_BAGS"
              //     }
              //   ]
              // },
              "pricingOptions": {
                "fareType": [
                  "PUBLISHED"
                ],
                "includedCheckedBagsOnly": true
              },
              "validatingAirlineCodes": [
                //"IB"
                validatingAirlineCodestrArray.first
              ],

              "travelerPricings": convert_travelerPricingsArray,

              // "travelerPricings": [
              //   {
              //     "travelerId": "1",
              //     "fareOption": "STANDARD",
              //     "travelerType": "ADULT",
              //     "price": {
              //       "currency": "ZAR",
              //       "total": "1536.00",
              //       "base": "890.00"
              //     },
              //     "fareDetailsBySegment": [
              //       {
              //         "segmentId": "5",
              //         "cabin": "ECONOMY",
              //         "fareBasis": "ADNNAOB4",
              //         "class": "A",
              //         "includedCheckedBags": {
              //           "quantity": 0
              //         }
              //       }
              //     ]
              //   }
              // ]
            }
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

    print('Details array....');

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Successful POST request, handle the response here
      final responseData = jsonDecode(response.body);
      // print('suresh detailes data...');
      // print(responseData);
      var flightData = responseData['data'];
      print('Add ons price Response data...');
      print(flightData);

      var includedArray = responseData['included'] ?? 'empty';
      print('includedArray......');
      print(includedArray);
      if(includedArray == 'empty') {

        Extra_Baggage_status = 'empty baggage';
        print('this airline not provide any baggage');
        print(Extra_Baggage_status);

      } else {
        print('baggage status..');
        print(Extra_Baggage_status);
        var bagsArraycount = [];
        var bagsArray = includedArray['bags'];
        print('bagsArray....');
        print(bagsArray);
        bagsArraycount.add(bagsArray);
        print('bangs quantity...');
        print(bagsArraycount.length);
        var bagsfirstArray = bagsArray['1'];
        print('bagsfirstArray...');
        print(bagsfirstArray);
        Extra_baggagequantity= bagsfirstArray['quantity'] ?? 0;
        print('bags quantity');
        print(Extra_baggagequantity.toString());

        var bagpriceArray = bagsfirstArray['price'] ?? '';
        print('bagpriceArray...');
        print(bagpriceArray);
        Extra_baggageAmt = bagpriceArray['amount'] ?? '';
        print('Extra_baggageAmt..');
        print(Extra_baggageAmt);
        Extra_baggage_currency = bagpriceArray['currencyCode'] ?? '';
        print('Extra_baggage_currency...');
        print(Extra_baggage_currency);

        var bagssecond_array = bagsArray['2'] ?? 'second bag empty';
        if(bagssecond_array != 'second bag empty' ) {
          Second_Baggage_status = 'Second bag';
          Second_Baggage_status_Array.add(Second_Baggage_status);
          print('bag sts...');

          print(Second_Baggage_status);
          print(Second_Baggage_status_Array);
          print(Second_Baggage_status_Array.toString());
          Extra_second_baggagequantity = bagssecond_array['quantity'] ?? 0;
          print('second bags quantity');
          print(Extra_baggagequantity.toString());

          var bagpriceArray = bagssecond_array['price'] ?? '';
          print('bagpriceArray...');
          print(bagpriceArray);
          Extra_secondbaggageAmt = bagpriceArray['amount'] ?? '';
          print('Extra_secondbaggageAmt..');
          print(Extra_secondbaggageAmt);
          Extra_baggage_currency = bagpriceArray['currencyCode'] ?? '';
          print('Extra_baggage_currency...');
          print(Extra_baggage_currency);

        }
        var bagthird_array = bagsArray['3'] ?? 'third bag empty';
        if(bagthird_array != 'third bag empty' ) {
          Third_Baggage_status = 'third bag';
          Third_Baggage_status_Array.add(Third_Baggage_status);
          Extra_third_baggagequantity= bagthird_array['quantity'] ?? 0;
          print('third bags quantity');
          print(Extra_baggagequantity.toString());
          var bagpriceArray = bagsfirstArray['price'] ?? '';
          print('bagpriceArray...');
          print(bagpriceArray);
          Extra_thirdbaggageAmt = bagpriceArray['amount'] ?? '';
          print('Extra_thirdbaggageAmt..');
          print(Extra_thirdbaggageAmt);
          Extra_baggage_currency = bagpriceArray['currencyCode'] ?? '';
          print('Extra_baggage_currency...');
          print(Extra_baggage_currency);
        }
      }

      print('bag sts...');
      print(Second_Baggage_status);
      print(Second_Baggage_status_Array);
      print(Second_Baggage_status_Array.toString());

      print(Third_Baggage_status);
      print(Third_Baggage_status_Array.toString());




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
            // var priceArray = price['price'];
            // print('total price value..');
            // print(priceArray);
            // totalpricevalues = priceArray['total'];
            // print('total amt..');
            // print(totalpricevalues);
            // totalPricevaluesArray.add(totalpricevalues);
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
              // if(weightUnitstr == 'KG'){
              //   print('true weight...');
              //   print(weightUnitstr);
              //   weight = includedCheckedBags['weight'] ?? '';
              //   print('weight...');
              //   print(weight);
              // } else{
              //   print('false calling....');
              //   quantity = includedCheckedBags['quantity'] ?? 0;
              //   print('quantity...');
              //   print(quantity);
              //
              // }
              //
              //
              //
              // weightUnitstr = includedCheckedBags['weightUnit'] ?? "";
              // print('weightUnitstr...');
              // print(weightUnitstr);
              //

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
            .push(new MaterialPageRoute(builder: (context) => Multiple_passengerlistVC()));
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
            //Text('Abisiniya.',style: (TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.red)),),
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
                  'Select Services', textAlign: TextAlign.center,
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
                    // child: Container(
                    //     width: 320,
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.white,
                    //       radius: 50.0,
                    //       child: Image.asset(
                    //           "images/aeroplane_image.png",
                    //           height: 125.0,
                    //           width: 320.0,
                    //           fit: BoxFit.fill
                    //       ),
                    //     )
                    // ),
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
                          // if(Cabin_quantity != ''){
                          //   print('Cabin_quantity wise');
                          //   Cabin_Baggagestr = Cabin_quantity.toString() + ' ' + 'Piece';
                          //
                          // }else{
                          //   print(' Cabinkg wise');
                          //   Cabin_Baggagestr = Cabin_weight.toString() + ' ' + 'KG';
                          // }
                          Departuretextstr = 'Departure To ' + ' '+  RetrivedOnew_Oneway_DestinationCitynamestr;

                          flight_departurests = 'Price per passenger, taxes and fees included';
                          trimedDuration = durationstr.substring(2);
                          print('Added Extra bag..');
                          print(Baggage_Addstr);
                          if(selectedBaggagestatus == Extra_baggagequantity.toString()){
                            print('selected first piece...');
                            if(Baggage_Addstr != '') {
                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                // var totalAmt = grandTotalprice + Extra_baggageAmt;
                                // int sum = int.parse(grandTotalprice) + int.parse(Extra_baggageAmt);
                                print(              'Sum is: ${grandTotalprice + Extra_baggageAmt}');

                                Baggage_Addstrmessage = 'Added 1 piece' + ' '+ 'Total:' + ' ' + Extra_baggageAmt;

                                // var totalAmt = sum.toString();
                                double n1 = double.tryParse(grandTotalprice) ?? 0.0;
                                double n2 = double.tryParse(Extra_baggageAmt) ?? 0.0;
                                var amtvalue = (n2).toString();
                                SelectedBaggageAmtstr = "$amtvalue ";
                                var result = (n1 + n2).toString();
                                totalpriceSignvalues = "\USD $result ";



                                // totalpriceSignvalues = "\USD $grandTotalprice ";
                              } else {
                                Baggage_Addstrmessage = 'Added' + ' ' + Extra_baggagequantity.toString() + 'piece' + ' '+ 'Total:' + ' ' + Extra_baggageAmt;
                                double n1 = double.tryParse(grandTotalprice) ?? 0.0;
                                double n2 = double.tryParse(Extra_baggageAmt) ?? 0.0;
                                var amtvalue = (n2).toString();
                                SelectedBaggageAmtstr = "$amtvalue ";
                                var result = (n1 + n2).toString();
                                totalpriceSignvalues = "\ZAR $result ";

                              }
                            } else {

                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                totalpriceSignvalues = "\USD $grandTotalprice";
                              } else {
                                // totalpricevalues = totalPricevaluesArray[index].toString();
                                totalpriceSignvalues = "\ZAR $grandTotalprice";
                              }
                            }
                          } else if (selectedBaggagestatus == Extra_second_baggagequantity.toString()) {
                            print('selected second piece....');
                            if(Baggage_Addstr != '') {
                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                // var totalAmt = grandTotalprice + Extra_baggageAmt;
                                // int sum = int.parse(grandTotalprice) + int.parse(Extra_baggageAmt);
                                print(              'Sum is: ${grandTotalprice + Extra_secondbaggageAmt}');

                                Baggage_Addstrmessage = 'Added 2 piece' + ' '+ 'Total:' + ' ' + Extra_secondbaggageAmt;

                                // var totalAmt = sum.toString();
                                double n1 = double.tryParse(grandTotalprice) ?? 0.0;
                                double n2 = double.tryParse(Extra_secondbaggageAmt) ?? 0.0;
                                var amtvalue = (n2).toString();
                                SelectedBaggageAmtstr = "$amtvalue ";
                                var result = (n1 + n2).toString();
                                totalpriceSignvalues = "\USD $result ";



                                // totalpriceSignvalues = "\USD $grandTotalprice ";
                              } else {
                                Baggage_Addstrmessage = 'Added' + ' ' + Extra_second_baggagequantity.toString() + 'piece' + ' '+ 'Total:' + ' ' + Extra_secondbaggageAmt;
                                double n1 = double.tryParse(grandTotalprice) ?? 0.0;
                                double n2 = double.tryParse(Extra_secondbaggageAmt) ?? 0.0;
                                var amtvalue = (n2).toString();
                                SelectedBaggageAmtstr = "$amtvalue ";
                                var result = (n1 + n2).toString();
                                totalpriceSignvalues = "\ZAR $result ";

                              }
                            } else {

                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                totalpriceSignvalues = "\USD $grandTotalprice";
                              } else {
                                // totalpricevalues = totalPricevaluesArray[index].toString();
                                totalpriceSignvalues = "\ZAR $grandTotalprice";
                              }
                            }
                          } else {
                            print('selected third piece....');
                            if(Baggage_Addstr != '') {
                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                // var totalAmt = grandTotalprice + Extra_baggageAmt;
                                // int sum = int.parse(grandTotalprice) + int.parse(Extra_baggageAmt);
                                print(              'Sum is: ${grandTotalprice + Extra_thirdbaggageAmt}');

                                Baggage_Addstrmessage = 'Added 3 piece' + ' '+ 'Total:' + ' ' + Extra_thirdbaggageAmt;

                                // var totalAmt = sum.toString();
                                double n1 = double.tryParse(grandTotalprice) ?? 0.0;
                                double n2 = double.tryParse(Extra_thirdbaggageAmt) ?? 0.0;
                                var amtvalue = (n2).toString();
                                SelectedBaggageAmtstr = "$amtvalue ";
                                var result = (n1 + n2).toString();
                                totalpriceSignvalues = "\USD $result ";



                                // totalpriceSignvalues = "\USD $grandTotalprice ";
                              } else {
                                Baggage_Addstrmessage = 'Added' + ' ' + Extra_baggagequantity.toString() + 'piece' + ' '+ 'Total:' + ' ' + Extra_baggageAmt;
                                double n1 = double.tryParse(grandTotalprice) ?? 0.0;
                                double n2 = double.tryParse(Extra_thirdbaggageAmt) ?? 0.0;
                                var amtvalue = (n2).toString();
                                SelectedBaggageAmtstr = "$amtvalue ";
                                var result = (n1 + n2).toString();
                                totalpriceSignvalues = "\ZAR $result ";

                              }
                            } else {

                              if(CurrencyCodestr == "USD"){
                                //totalpricevalues = totalPricevaluesArray[index].toString();
                                //print("I have \$$dollars."); // I have $42.
                                // totalpriceSignvalues = "\$$totalpricevalues";
                                totalpriceSignvalues = "\USD $grandTotalprice";
                              } else {
                                // totalpricevalues = totalPricevaluesArray[index].toString();
                                totalpriceSignvalues = "\ZAR $grandTotalprice";
                              }
                            }
                          }


                          // if(CurrencyCodestr == "USD"){
                          //   //totalpricevalues = totalPricevaluesArray[index].toString();
                          //   //print("I have \$$dollars."); // I have $42.
                          //   // totalpriceSignvalues = "\$$totalpricevalues";
                          //   totalpriceSignvalues = "\USD $grandTotalprice";
                          // } else {
                          //   // totalpricevalues = totalPricevaluesArray[index].toString();
                          //   totalpriceSignvalues = "\ZAR $grandTotalprice";
                          // }
                          return SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                //Text('Your Apartments'),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  height: 800,
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     flight_departurests,
                                      //     style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                      // ),
                                      Container(
                                        height: 700,
                                        width: 320,
                                        color: Colors.white10,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 180,
                                              width: 320,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.circular(15),
                                              ),                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Container(
                                                      height: 160,
                                                      width: 300,

                                                      // child: Text(depiataCode + '---> ' + arrivalCode,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black
                                                      // )
                                                      // )
                                                    child: Column(

                                                      children: [
                                                        Text('Seat Selection(Optional)',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black
                                                        )),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text('Select a great seat in a advance to get the most out of your flight',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black45
                                                        )),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 320,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                alignment: FractionalOffset.centerLeft,

                                                                height: 50,
                                                                width: 130,
                                                                //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(image: NetworkImage(logostr),
                                                                        fit: BoxFit.cover)
                                                                ),
                                                              ),


                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              InkWell(
                                                                child: Container(
                                                                    height: 40,
                                                                    width: 120,
                                                                    color: Colors.blue,
                                                                    child: Align(
                                                                      alignment: Alignment.center,
                                                                      child: Text(
                                                                          "Choose Seat",
                                                                          style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),
                                                                          textAlign: TextAlign.center
                                                                      ),
                                                                    )
                                                                ),
                                                                onTap: () async {
                                                                  seatmapstatus = 'seatmap';
                                                                  print('continue btn tapped....');
                                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
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
                                                                  print('2 price passengers cnt');
                                                                  print(Passengers_cnt);
                                                                  //String segJson = jsonEncode(OnwardJourney_Segmentrray.toString());


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


                                                                  final snackBar = SnackBar(
                                                                    content: Text('selected seatmap'),
                                                                  );
                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                                                  // String Currency_Price = jsonEncode(Currency_Price_Array[index]);
                                                                  // prefs.setString('Currency_Pricekey', Currency_Price);
                                                                  // print('Currency_Price_Array....');
                                                                  // print(Currency_Price_Array.first);
                                                                  // String convert_Currency_PriceArrayJson = jsonEncode(Currency_Price_Array.first);
                                                                  // prefs.setString('convert_Currency_PriceArraykey', convert_Currency_PriceArrayJson);
                                                                  // print('----------convert_Currency_PriceArrayJson');
                                                                  // print(convert_Currency_PriceArrayJson);
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
                                                                  // print('segJson...');
                                                                  // print(segJson);
                                                                  prefs.setString('priceArrayjsonParsingkey', priceArray);
                                                                  // Navigator.push(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //       builder: (context) => SeatMapVC()),
                                                                  // );
                                                                },
                                                              )
                                                              //--------------




                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),

                                                      // child: Text('Seat Selection',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black
                                                      // )
                                                      // )
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(height: 2,),
                                            // Container(
                                            //   height: 380,
                                            //   width: 320,
                                            //   color: Colors.black12,
                                            //   child: Column(
                                            //     children: [
                                            //       Container(
                                            //         height: 350,
                                            //         width: 320,
                                            //         color: Colors.transparent,
                                            //         child: Row(
                                            //           children: [
                                            //             Container(
                                            //               margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                                            //               height: 350,
                                            //               width: 80,
                                            //               color: Colors.transparent,
                                            //               child: Column(
                                            //                 children: [
                                            //                   Text(depiataCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                            //                   ),),
                                            //
                                            //                   SizedBox(height: 10,),
                                            //                   Text(Deptimeconvert,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                            //                   ),),
                                            //
                                            //                   SizedBox(
                                            //                     height: 100,
                                            //                   ),
                                            //
                                            //                   Text(trimedDuration,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                            //                   ),),
                                            //                   SizedBox(
                                            //                     height: 100,
                                            //                   ),
                                            //                   Text(Arrivaltimeconvert,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black
                                            //                   ),),
                                            //                   Text(arrivalCode,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                            //                   ),),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //             Container(
                                            //               margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                            //               height: 350,
                                            //               width: 30,
                                            //               color: Colors.transparent,
                                            //               child:Container(
                                            //                   width: 40,
                                            //                   child: CircleAvatar(
                                            //                     backgroundColor: Colors.transparent,
                                            //                     radius: 50.0,
                                            //                     child: Image.asset(
                                            //                         "images/flight-path-icon.png",
                                            //                         height: 300.0,
                                            //                         width: 300.0,
                                            //                         fit: BoxFit.fill
                                            //                     ),
                                            //                   )
                                            //               ),
                                            //             ),
                                            //             Container(
                                            //               margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                                            //
                                            //               height: 350,
                                            //               width: 200,
                                            //               color: Colors.transparent,
                                            //               child: Column(
                                            //                 children: [
                                            //                   Align(
                                            //                     alignment: Alignment.topLeft,
                                            //                     child: Text(
                                            //                       Retrived_Oneway_iatacodestr,
                                            //                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                            //                   ),
                                            //                   Align(
                                            //                     alignment: Alignment.topLeft,
                                            //                     child: Text(
                                            //                       Retrived_Oneway_Citynamestr,
                                            //                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                            //                   ),
                                            //
                                            //                   Container(
                                            //                     height: 50,
                                            //                     width: 220,
                                            //                     color: Colors.transparent,
                                            //                     child: Text('Terminal:' + "   " + Depterminal,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                            //                   ),
                                            //
                                            //                   Container(
                                            //                     alignment: FractionalOffset.centerLeft,
                                            //
                                            //                     height: 135,
                                            //                     width: 200,
                                            //                     color: Colors.transparent,
                                            //                     child: Column(
                                            //                       children: [
                                            //                         SizedBox(
                                            //                           width: 0,
                                            //                         ),
                                            //                         Container(
                                            //                           alignment: FractionalOffset.centerLeft,
                                            //
                                            //                           height: 70,
                                            //                           width: 130,
                                            //                           //margin: new EdgeInsets.symmetric(vertical: 5.0),
                                            //                           decoration: BoxDecoration(
                                            //                               image: DecorationImage(image: NetworkImage(logostr),
                                            //                                   fit: BoxFit.cover)
                                            //                           ),
                                            //                         ),
                                            //                         SizedBox(width: 0,),
                                            //                         Container(
                                            //                           height: 45,
                                            //                           width: 140,
                                            //                           color: Colors.transparent,
                                            //                           child:  Text(airlinestr + "   -" + Careercodestr,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black
                                            //                           ),),
                                            //                         )
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                   Align(
                                            //                     alignment: Alignment.topLeft,
                                            //                     child: Text(
                                            //                       RetrivedOneway_Oneway_Destinationiatacodestr,
                                            //                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                            //                   ),
                                            //                   Align(
                                            //                     alignment: Alignment.topLeft,
                                            //                     child: Text(
                                            //                       RetrivedOnew_Oneway_DestinationCitynamestr,
                                            //                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                                            //                   ),
                                            //                   Align(
                                            //                     alignment: Alignment.topLeft,
                                            //                     child: Text('Terminal:' + "   " + Arrivalterminal,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             )
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 350,
                                              width: 320,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey,
                                                ),
                                                borderRadius: BorderRadius.circular(15),
                                              ),                                               child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: 320,
                                                    color: Colors.white,
                                                    child:Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        "Baggage (Optional)",
                                                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: Colors.black),),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Checked baggage: ' + ' '+ Baggagestr,
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black45),),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Align(
                                                  //   alignment: Alignment.centerLeft,
                                                  //   child: Text(
                                                  //     'Cabin baggage: ' + ' '+ Cabin_Baggagestr ?? 'Info unaailable,please check with airline',
                                                  //     style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black45),),
                                                  // ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      'Ticketing: ' + ' '+ 'Within 2 hours after payment',
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Colors.black45),),
                                                  ),




                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                        height: 30,
                                                        width: 320,
                                                        color: Colors.transparent,
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              "Baggage &Policy Details",
                                                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900,color: Colors.blue),
                                                              textAlign: TextAlign.center
                                                          ),
                                                        )
                                                    ),
                                                    onTap: () async {
                                                      print('continue btn tapped....');
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => BaggageDetailsVC()),
                                                      );
                                                    },
                                                  ),
                                                  //Column(
                                                    //children: <Widget>[
                                                      ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: 1,
                                                        // itemBuilder: (context, index) {
                                                        //   return Text('', style: TextStyle(
                                                        //       fontSize: 22),);
                                                        // }
                                                        itemBuilder: (BuildContext context, int index) {

                                                          return ExpansionTile(

                                                            title: Container(
                                                              //width: 100,
                                                              //transform: Matrix4.translationValues(20, 0, 0),
                                                              color: Colors.transparent,
                                                              child: Column(


                                                       children: [
                                                         Align(
                                                             alignment: Alignment.centerRight,
                                                             child: Text('Add',style: (TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.green)),)
                                                         ),

                                                       ],
                                                              ),


                                                            ),
                                                            leading: const SizedBox(width: 0.00,),
                                                            children: [

                                                          if (Extra_Baggage_status == 'empty baggage') ...[

                                                            Container(
                                                              height: 140,
                                                              width: 360,
                                                              color: Colors.white,
                                                              child:   Align(
                                                                  alignment: Alignment.center,
                                                                  child: Text('This Airline does not provided chargeable baggage.If you want more chargeable laggage please contact travel agency',style: (TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.red)),)
                                                              ),
                                                            ),
                                                          ] else...[
                                                            Container(
                                                              height: 40,
                                                              width: 360,
                                                              color: Colors.white,
                                                              child:   Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(Baggage_Addstrmessage,style: (TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.green)),)
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 90,
                                                              width: 360,
                                                              color: Colors.white,
                                                              child: Row(
                                                                children: [


                                                                  Container(
                                                                    margin: const EdgeInsets.only(left: 10.0, right: 0.0),

                                                                    height: 80,
                                                                    width: 100,
                                                                    color: Colors.blue,
                                                                    child: Column(
                                                                      children: [
                                                                        InkWell(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              print('extra bag...');
                                                                              Baggage_Addstr = 'Add';
                                                                              print('calling first bag...');
                                                                              print(Second_Baggage_status);
                                                                              //print(Third_Baggage_status);
                                                                              print(Second_Baggage_status_Array.toString());
                                                                              print(Third_Baggage_status);
                                                                              print(Third_Baggage_status_Array.toString());
                                                                              selectedBaggagestatus = Extra_baggagequantity.toString();
                                                                              print('selected baggage sts...');
                                                                              print(selectedBaggagestatus);
                                                                              final snackBar = SnackBar(
                                                                                content: Text('Added Chargeachable Baggage'),
                                                                              );
                                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                                              //inkwell='Inkwell Tapped';
                                                                            });
                                                                          },
                                                                          onLongPress: () {
                                                                            setState(() {
                                                                              // print('extra bag1...');
                                                                              // Baggage_Addstr = 'Add';

                                                                              //inkwell='InkWell Long Pressed';
                                                                            });
                                                                          },
                                                                          child: Container(
                                                                              color: Colors.blue,
                                                                              width: 150,
                                                                              height: 80,
                                                                              child: Center(
                                                                                child: Column(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      "1"+ '*' + Extra_baggagequantity.toString() + "" + 'Piece',
                                                                                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.white),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    Text(
                                                                                      Extra_baggage_currency + ' ' + Extra_baggageAmt,
                                                                                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                // child: Text(
                                                                                //   '1 *1 Piece = 23',
                                                                                //   style: TextStyle(fontWeight: FontWeight.w500),
                                                                                // )

                                                                              )),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if(Second_Baggage_status == 'Second bag' ) ...[
                                                                    Container(
                                                                      height: 90,
                                                                      width: 105,
                                                                      color: Colors.white,
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            margin: const EdgeInsets.only(left: 5.0, right: 0.0),

                                                                            height: 80,
                                                                            width: 100,
                                                                            color: Colors.blue,
                                                                            child: Column(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      print('selected second extra bag...');
                                                                                      Baggage_Addstr = 'Add';

                                                                                      selectedBaggagestatus = Extra_second_baggagequantity.toString();
                                                                                      print('selected second baggage sts...');
                                                                                      print(selectedBaggagestatus);
                                                                                      final snackBar = SnackBar(
                                                                                        content: Text('Added Chargeachable Baggage'),
                                                                                      );
                                                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                                                      //inkwell='Inkwell Tapped';
                                                                                    });
                                                                                  },
                                                                                  onLongPress: () {
                                                                                    setState(() {
                                                                                      // print('extra bag1...');
                                                                                      // Baggage_Addstr = 'Add';

                                                                                      //inkwell='InkWell Long Pressed';
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                      color: Colors.blue,
                                                                                      width: 150,
                                                                                      height: 80,
                                                                                      child: Center(
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              "1"+ '*' + Extra_second_baggagequantity.toString() + "" + 'Piece',
                                                                                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.white),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              Extra_baggage_currency + ' ' + Extra_secondbaggageAmt,
                                                                                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        // child: Text(
                                                                                        //   '1 *1 Piece = 23',
                                                                                        //   style: TextStyle(fontWeight: FontWeight.w500),
                                                                                        // )

                                                                                      )),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],

                                                                  //Third baggage
                                                                  if(Third_Baggage_status == 'third bag' ) ...[
                                                                    Container(
                                                                      height: 90,
                                                                      width: 105,
                                                                      color: Colors.white,
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            margin: const EdgeInsets.only(left: 5.0, right: 0.0),

                                                                            height: 80,
                                                                            width: 100,
                                                                            color: Colors.blue,
                                                                            child: Column(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      print('third extra bag...');
                                                                                      selectedBaggagestatus = Extra_third_baggagequantity.toString();
                                                                                      print('selected third baggage sts...');
                                                                                      print(selectedBaggagestatus);
                                                                                      Baggage_Addstr = 'Add';

                                                                                      final snackBar = SnackBar(
                                                                                        content: Text('Added Chargeachable Baggage'),
                                                                                      );
                                                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                                                      //inkwell='Inkwell Tapped';
                                                                                    });
                                                                                  },
                                                                                  onLongPress: () {
                                                                                    setState(() {
                                                                                      // print('extra bag1...');
                                                                                      // Baggage_Addstr = 'Add';

                                                                                      //inkwell='InkWell Long Pressed';
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                      color: Colors.blue,
                                                                                      width: 150,
                                                                                      height: 80,
                                                                                      child: Center(
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              "1"+ '*' + Extra_third_baggagequantity.toString() + ''+ 'Piece'
                                                                                              ,
                                                                                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.white),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            Text(
                                                                                              Extra_baggage_currency + ' ' + Extra_thirdbaggageAmt,
                                                                                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        // child: Text(
                                                                                        //   '1 *1 Piece = 23',
                                                                                        //   style: TextStyle(fontWeight: FontWeight.w500),
                                                                                        // )

                                                                                      )),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]

                                                                ],
                                                              ),
                                                            ),








    ],
                                                            ],
                                                          );

                                                          // return ExpansionTile(
                                                          //   title: Text('Add Baggage (+) $index'),
                                                          //   children: <Widget>[
                                                          //     ListTile(title: Text('5 KG')),
                                                          //     ListTile(title: Text('10 KG')),
                                                          //     ListTile(title: Text('15 KG')),
                                                          //     ListTile(title: Text('20 KG')),
                                                          //   ],
                                                          // );
                                                        },

                                                      ),

                                                    ],
                                                  )


                                                //],
                                              //),
                                            ),
                                            SizedBox(
                                              height: 5,
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
                                                              "Book",
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
                                                      // print('Currency_Price_Array....');
                                                      // print(Currency_Price_Array.first);
                                                      // String convert_Currency_PriceArrayJson = jsonEncode(Currency_Price_Array.first);
                                                      // prefs.setString('convert_Currency_PriceArraykey', convert_Currency_PriceArrayJson);
                                                      // print('----------convert_Currency_PriceArrayJson');
                                                      // print(convert_Currency_PriceArrayJson);
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
                                                      // print('segJson...');
                                                      // print(segJson);
                                                      prefs.setString('priceArrayjsonParsingkey', priceArray);

                                                     if(seatmapstatus == 'seatmap' && Baggage_Addstr == ''){
                                                       print('navigate to seatmap...');
                                                       SharedPreferences prefs = await SharedPreferences.getInstance();
                                                       prefs.setString('seatmapkey', 'seatmap');
                                                       Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                             builder: (context) => SeatMapVC()),
                                                       );
                                                     } else if(Baggage_Addstr != '' && seatmapstatus != '') {
                                                       print('selected seat and  baggage....');
                                                       print(totalpricevalues);
                                                       SharedPreferences prefs = await SharedPreferences.getInstance();
                                                       prefs.setString('seatmapkey', 'seatmap_with_Baggage');
                                                       print('selected bag amt price value...');
                                                       print(SelectedBaggageAmtstr);
                                                       prefs.setString('Chargeable_Baggage_Amt_key', SelectedBaggageAmtstr);

                                                       final snackBar = SnackBar(
                                                         content: Text('Selected seatmap and Chargeable Baggage'),
                                                       );
                                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                       print('navigate to booking...');


                                                       Navigator.push(
                                                         context,
                                                         MaterialPageRoute(
                                                             builder: (context) => SeatMapVC()),
                                                       );
                                                     } else {
                                                       final snackBar = SnackBar(
                                                         content: Text('Selected Chargeable Baggage'),
                                                       );
                                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                       print('navigate to booking...');
                                                       Without_seatmap_showAlertDialog(context);
                                                     }




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
                                                      //       builder: (context) => Multiple_passengerlistVC()),
                                                      // );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Column(
                                //   children: <Widget>[
                                //     ListView.builder(
                                //         physics: NeverScrollableScrollPhysics(),
                                //         shrinkWrap: true,
                                //         itemCount: 1,
                                //         // itemBuilder: (context, index) {
                                //         //   return Text('', style: TextStyle(
                                //         //       fontSize: 22),);
                                //         // }
                                //       itemBuilder: (BuildContext context, int index) {
                                //         return ExpansionTile(
                                //           title: Text('Item $index'),
                                //           children: <Widget>[
                                //             ListTile(title: Text('Sub-item 1')),
                                //             ListTile(title: Text('Sub-item 2')),
                                //           ],
                                //         );
                                //       },
                                //
                                //         ),
                                //
                                //   ],
                                // )
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



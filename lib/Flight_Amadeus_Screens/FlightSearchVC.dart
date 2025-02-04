import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../flyScreens/Flights.dart';
import '../flyScreens/airlineVC.dart';
import 'Multi_City_flightSearch/multi_city_tripVC.dart';
import 'Multi_City_flightSearch/multi_city_trip_flightsearchVC.dart';
import 'Multi_city_Airport_pickup/Multi_city_origins_airports/multi_city_select_airportVC.dart';
import 'OneWay_DestinationSelection/Oneway-DestinationJsonVC.dart';
import 'OnwardJourneyVC.dart';
import 'OnwardtripVC.dart';
import 'OriginDestSelectionVC.dart';
import 'ReturnJourney/Roundtrip_Destinationscreens/Rndtrp_DestinationJsonVC.dart';
import 'ReturnJourney/Roundtrip_OriginScreens/Rndtrp_OriginJsonVC.dart';
import 'ReturnJourney_flightsearch/Roundtrip1VC.dart';
import 'ReturnJourney_flightsearch/forwardJourneyVC.dart';
import 'ReturnJourney_flightsearch/forwardtripVC.dart';
import 'flightClasstypesVC.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FlightSearchVC extends StatefulWidget {
  String classstr = '';


  @override
  _FlightSearchVCState createState() => _FlightSearchVCState();
}

class _FlightSearchVCState extends State<FlightSearchVC> with SingleTickerProviderStateMixin {


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



  // Date format
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  String multicity_departure_airport = '';
  String multicity_destination_airport = '';
  String multicity_departure_Date = '';
  List<String> departureAirports = [];
  List<String> destinationAirports = [];
  List<String> multicity_dates = [];

  List<String> selected_dates = [];








  // Remove the last flight segment
  void _removeFlightSegment() {
    if (flights.length > 1) {
      setState(() {
        flights.removeLast();
      });
    }
  }

  // Open the airport selection page
  void _selectAirport(BuildContext context, bool isDeparture, int index) async {
    final selectedAirport = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => multicityOrigincity(
          onAirportSelected: (airport) {
            // Set the selected airport to the respective text field
            setState(() {
              if (isDeparture) {
                flights[index]["departure"]?.text = airport;
                //  multicity_departure_airport = flights[index]["departure"]?.text ?? "";
                // print('selected airports1111...');
                // print(multicity_departure_airport);

              } else {
                flights[index]["destination"]?.text = airport;
              }
            });
          },
        ),
      ),
    );

    // Optionally, you can handle the selected airport here if needed
    if (selectedAirport != null) {
      print("Selected Airport: $selectedAirport");
    }
  }


  // Handle date selection for the flight segment
  Future<void> _selectDate(BuildContext context, TextEditingController Datecontroller) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    //     if (pickedDate != null) {
    //   Multi_city_FromdateInputController.text =
    //       pickedDate.toString();
    //   fromDate = DateFormat('yyyy-MM-dd').format(
    //       pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
    //
    //   Multi_city_FromdateInputController.text = fromDate;
    // }
    );

    if (selectedDate != null) {
      Datecontroller.text = _dateFormat.format(selectedDate);
      print('dates...');
      print(Datecontroller.text);
      selected_dates.add(Datecontroller.text);
    }
  }

  // Handle search functionality

  void _searchFlights() {
    // Collect the flight segment data
    List<Map<String, String>> legs = [];
    for (int i = 0; i < flights.length; i++) {
      legs.add({
        "origin": flights[i]["departure"]?.text ?? '',
        "destination": flights[i]["destination"]?.text ?? '',
        "departureDate": flights[i]["departureDate"]?.text ?? "2025-01-15",
        // Example date
      });
    }
  }

  // void _searchFlights() {
  //   // Implement the flight search functionality here
  //   // You can use APIs to fetch flight data based on the selected cities
  //
  //   // Just showing a message for now
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Searching Flights'),
  //         content: Text('You have searched for ${flights.length} flight segments.'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }





  String classstr = '';
  String currency_code_dropdownvalue = 'Select Currency Code';
  String currency_code_Rndtrp_dropdownvalue = 'Select Currency Code';
  String currency_code_Multi_city_dropdownvalue = 'Select Currency Code';


  var items = [
    'Select Currency Code',
    'USD',
    'ZAR'
  ];

  String passengerliststr = '';
  String flightTokenstr = '';
  // int selectedindex = 0;
  int currentpage = 0;
  String OrginAirportcitystr = '';
  String DestinationAirportcitystr = '';
  String Retrived_Oneway_iatacodestr = '';
  String Retrived_Oneway_Citynamestr = '';
  String Retrived_Oneway_Airportnamestr = '';
  //Multi city Airport pick up variables
  String Retrived_multicity_iatacodestr = '';
  String Retrived_multicity_Citynamestr = '';
  String Retrived_multicity_Airportnamestr = '';

  String RetrivedOneway_Oneway_Destinationiatacodestr = '';
  String RetrivedOnew_Oneway_DestinationCitynamestr = '';

  String RndOriginAirportcitystr = '';
  String Retrived_Rndtrp_iatacodestr = '';
  String Retrived_Rndtrp_Citynamestr = '';

  String RndDestinationAirportcitystr = '';
  String Retrived_Rndtrp_Destination_iatacodestr = '';
  String Retrived_Rndtrp_Destination_Citynamestr = '';





  //TabController _tabController;
  late TabController _tabController;



  _retrieveValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {


      print(currency_code_dropdownvalue);
      prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));

      currency_code_dropdownvalue = prefs.getString('currency_code_dropdownvaluekey') ?? '';

      classstr = prefs.getString('classkey') ?? "";
      passengerliststr = prefs.getString('passengerlistkey') ?? "";
      print('passengerliststr....');
      print(passengerliststr);
      currentpage = prefs.getInt('Roundtripindexkey') ?? 0;
      print('current page...');
      print(currentpage);
      flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
      //Onwway values
      OrginAirportcitystr = prefs.getString('sourcekey') ?? '';
      DestinationAirportcitystr = prefs.getString('destinationkey') ?? '';
      Retrived_Oneway_iatacodestr = prefs.getString('Oneway_iatacodekey') ?? '';
      Retrived_Oneway_Citynamestr = prefs.getString('Oneway_Citynamekey') ?? '';
      Retrived_Oneway_Airportnamestr = prefs.getString('Oneway_Oneway_Airportnamestrkey') ?? '';




      //Roundtrip values

      RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
      Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
      Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';
      //Roundtrip Destination city values
      RndDestinationAirportcitystr = prefs.getString('Rndtrp_Destinationcitykey') ?? '';
      Retrived_Rndtrp_Destination_iatacodestr = prefs.getString('Rndtrp_Destinationiatacodekey') ?? '';
      Retrived_Rndtrp_Destination_Citynamestr = prefs.getString('Rndtrp_DestinationCitynamekey') ?? '';

      RetrivedOneway_Oneway_Destinationiatacodestr = prefs.getString('Oneway_Destinationiatacodekey') ?? '';
      RetrivedOnew_Oneway_DestinationCitynamestr = prefs.getString('Oneway_DestinationCitynamekey') ?? '';


      //Multicity airport cities pick up
      Retrived_multicity_iatacodestr = prefs.getString('multicity_iatacodekey') ?? '';
      Retrived_multicity_Citynamestr = prefs.getString('multicity_Citynamekey') ?? '';
      Retrived_multicity_iatacodestr = prefs.getString('multicity_iatacodekey') ?? '';
      print('Retrived_multicity_iatacodestr....');
      print(Retrived_multicity_iatacodestr);
      print('Retrived_multicity_Citynamestr...');
      print(Retrived_multicity_Citynamestr);

      //Retrived_Oneway_Airportnamestr = prefs.getString('Oneway_Oneway_Airportnamestrkey') ?? '';

      print('flight token received...');
      print(flightTokenstr);
      print('current page1...');
      print(currentpage );
      print('class value...');
      print(classstr);
      print(passengerliststr);
      _tabController = new TabController(vsync: this, length: 3);
      print('tab...');
      print(_tabController.index);
    });
  }




  // var nameTECs = <int, TextEditingController>{};
  // var mailTECs = <int, TextEditingController>{};
  // List<Entry> entries = [];
  //
  // var item = <int, Widget>{};
  //
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   item.addAll({0: newMethod(context, 0)});
  // }
  //
  // ondDone() {
  //   entries.clear();
  //   print(nameTECs.keys.last);
  //   for (int i = 0; i <= nameTECs.keys.last; i++) {
  //     var name = nameTECs[i]?.value.text;
  //     var mail = mailTECs[i]?.value.text;
  //
  //     // print(mailTECs[i]?.value.text);
  //     if (name != null && mail != null) {
  //       entries.add(Entry(name, mail));
  //     }
  //
  //   }
  //   print(entries);
  //   for (int a = 0; a < entries.length; a++) {
  //
  //     print(entries[a].name);
  //     print(entries[a].email);
  //   }
  // }
  //
  // newMethod(
  //     BuildContext context,
  //     int index,
  //     ) {
  //   var nameController = TextEditingController();
  //   var mailController = TextEditingController();
  //   nameTECs.addAll({index: nameController});
  //   mailTECs.addAll({index: mailController});
  //   return Column(
  //     children: [
  //       Text(index.toString()),
  //       TextFormField(
  //         controller: nameController,
  //         validator: (value) {
  //           return value!.isEmpty ? 'Enter some text' : null;
  //         },
  //         // textFieldType: TextFieldType.NAME,
  //
  //       ),
  //
  //       TextFormField(
  //         controller: mailController,
  //         validator: (value) {},
  //         // controller: nameCount,
  //         //textFieldType: TextFieldType.NAME,
  //
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           TextButton(
  //             // onTap: () async{
  //             //   item.addAll({item.keys.last+1: newMethod(context, item.keys.last + 1)});
  //             //   setState(() {});
  //             //
  //             //   // }
  //             // },
  //
  //             onPressed: () {
  //               // onTap: () async{
  //               item.addAll({item.keys.last+1: newMethod(context, item.keys.last + 1)});
  //               setState(() {});
  //
  //               // }
  //               //},
  //             },
  //             child: Text('Add'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               //onTap: () {
  //               setState(() {
  //                 item.removeWhere((key, value) => key == index);
  //                 nameTECs.removeWhere((key, value) => key == index);
  //                 mailTECs.removeWhere((key, value) => key == index);
  //               });
  //               //},
  //
  //               // }
  //               //},
  //             },
  //             // onTap: () {
  //             //   setState(() {
  //             //     item.removeWhere((key, value) => key == index);
  //             //     nameTECs.removeWhere((key, value) => key == index);
  //             //     mailTECs.removeWhere((key, value) => key == index);
  //             //   });
  //             // },
  //
  //             child: Text('Remove'),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }


  @override
  void initState() {
    super.initState();

    _retrieveValues();

  }



  @override
  Widget build(BuildContext context) {
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
          actions: <Widget>[
          ],
          centerTitle: true,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text('Book a flight', textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Baloo',
                  fontWeight: FontWeight.w900,
                  fontSize: 20)),
        ),
        body: SingleChildScrollView(

          child: Column(
            children: <Widget>[

              _tabSection(context),


            ],
          ),
        ));
  }


  Widget _tabSection(BuildContext context) {

    print('calling passenger list values....');
    print(classstr);
    print(passengerliststr);
    //_tabController = new TabController(vsync: this, length: 2);
    print('tab......');
    print(_tabController.index);
    _tabController.addListener((){
      print('my index is'+ _tabController.index.toString());
    });

    int selectedindex = 0;

    String fromDate = '';
    TextEditingController FromdateInputController = TextEditingController();
    //Multi city Departure controller
    TextEditingController Multi_city_FromdateInputController = TextEditingController();


    // TextEditingController TodateInputController = TextEditingController();
    // bool first = false;
    TextEditingController returnFromdateInputController = TextEditingController();
    TextEditingController TodateInputController = TextEditingController();
    TextEditingController passengerController = TextEditingController();
    //Oneway fields:-
    TextEditingController OriginAirportCityController = TextEditingController();
    TextEditingController DestinationAirportCityController = TextEditingController();
    //OriginAirportCityController.text = OrginAirportcitystr;
    // DestinationAirportCityController.text = RetrivedOnew_Oneway_DestinationCitynamestr + " (" + (RetrivedOneway_Oneway_Destinationiatacodestr)+ ")";
    // OriginAirportCityController.text =     Retrived_Oneway_Citynamestr + " (" + ((Retrived_Oneway_iatacodestr)) + ")";


    DestinationAirportCityController.text = RetrivedOnew_Oneway_DestinationCitynamestr;
    OriginAirportCityController.text =     Retrived_Oneway_Citynamestr;

    //Roundtrip fields:-
    TextEditingController Rnd_OriginAirportCityController = TextEditingController();
    TextEditingController Rnd_DestinationAirportCityController = TextEditingController();
    Rnd_OriginAirportCityController.text = Retrived_Rndtrp_Citynamestr;
    Rnd_DestinationAirportCityController.text = Retrived_Rndtrp_Destination_Citynamestr;
    // Rnd_OriginAirportCityController.text = Retrived_Rndtrp_iatacodestr;
    // Rnd_DestinationAirportCityController.text = Retrived_Rndtrp_Destination_iatacodestr;

    //DestinationAirportCityController.text = DestinationAirportcitystr;
    //Multi city textfields
    TextEditingController multicity_OriginAirportCityController = TextEditingController();
    TextEditingController multicity_DestinationAirportCityController = TextEditingController();



    passengerController.text = passengerliststr + " ," + classstr;
    bool first = false;
    String returnfromDatestr = '';
    String toDatestr = '';
    return DefaultTabController(
      length: 3,
      initialIndex: currentpage,
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: <Widget>[
          Container(
            //alignment: Alignment.center,

            // margin: EdgeInsets.fromLTRB(30, 50, 12, 12),
            //margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            margin: EdgeInsets.only(
                left: 0.0, top: 50.0, right: 0.0, bottom: 0.0),
            // padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            // padding: const EdgeInsets.only(top: 8,bottom: 8.0,left: 10, right: 10),

            height: 50,
            width: 360,
            color: Colors.green,
            //color: Color.fromRGBO(133, 193, 233, 0.5),
            child: TabBar(
              //controller: _tabController,
                onTap: (index) {
                  selectedindex = index;
                },
                tabs: [
                  //Tab(text: "One-Way",),
                  Tab(
                    child: Text(
                      'One-Way',
                      style: TextStyle(
                        //fontFamily: kFontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          //color: Color(0xFF818181),
                          color: Colors.white
                      ),
                    ),
                  ),

                  Tab(
                    child: Text(
                      'Round-Trip',
                      style: TextStyle(
                        //fontFamily: kFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        //color: Color(0xFF818181),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Multi-City',
                      style: TextStyle(
                        //fontFamily: kFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        //color: Color(0xFF818181),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            //margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
            //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            height: 550,
            width: 360,
            margin: EdgeInsets.only(
                left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),

            //color: Colors.grey,
            //color: Color.fromRGBO(235, 245, 251, 0.4),
            //133, 193, 233
            color: Color.fromRGBO(133, 193, 233, 0.5),
            //Add this to give height
            // height: MediaQuery.of(context).size.height,
            child: TabBarView(
              //controller: _tabController,

                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          //color: Colors.white,
                          color: Colors.white,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton(
                                isExpanded: true,
                                // Initial Value
                                value: currency_code_dropdownvalue,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    currency_code_dropdownvalue = newValue!;


                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            controller: passengerController,
                            readOnly: true,
                            style: TextStyle(fontSize: 12),

                            onTap: () async{
                              print('Economy class clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => classTypesVC()),
                              );
                              print('Oneway selected ind');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);

                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(Icons.account_circle_outlined,
                                  color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Passengers',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,

                          child: TextField(
                            controller: OriginAirportCityController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),

                            onTap: () async{
                              print('One way source clicked...');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SourceDestinationCityVC()),
                              );
                              print('Oneway selected ind1 ');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                              prefs.setString("OnewayDeparturekey", 'OnewayDeparture');
                              prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                              prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);




                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                  Icons.flight, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Flying from',
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            controller: DestinationAirportCityController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),

                            onTap: () async{
                              print('One way destination clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OnewwayDestinationCityVC()),
                              );
                              print('Oneway selected ind1');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                              prefs.setString("OnewayArrivalkey", 'OnewayArrival');
                              prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                              prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);

                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                  Icons.flight, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Flying to',
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                prefixIcon: Icon(
                                    Icons.calendar_month, color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0),
                                  ),
                                ),

                                hintText: 'Departure',
                              ),

                              controller: FromdateInputController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2050));
                                if (pickedDate != null) {
                                  FromdateInputController.text =
                                      pickedDate.toString();
                                  fromDate = DateFormat('yyyy-MM-dd').format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                                  FromdateInputController.text = fromDate;
                                }
                              }
                          ),
                        ),


                        SizedBox(
                          height: 30,
                        ),

                        InkWell(
                          child: Container(
                              height: 50,
                              width: 340,
                              color: Colors.green,

                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "Search",
                                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                                    textAlign: TextAlign.center
                                ),
                              )

                          ),
                          onTap: () async {

                            // if(FromdateInputController.text != ''){
                              //currency_code_dropdownvalue
                              if(currency_code_dropdownvalue != "Select Currency Code"){


                                SharedPreferences prefs = await SharedPreferences.getInstance();
                              flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                              print('usd tap..');
                              print(flightTokenstr);
                              flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                              prefs.setString("flightTokenstrKey", flightTokenstr);
                              prefs.setString("from_Datekey", FromdateInputController.text);
                              print(currency_code_dropdownvalue);
                              prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));
                              prefs.setString('travel_classstr', (classstr));

                              print('Tapped onward....');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FlightOnWardTrip()),
                              );



                            } else {
                              print('usd empty field...');
                              final snackBar = SnackBar(
                                content: Text('Please select currency code and date.'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }


                          },
                        )

                        // Container(
                        //     height: 50,
                        //     width: 300,
                        //     color: Colors.deepPurple,
                        //     child: Align(
                        //         alignment: Alignment.center,
                        //         child: GestureDetector(
                        //           onTap: () async{
                        //             SharedPreferences prefs = await SharedPreferences.getInstance();
                        //             flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                        //             print('tap..');
                        //              print(flightTokenstr);
                        //             flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                        //             prefs.setString("flightTokenstrKey", flightTokenstr);
                        //
                        //
                        //
                        //             print('Tapped onward....');
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => FlightOnWardJourney()),
                        //             );
                        //
                        //           },
                        //           child: Text('Search1',
                        //               style: TextStyle(
                        //                 height: 1.2,
                        //                 fontFamily: 'Dubai',
                        //                 fontSize: 20,
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w800,
                        //               )),
                        //         )
                        //     )
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          //color: Colors.white,
                          color: Colors.white,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton(
                                isExpanded: true,
                                // Initial Value
                                value: currency_code_Rndtrp_dropdownvalue,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),
                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    currency_code_Rndtrp_dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),


                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            controller: passengerController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16),

                            onTap: () async {
                              print('Economy class clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => classTypesVC()),
                              );
                              print('Return selected ind');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(Icons.account_circle_outlined,
                                  color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: '1 Passenger , Economy',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            controller: Rnd_OriginAirportCityController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16),

                            onTap: () async{
                              print('Economy class clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RndtrpOriginCityVC()),
                              );
                              print('Return selected ind');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                              prefs.setString("RndtrpDeparturekey", 'RndtrpDeparture');
                              prefs.setString("Rndtrp_originiatacodekey", Retrived_Rndtrp_iatacodestr);
                              prefs.setString("Rndtrp_originCitynamekey", Retrived_Rndtrp_Citynamestr);
                              //
                              // RndOriginAirportcitystr = prefs.getString('Rndtrp_origincitykey') ?? '';
                              // Retrived_Rndtrp_iatacodestr = prefs.getString('Rndtrp_originiatacodekey') ?? '';
                              // Retrived_Rndtrp_Citynamestr = prefs.getString('Rndtrp_originCitynamekey') ?? '';


                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                  Icons.flight, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Flying from',
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: TextField(
                            readOnly: true,
                            controller: Rnd_DestinationAirportCityController,
                            style: TextStyle(fontSize: 16),

                            onTap: () async{
                              print('Economy class clicked...');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RndtrpDestinationCityVC()),
                              );
                              print('Return selected ind');
                              print(selectedindex);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setInt('selectedIndexkey', selectedindex);
                              prefs.setString("RndtrpDestinationkey", 'RndtrpDestination');
                              prefs.setString("Rndtrp_Destinationiatacodekey", Retrived_Rndtrp_Destination_iatacodestr);
                              prefs.setString("Rndtrp_DestinationCitynamekey", Retrived_Rndtrp_Destination_Citynamestr);

                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                  Icons.flight, color: Colors.green),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              hintText: 'Flying to',
                            ),
                          ),
                        ),


                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 340,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 165,
                                color: Colors.red,
                                child: TextField(
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      prefixIcon: Icon(Icons.calendar_month,
                                          color: Colors.green),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),
                                      hintText: 'Dep',
                                    ),

                                    controller: returnFromdateInputController,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));
                                      if (pickedDate != null) {
                                        returnFromdateInputController.text =
                                            pickedDate.toString();
                                        returnfromDatestr =
                                            DateFormat('yyyy-MM-dd').format(
                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print('from date...');
                                        print(returnfromDatestr);
                                        returnFromdateInputController.text =
                                            returnfromDatestr;
                                      }
                                    }
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 50,
                                width: 165,
                                color: Colors.red,
                                child: TextField(
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFFFFFFF),
                                      prefixIcon: Icon(Icons.calendar_month,
                                          color: Colors.green),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(0),
                                        ),
                                      ),

                                      hintText: 'Return',
                                    ),

                                    controller: TodateInputController,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime(2050));
                                      if (pickedDate != null) {
                                        TodateInputController.text =
                                            pickedDate.toString();
                                        toDatestr = DateFormat('yyyy-MM-dd').format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        TodateInputController.text = toDatestr;
                                      }
                                    }
                                ),
                              )
                            ],
                          ),
                          // child: TextField(
                          //     decoration: InputDecoration(
                          //       filled: true,
                          //       fillColor: Color(0xFFFFFFFF),
                          //       prefixIcon: Icon(Icons.calendar_month, color: Colors.deepPurple),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.all(
                          //           Radius.circular(0),
                          //         ),
                          //       ),
                          //
                          //       hintText: 'Departure',
                          //     ),
                          //
                          //     controller: FromdateInputController,
                          //     onTap: () async {
                          //       DateTime? pickedDate = await showDatePicker(
                          //           context: context,
                          //           initialDate: DateTime.now(),
                          //           firstDate: DateTime(1950),
                          //           lastDate: DateTime(2050));
                          //       if (pickedDate != null) {
                          //         FromdateInputController.text =pickedDate.toString();
                          //         fromDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          //         FromdateInputController.text = fromDate;
                          //       }
                          //     }
                          // ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          child: Container(
                              height: 50,
                              width: 340,
                              color: Colors.green,

                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "Search",
                                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                                    textAlign: TextAlign.center
                                ),
                              )

                          ),
                          onTap: () async {
                            // print("tapped on container");
                            // SharedPreferences prefs = await SharedPreferences.getInstance();
                            // flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                            // print('tap..');
                            // print(flightTokenstr);
                            // flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                            // prefs.setString("flightTokenstrKey", flightTokenstr);
                            // prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                            // prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);
                            // prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                            // prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);
                            //
                            // prefs.setString("returnfrom_Datekey", returnFromdateInputController.text);
                            // prefs.setString("returnto_Datekey", TodateInputController.text);
                            // print(currency_code_Rndtrp_dropdownvalue);
                            // prefs.setString('currency_code_Rndtrp_dropdownvaluekey', (currency_code_Rndtrp_dropdownvalue));
                            //


                            print('forward Tapped onward....');
                            if(currency_code_Rndtrp_dropdownvalue != "Select Currency Code"){


                              print("tapped on container");
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                              print('tap..');
                              print(flightTokenstr);
                              flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                              prefs.setString("flightTokenstrKey", flightTokenstr);
                              prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                              prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);
                              prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                              prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);

                              prefs.setString("returnfrom_Datekey", returnFromdateInputController.text);
                              prefs.setString("returnto_Datekey", TodateInputController.text);
                              print(currency_code_Rndtrp_dropdownvalue);
                              prefs.setString('currency_code_Rndtrp_dropdownvaluekey', (currency_code_Rndtrp_dropdownvalue));


                              print('Tapped onward....');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Flight_Round_Trip()),
                              );



                            } else {
                              print('usd empty field...');
                              final snackBar = SnackBar(
                                content: Text('Please select currency code.'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Flight_Round_Trip()),
                            // );
                          },
                        )
                      ],
                    ),
                  ),



                  //Multi - city
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Enter Flight Segments',
                        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        // ),
                        // SizedBox(height: 20),
                        // Dynamic list of flight segments
                        //Multi city currencty code
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child:  Container(
                            height: 50,
                            width: 340,
                            //color: Colors.white,
                            color: Colors.white,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  isExpanded: true,
                                  // Initial Value
                                  value: currency_code_Multi_city_dropdownvalue,
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      currency_code_Multi_city_dropdownvalue = newValue!;


                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            height: 50,
                            width: 340,
                            color: Colors.white,
                            child: TextField(
                              controller: passengerController,
                              readOnly: true,
                              style: TextStyle(fontSize: 12),

                              onTap: () async{
                                print('Economy class clicked...');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => classTypesVC()),
                                );
                                print('Oneway selected ind');
                                print(selectedindex);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setInt('selectedIndexkey', selectedindex);

                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFFFF),
                                prefixIcon: Icon(Icons.account_circle_outlined,
                                    color: Colors.green),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(0),
                                  ),
                                ),
                                hintText: 'Passengers',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          itemCount: flights.length,
                          itemBuilder: (context, index) {
                            print('');
                            //Retrived_multicity_iatacodestr = prefs.getString('multicity_iatacodekey') ?? '';

                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Flight ${index + 1}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                Center(
                                   child: Container(
                                      width: 340,
                                      height: 50,
                                      color: Colors.blueGrey,
                                      child:TextField(
                                        controller: flights[index]["departure"],
                                        readOnly: true,
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),
                                        onTap: () async{
                                          print('Departure city clicked....');
                                          print('multi city way source clicked...');
                                          _selectAirport(context, true, index);

                                          print(selectedindex);
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setInt('selectedIndexkey', selectedindex);
                                          prefs.setString("multicityDeparturekey", 'OnewayDeparture');
                                          prefs.setString("multicity_iatacodekey", Retrived_multicity_iatacodestr);
                                          prefs.setString("multicity_Citynamekey", Retrived_multicity_Citynamestr);




                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFFFFFFF),
                                          prefixIcon: Icon(
                                              Icons.flight, color: Colors.green),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(0),
                                            ),
                                          ),
                                          hintText: 'Departure City',
                                        ),
                                      ),
                                    )
                                )

                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    // Destination city

                                    Center(
                                      child: Container(
                                        width: 340,
                                        height: 50,
                                        color: Colors.blueGrey,
                                        child:TextField(
                                          //controller: flights[index]["departure"],
                                          controller: flights[index]["destination"],
                                          readOnly: true,
                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),
                                          onTap: () async{
                                            print('Destination  city clicked....');
                                            _selectAirport(context, false, index);

                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFFFFFF),
                                            prefixIcon: Icon(
                                                Icons.flight, color: Colors.green),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(0),
                                              ),
                                            ),
                                            hintText: 'Destination City',
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        height: 50,
                                        width: 340,
                                        color: Colors.white,
                                        child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFFFFFFF),
                                              prefixIcon: Icon(
                                                  Icons.calendar_month, color: Colors.green),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(0),
                                                ),
                                              ),

                                              hintText: 'Multi city Departure',
                                            ),
                                            controller: flights[index]["departureDate"],


                                           // controller: Multi_city_FromdateInputController,

                                          onTap: () => _selectDate(context, flights[index]["departureDate"]!),

                                          //  onTap: () async {
                                           //    DateTime? pickedDate = await showDatePicker(
                                           //        context: context,
                                           //        initialDate: DateTime.now(),
                                           //        firstDate: DateTime(1950),
                                           //        lastDate: DateTime(2050));
                                           //    if (pickedDate != null) {
                                           //      Multi_city_FromdateInputController.text =
                                           //          pickedDate.toString();
                                           //      fromDate = DateFormat('yyyy-MM-dd').format(
                                           //          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                           //
                                           //      Multi_city_FromdateInputController.text = fromDate;
                                           //    }
                                           //  }
                                        ),
                                      ),
                                    ),

                                    // TextField(
                                    //   controller: flights[index]["destination"],
                                    //   decoration: InputDecoration(
                                    //     labelText: 'Destination City',
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        // Expanded(
                        //   child: Container(
                        //     child: Center(
                        //       child: Text(
                        //         'Second widget',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //     color: Colors.amber,
                        //     width: 200,
                        //   ),
                        // ),

                        // Add/Remove buttons




                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _addFlightSegment,
                              child: Text('Add Another Flight'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: _removeFlightSegment,
                              child: Text('Remove Flight'),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //Multi city flight search button
                        Center(
                            child: InkWell(
                              child: Container(
                                  height: 50,
                                  width: 340,
                                  color: Colors.green,

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        "Search",
                                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                                        textAlign: TextAlign.center
                                    ),
                                  )

                              ),
                              onTap: () async {
                                if(currency_code_Multi_city_dropdownvalue != "Select Currency Code"){


                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                  print('usd tap..');
                                  print(flightTokenstr);
                                  flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                  prefs.setString("flightTokenstrKey", flightTokenstr);
                                  prefs.setString("from_Datekey", FromdateInputController.text);
                                  print(currency_code_dropdownvalue);
                                  prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));
                                  prefs.setString('travel_classstr', (classstr));


                                  print('selected airports...');
                                  print(multicity_departure_airport);
                                  //multicity_departure_airport = flights[index]["departure"]?.text ?? "";


                                  flights.asMap().forEach((index, flight) {
                                    multicity_departure_airport = flight["departure"]?.text ?? "";
                                    print('Index: $index, Departure: $multicity_departure_airport');
                                    departureAirports.add(multicity_departure_airport);

                                    multicity_destination_airport = flight["destination"]?.text ?? "";
                                    print('Index: $index, Destination: $multicity_destination_airport');
                                    destinationAirports.add(multicity_destination_airport);

                                    multicity_departure_Date = flight["departureDate"]?.text ?? "";
                                    print('Index: $index, selected Dates: $multicity_departure_Date');
                                    multicity_dates.add(multicity_departure_Date);
                                  });


                                  print('dates........');
                                  print(selected_dates);

                                  //                                          onTap: () => _selectDate(context, flights[index]["departureDate"]!),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Flight_Multicity_Trip(
                                        Received_departure_Airports: departureAirports,
                                        Received_destination_Airports: destinationAirports,
                                        Received_Dates: multicity_dates,
                                      ), // Pass airport here
                                    ),
                                  );



                                } else {
                                  print('usd empty field...');
                                  final snackBar = SnackBar(
                                    content: Text('Please select currency code and date.'),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }

                                // if(Multi_city_FromdateInputController != ''){
                                //
                                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                                //   flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                //   print('multi city tap..');
                                //   print(flightTokenstr);
                                //   flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                                //   prefs.setString("flightTokenstrKey", flightTokenstr);
                                //   prefs.setString("from_Datekey", Multi_city_FromdateInputController.text);
                                //   print(currency_code_dropdownvalue);
                                //   prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));
                                //   prefs.setString('travel_classstr', (classstr));
                                //
                                //   print('Tapped onward....');
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => FlightOnWardTrip()),
                                //   );
                                //
                                //
                                //
                                // } else {
                                //   print('empty field...');
                                //   final snackBar = SnackBar(
                                //     content: Text('Please select currency code.'),
                                //   );
                                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                // }


                              },
                            )
                        )

                        // Search button
                        // Center(
                        //   child: ElevatedButton(
                        //     onPressed: _searchFlights,
                        //     child: Text('Search Flights'),
                        //   ),
                        // ),
                      ],
                    ),
                  )




    // Expanded(
                  //   child: Container(
                  //     color: Colors.white,
                  //     child: LayoutBuilder(
                  //       builder: (context, constraint) {
                  //         return SingleChildScrollView(
                  //           child: ConstrainedBox(
                  //             constraints:
                  //             BoxConstraints(minHeight: constraint.maxHeight),
                  //             child: IntrinsicHeight(
                  //               child: Column(
                  //                 children: [
                  //
                  //
                  //                 Container(
                  //                           height: 50,
                  //                           width: 340,
                  //                           color: Colors.white,
                  //
                  //                           child: TextField(
                  //                             controller: OriginAirportCityController,
                  //                             readOnly: true,
                  //                             style: TextStyle(fontSize: 12),
                  //
                  //                             onTap: () async{
                  //                               print('One way source clicked...');
                  //
                  //                               Navigator.push(
                  //                                 context,
                  //                                 MaterialPageRoute(
                  //                                     builder: (context) => SourceDestinationCityVC()),
                  //                               );
                  //                               print('Oneway selected ind1 ');
                  //                               print(selectedindex);
                  //                               SharedPreferences prefs = await SharedPreferences.getInstance();
                  //                               prefs.setInt('selectedIndexkey', selectedindex);
                  //                               prefs.setString("OnewayDeparturekey", 'OnewayDeparture');
                  //                               prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                  //                               prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);
                  //
                  //
                  //
                  //
                  //                             },
                  //                             decoration: InputDecoration(
                  //                               filled: true,
                  //                               fillColor: Color(0xFFFFFFFF),
                  //                               prefixIcon: Icon(
                  //                                   Icons.flight, color: Colors.green),
                  //                               border: OutlineInputBorder(
                  //                                 borderRadius: BorderRadius.all(
                  //                                   Radius.circular(0),
                  //                                 ),
                  //                               ),
                  //                               hintText: 'Flying from',
                  //                             ),
                  //                           ),
                  //                         )
                  //
                  //                   // Container(
                  //                   //   child: Column(
                  //                   //     children: [
                  //                   //       SizedBox(
                  //                   //         height: 10,
                  //                   //       ),
                  //                   //       Container(
                  //                   //         height: 50,
                  //                   //         width: 340,
                  //                   //         color: Colors.white,
                  //                   //
                  //                   //         child: TextField(
                  //                   //           controller: OriginAirportCityController,
                  //                   //           readOnly: true,
                  //                   //           style: TextStyle(fontSize: 12),
                  //                   //
                  //                   //           onTap: () async{
                  //                   //             print('One way source clicked...');
                  //                   //
                  //                   //             Navigator.push(
                  //                   //               context,
                  //                   //               MaterialPageRoute(
                  //                   //                   builder: (context) => SourceDestinationCityVC()),
                  //                   //             );
                  //                   //             print('Oneway selected ind1 ');
                  //                   //             print(selectedindex);
                  //                   //             SharedPreferences prefs = await SharedPreferences.getInstance();
                  //                   //             prefs.setInt('selectedIndexkey', selectedindex);
                  //                   //             prefs.setString("OnewayDeparturekey", 'OnewayDeparture');
                  //                   //             prefs.setString("Oneway_iatacodekey", Retrived_Oneway_iatacodestr);
                  //                   //             prefs.setString("Oneway_Citynamekey", Retrived_Oneway_Citynamestr);
                  //                   //
                  //                   //
                  //                   //
                  //                   //
                  //                   //           },
                  //                   //           decoration: InputDecoration(
                  //                   //             filled: true,
                  //                   //             fillColor: Color(0xFFFFFFFF),
                  //                   //             prefixIcon: Icon(
                  //                   //                 Icons.flight, color: Colors.green),
                  //                   //             border: OutlineInputBorder(
                  //                   //               borderRadius: BorderRadius.all(
                  //                   //                 Radius.circular(0),
                  //                   //               ),
                  //                   //             ),
                  //                   //             hintText: 'Flying from',
                  //                   //           ),
                  //                   //         ),
                  //                   //       ),
                  //                   //
                  //                   //       SizedBox(
                  //                   //         height: 10,
                  //                   //       ),
                  //                   //       Container(
                  //                   //         height: 50,
                  //                   //         width: 340,
                  //                   //         color: Colors.white,
                  //                   //         child: TextField(
                  //                   //           controller: DestinationAirportCityController,
                  //                   //           readOnly: true,
                  //                   //           style: TextStyle(fontSize: 12),
                  //                   //
                  //                   //           onTap: () async{
                  //                   //             print('One way destination clicked...');
                  //                   //             Navigator.push(
                  //                   //               context,
                  //                   //               MaterialPageRoute(
                  //                   //                   builder: (context) => OnewwayDestinationCityVC()),
                  //                   //             );
                  //                   //             print('Oneway selected ind1');
                  //                   //             print(selectedindex);
                  //                   //             SharedPreferences prefs = await SharedPreferences.getInstance();
                  //                   //             prefs.setInt('selectedIndexkey', selectedindex);
                  //                   //             prefs.setString("OnewayArrivalkey", 'OnewayArrival');
                  //                   //             prefs.setString("Oneway_Destinationiatacodekey", RetrivedOneway_Oneway_Destinationiatacodestr);
                  //                   //             prefs.setString("Oneway_DestinationCitynamekey", RetrivedOnew_Oneway_DestinationCitynamestr);
                  //                   //
                  //                   //           },
                  //                   //           decoration: InputDecoration(
                  //                   //             filled: true,
                  //                   //             fillColor: Color(0xFFFFFFFF),
                  //                   //             prefixIcon: Icon(
                  //                   //                 Icons.flight, color: Colors.green),
                  //                   //             border: OutlineInputBorder(
                  //                   //               borderRadius: BorderRadius.all(
                  //                   //                 Radius.circular(0),
                  //                   //               ),
                  //                   //             ),
                  //                   //             hintText: 'Flying to',
                  //                   //           ),
                  //                   //         ),
                  //                   //       ),
                  //                   //       SizedBox(
                  //                   //         height: 10,
                  //                   //       ),
                  //                   //       Container(
                  //                   //         height: 50,
                  //                   //         width: 340,
                  //                   //         //color: Colors.white,
                  //                   //         color: Colors.white,
                  //                   //
                  //                   //         child: Column(
                  //                   //           mainAxisAlignment: MainAxisAlignment.center,
                  //                   //           children: [
                  //                   //             DropdownButton(
                  //                   //               isExpanded: true,
                  //                   //               // Initial Value
                  //                   //               value: currency_code_dropdownvalue,
                  //                   //               // Down Arrow Icon
                  //                   //               icon: const Icon(Icons.keyboard_arrow_down),
                  //                   //               // Array list of items
                  //                   //               items: items.map((String items) {
                  //                   //                 return DropdownMenuItem(
                  //                   //                   value: items,
                  //                   //                   child: Text(items),
                  //                   //                 );
                  //                   //               }).toList(),
                  //                   //               // After selecting the desired option,it will
                  //                   //               // change button value to selected value
                  //                   //               onChanged: (String? newValue) {
                  //                   //                 setState(() {
                  //                   //                   currency_code_dropdownvalue = newValue!;
                  //                   //                 });
                  //                   //               },
                  //                   //             ),
                  //                   //           ],
                  //                   //         ),
                  //                   //       ),
                  //                   //       SizedBox(
                  //                   //         height: 10,
                  //                   //       ),
                  //                   //       Container(
                  //                   //         height: 50,
                  //                   //         width: 340,
                  //                   //         color: Colors.white,
                  //                   //         child: TextField(
                  //                   //             decoration: InputDecoration(
                  //                   //               filled: true,
                  //                   //               fillColor: Color(0xFFFFFFFF),
                  //                   //               prefixIcon: Icon(
                  //                   //                   Icons.calendar_month, color: Colors.green),
                  //                   //               border: OutlineInputBorder(
                  //                   //                 borderRadius: BorderRadius.all(
                  //                   //                   Radius.circular(0),
                  //                   //                 ),
                  //                   //               ),
                  //                   //
                  //                   //               hintText: 'Departure',
                  //                   //             ),
                  //                   //
                  //                   //             controller: FromdateInputController,
                  //                   //             onTap: () async {
                  //                   //               DateTime? pickedDate = await showDatePicker(
                  //                   //                   context: context,
                  //                   //                   initialDate: DateTime.now(),
                  //                   //                   firstDate: DateTime(1950),
                  //                   //                   lastDate: DateTime(2050));
                  //                   //               if (pickedDate != null) {
                  //                   //                 FromdateInputController.text =
                  //                   //                     pickedDate.toString();
                  //                   //                 fromDate = DateFormat('yyyy-MM-dd').format(
                  //                   //                     pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  //                   //
                  //                   //                 FromdateInputController.text = fromDate;
                  //                   //               }
                  //                   //             }
                  //                   //         ),
                  //                   //       ),
                  //                   //       SizedBox(
                  //                   //         height: 10,
                  //                   //       ),
                  //                   //       Container(
                  //                   //         height: 50,
                  //                   //         width: 340,
                  //                   //         color: Colors.white,
                  //                   //         child: TextField(
                  //                   //           controller: passengerController,
                  //                   //           readOnly: true,
                  //                   //           style: TextStyle(fontSize: 16),
                  //                   //
                  //                   //           onTap: () async{
                  //                   //             print('Economy class clicked...');
                  //                   //             Navigator.push(
                  //                   //               context,
                  //                   //               MaterialPageRoute(
                  //                   //                   builder: (context) => classTypesVC()),
                  //                   //             );
                  //                   //             print('Oneway selected ind');
                  //                   //             print(selectedindex);
                  //                   //             SharedPreferences prefs = await SharedPreferences.getInstance();
                  //                   //             prefs.setInt('selectedIndexkey', selectedindex);
                  //                   //
                  //                   //           },
                  //                   //           decoration: InputDecoration(
                  //                   //             filled: true,
                  //                   //             fillColor: Color(0xFFFFFFFF),
                  //                   //             prefixIcon: Icon(Icons.account_circle_outlined,
                  //                   //                 color: Colors.green),
                  //                   //             border: OutlineInputBorder(
                  //                   //               borderRadius: BorderRadius.all(
                  //                   //                 Radius.circular(0),
                  //                   //               ),
                  //                   //             ),
                  //                   //             hintText: '1 Passenger , Economy',
                  //                   //           ),
                  //                   //         ),
                  //                   //       ),
                  //                   //       SizedBox(
                  //                   //         height: 30,
                  //                   //       ),
                  //                   //
                  //                   //
                  //                   //       // Container(
                  //                   //       //
                  //                   //       //   child: Column(
                  //                   //       //     children: [
                  //                   //       //       ListView.builder(
                  //                   //       //           shrinkWrap: true,
                  //                   //       //           physics: ScrollPhysics(),
                  //                   //       //           itemCount: item.length,
                  //                   //       //           itemBuilder: (context, index) {
                  //                   //       //             return item.values.elementAt(index);
                  //                   //       //           }),
                  //                   //       //       TextButton(
                  //                   //       //         onPressed: () {
                  //                   //       //           //onTap: () {
                  //                   //       //           if (_formKey.currentState!.validate()) {
                  //                   //       //             ondDone();
                  //                   //       //             // _formKey.currentState!.save();
                  //                   //       //             setState(() {});
                  //                   //       //           }
                  //                   //       //           //},
                  //                   //       //         },
                  //                   //       //         // onTap: () {
                  //                   //       //         //   if (_formKey.currentState!.validate()) {
                  //                   //       //         //     ondDone();
                  //                   //       //         //     // _formKey.currentState!.save();
                  //                   //       //         //     setState(() {});
                  //                   //       //         //   }
                  //                   //       //         // },
                  //                   //       //         //color: Colors.red,
                  //                   //       //         child: Text('save'),
                  //                   //       //       ),
                  //                   //       //       Center(
                  //                   //       //         child: Text('Test'),
                  //                   //       //       ),
                  //                   //       //
                  //                   //       //     ],
                  //                   //       //   ),
                  //                   //       // ),
                  //                   //
                  //                   //
                  //                   //
                  //                   //
                  //                   //       InkWell(
                  //                   //         child: Container(
                  //                   //             height: 50,
                  //                   //             width: 340,
                  //                   //             color: Colors.green,
                  //                   //
                  //                   //             child: Align(
                  //                   //               alignment: Alignment.center,
                  //                   //               child: Text(
                  //                   //                   "Search",
                  //                   //                   style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800,color: Colors.white),
                  //                   //                   textAlign: TextAlign.center
                  //                   //               ),
                  //                   //             )
                  //                   //
                  //                   //         ),
                  //                   //         onTap: () async {
                  //                   //           print("tapped on container");
                  //                   //           SharedPreferences prefs = await SharedPreferences.getInstance();
                  //                   //           flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                  //                   //           print('tap..');
                  //                   //           print(flightTokenstr);
                  //                   //           flightTokenstr = prefs.getString('flightTokenstrKey') ?? '';
                  //                   //           prefs.setString("flightTokenstrKey", flightTokenstr);
                  //                   //           prefs.setString("from_Datekey", FromdateInputController.text);
                  //                   //           print(currency_code_dropdownvalue);
                  //                   //           prefs.setString('currency_code_dropdownvaluekey', (currency_code_dropdownvalue));
                  //                   //
                  //                   //           print('Tapped onward....');
                  //                   //           Navigator.push(
                  //                   //             context,
                  //                   //             MaterialPageRoute(
                  //                   //                 builder: (context) => FlightOnWardTrip()),
                  //                   //           );
                  //                   //         },
                  //                   //       )
                  //                   //     ],
                  //                   //   ),
                  //                   // ),
                  //                 ],
                  //             ),
                  //           ),
                  //           )
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // )





                ]),
          ),
        ],
      ),
    );
  }
}




class Entry {
  final String? name;
  final String? email;

  Entry(
      this.name,
      this.email,
      );


}

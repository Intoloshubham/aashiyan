import 'dart:convert';
import 'package:aashiyan/components/forms.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../const.dart';
import '../../../controller/api_services.dart';
import 'package:http/http.dart' as http;

class Basement extends StatefulWidget {
  static const namedRoute = "/Basement";
  @override
  State<Basement> createState() => _BasementState();
}

class _BasementState extends State<Basement> {
  final List<String> otherItems = ["Pantry", "Staff Toilet", "Toilet"];

  var pageId;
  var viewData;
  var barFaci = [];
  var officeFac = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<String> otherFacilities = [];
  void multiSelected() async {
    final List<String> otherItems = ["Pantry", "Staff Toilet", "Toilet"];

    final List<String> result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MultiSelect(items: otherItems);
        });

    if (result != null) {
      setState(() {
        otherFacilities = result;
      });
    }
  }

  int officeLengthController = 0;
  int officeWidthController = 0;
  String officeSpecificReqController = '';
  int serventLengthController = 0;
  int serventWidthController = 0;
  String serventSpecificController = '';
  int serventController = 0;
  int homeTheaterLengthController = 0;
  int homeTheaterWidthController = 0;
  String homeTheaterSpecificController = "";
  int additionalParkingLength = 0;
  int additionalParkingWidth = 0;
  int additionalCarsController = 0;
  int indoorPlayLengthController = 0;
  int indoorPlayWidtController = 0;
  String additionalParkingSpecificController = '';
  String indoorPlaySpecificRequirement = '';
  int barLengthController = 0;
  int barWidthController = 0;
  int barSpecificRequiremrnt = 0;
  int swimmingPoolLengthController = 0;
  String swimmingPoolSpecificRequirement = '';
  int swimmingPoolWidthController = 0;
  int gymLengthController = 0;
  int gymWidthController = 0;
  String gymSpecificRequirement = '';
  int spaLengthController = 0;
  int spaWidthController = 0;
  String spaSpecificReq = '';
  String gardenSpecificRequiremnt = '';
  String sepratedShadeController = '';
  int NoOfserventController = 0;

  String slectedBasement = "For parking";
  List<String> basementList = ["For parking", "For amenites", "Both"];

  String slectedstilt = "For parking";
  List<String> stiltList = ["For parking", "For amenites", "Both"];

  String selectedOfficeLocation = "Select Location";
  List<String> listOfficeLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area"
  ];

  String serventLocation = "Select Location";
  List<String> serventItems = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area"
  ];

  String homeTheaterFloor = "Select Floor";
  List<String> homeTheaterFloorItems = [
    "Select Floor",
    "Ground Floor",
    "1st Floor",
    "2nd Floor",
    "3rd Floor",
    "Basement",
    "Stilt",
    "Terrace",
    "other"
  ];
  int noServents = 0;
  String selectedServent = "Select";
  List<String> noOfServents = ["Select", "1", "2", "3"];

  String selectedSeats = "Select";
  List<String> seatsItems = ["Select", "8", "10", "12", "more"];

  String selectedIndoorLocation = "Select Location";
  List<String> itemsIndoorLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area"
  ];

  String selectedBarLocation = "Select Location";
  List<String> itemsBarLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area"
  ];

  String swimmingLocation = "Select Location";
  List<String> itemsSwimmingLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area",
  ];

  String gymLocation = "Select Location";
  List<String> itemsGymLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area",
  ];

  String spaLocation = "Select Location";
  List<String> itemsSpaLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area",
  ];

  String gardenLocation = "Select Location";
  List<String> gardenItems = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area",
  ];

  String selectedParkingLocation = "Select Location";
  List<String> parkingLocation = [
    "Select Location",
    "Basement",
    "Stilt",
    "Ground other than stilt area",
  ];

  bool? serventFacility1 = false;
  bool? serventFacility2 = false;

  bool? BasementRequirement = false;
  bool? BasementNotRequire = false;
  int basementReqInt = 0;

  bool? StiltRequirement = false;
  bool? StiltNotRequire = false;
  int stilitReqInt = 0;

  bool? officeRequirement = false;
  bool? officeNotRequire = false;
  int officeReqInt = 0;
  String officeArea = '';
  List officeFacility = [];

  bool? servantNotRequired = false;
  bool? servantRequirement = false;
  int servantReqInt = 0;
  String serventArea = '';
  List serventFacility = [];

  bool? HomeTheaterNotRequired = false;
  bool? HomeTheaterRequirement = false;
  int homeReqInt = 0;
  String homeArea = '';

  bool? AdditionalNotRequired = false;
  bool? AdditionalRequirement = false;
  int additionalReqInt = 0;
  String additionalArea = '';

  bool? indoorNotRequired = false;
  bool? indoorRequirement = false;
  int indoorReqInt = 0;
  String indoorArea = '';

  bool? barNotRequired = false;
  bool? barRequirement = false;

  bool? barFacility1 = false;
  bool? barFacility2 = false;
  int barReqInt = 0;
  String barArea = '';
  List barFacility = [];

  bool? swimmingNotRequired = false;
  bool? swimmingRequirement = false;
  int swimmingReqInt = 0;
  String swimmingPoolArea = '';

  bool? gymNotRequired = false;
  bool? gymRequirement = false;
  int gymReqInt = 0;
  String gymArea = '';

  bool? spaNotRequired = false;
  bool? spaRequirement = false;
  int spaRequiredInt = 0;
  String spArea = '';

  bool? gardenNotRequired = false;
  bool? gardenRequirement = false;
  int gardenRequirementInt = 0;

  Future<void> getData() async {
    var response = await http.get(
      Uri.parse(
        "http://192.168.0.99:8080/sdplserver/api/edit-bungalow-basement/179",
      ),
    );
    final jsonResponse = jsonDecode(response.body);
    // print(jsonResponse);
    if (response.statusCode == 200) {
      print("getting data");
      // print(jsonResponse);
      setState(() {
        viewData = jsonResponse;
        pageId = viewData['bungalow_basement']['id'];
        print(pageId);
        print("jsonResponse===");

        if (viewData != null) {
          BasementRequirement =
              viewData["bungalow_basement"]['basement_req'] == 1 ? true : false;
          BasementNotRequire =
              viewData["bungalow_basement"]['basement_req'] == 0 ? true : false;

          slectedBasement =
              viewData["bungalow_basement"]['basement_type'] != null
                  ? viewData["bungalow_basement"]['basement_type']
                  : "ForParking";

          StiltRequirement =
              viewData["bungalow_basement"]['stilt_req'] == 1 ? true : false;
          StiltNotRequire =
              viewData["bungalow_basement"]['stilt_req'] == 0 ? true : false;

          slectedstilt = viewData["bungalow_basement"]["stilt_type"] != null
              ? viewData["bungalow_basement"]["stilt_type"].toString()
              : slectedstilt;
          print(slectedstilt);
          officeRequirement =
              viewData["bungalow_basement"]['office_req'] == 1 ? true : false;
          officeNotRequire =
              viewData["bungalow_basement"]['office_req'] == 0 ? true : false;
          selectedOfficeLocation =
              viewData["bungalow_basement"]['office_location'] != null
                  ? viewData["bungalow_basement"]['office_location']
                  : "ForParking";
          officeLengthController =
              viewData["bungalow_basement"]['office_length'] != null
                  ? int.parse(
                      viewData["bungalow_basement"]['office_length'].toString())
                  : 0;
          officeWidthController =
              viewData["bungalow_basement"]['office_width'] != null
                  ? int.parse(
                      viewData["bungalow_basement"]['office_width'].toString())
                  : 0;

          officeFac = viewData != null
              ? viewData["bungalow_basement"]['office_facility']
                  .toString()
                  .split(',')
              : [];
          if (viewData != null
              ? viewData['bungalow_basement']['office_facility'] != null
              : officeFac != null) {
            for (int i = 0; i < officeFac.length; i++) {
              otherFacilities.add(otherItems[int.parse(officeFac[i])]);
              print(otherItems[int.parse(officeFac[i])]);
            }
          }

          barFaci = viewData["bungalow_basement"]["bar_facility"] != null
              ? viewData["bungalow_basement"]["bar_facility"]
                  .toString()
                  .split(',')
              : [];
          officeSpecificReqController = viewData["bungalow_basement"]
                      ['office_specific_req'] !=
                  null
              ? viewData["bungalow_basement"]['office_specific_req'].toString()
              : '';
          servantRequirement =
              viewData["bungalow_basement"]['servent_quarter_req'] == "1"
                  ? true
                  : false;
          servantNotRequired =
              viewData["bungalow_basement"]['servent_quarter_req'] == "0"
                  ? true
                  : false;
          serventLengthController =
              viewData["bungalow_basement"]['servent_quarter_length'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['servent_quarter_width']
                      .toString())
                  : 0;
          serventWidthController =
              viewData["bungalow_basement"]['servent_quarter_width'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['servent_quarter_width']
                      .toString())
                  : 0;
          serventSpecificController = viewData["bungalow_basement"]
                      ['servent_quarter_specific_req'] !=
                  null
              ? viewData["bungalow_basement"]['servent_quarter_specific_req']
                  .toString()
              : '';
          selectedServent =
              viewData["bungalow_basement"]['no_of_servent_quarter'] != null
                  ? viewData["bungalow_basement"]['no_of_servent_quarter']
                      .toString()
                  : '';
          serventLocation =
              viewData["bungalow_basement"]['servent_quarter_location'] != null
                  ? viewData["bungalow_basement"]['servent_quarter_location']
                      .toString()
                  : '';
          serventFacility =
              viewData["bungalow_basement"]['servent_quarter_facility'] != null
                  ? viewData["bungalow_basement"]['servent_quarter_facility']
                      .toString()
                      .split(',')
                  : [];

          if (serventFacility != null) {
            if (serventFacility.contains('1')) {
              serventFacility1 = true;
            }
            if (serventFacility.contains('2')) {
              serventFacility2 = true;
            }
          }

          HomeTheaterRequirement =
              viewData["bungalow_basement"]['home_theater_req'] == 1
                  ? true
                  : false;
          HomeTheaterNotRequired =
              viewData["bungalow_basement"]['home_theater_req'] == 0
                  ? true
                  : false;
          homeTheaterLengthController =
              viewData["bungalow_basement"]['servent_quarter_length'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['servent_quarter_length']
                      .toString())
                  : 0;
          homeTheaterWidthController =
              viewData["bungalow_basement"]['home_theater_width'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['home_theater_width']
                      .toString())
                  : 0;
          homeTheaterSpecificController = viewData != null &&
                  viewData["bungalow_basement"]["home_theater_specific_req"] !=
                      null
              ? viewData["bungalow_basement"]["home_theater_specific_req"]
              : '';
          homeTheaterFloor =
              viewData["bungalow_basement"]['home_theater_location'] != null
                  ? viewData["bungalow_basement"]['home_theater_location']
                      .toString()
                  : '';
          selectedSeats = viewData["bungalow_basement"]['home_theater_seats'] !=
                  null
              ? viewData["bungalow_basement"]['home_theater_seats'].toString()
              : '';
          AdditionalRequirement =
              viewData["bungalow_basement"]['parking_garage_req'] == 1
                  ? true
                  : false;
          AdditionalNotRequired =
              viewData["bungalow_basement"]['parking_garage_req'] == 0
                  ? true
                  : false;
          additionalParkingLength =
              viewData["bungalow_basement"]['parking_garage_length'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['parking_garage_length']
                      .toString())
                  : 0;
          additionalParkingWidth =
              viewData["bungalow_basement"]['parking_garage_width'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['parking_garage_width']
                      .toString())
                  : 0;
          additionalParkingWidth = viewData["bungalow_basement"]
                      ["parking_garage_width"] !=
                  null
              ? int.parse(viewData["bungalow_basement"]["parking_garage_width"])
              : 0;

          additionalParkingLength =
              viewData["bungalow_basement"]["parking_garage_length"] != null
                  ? int.parse(
                      viewData["bungalow_basement"]["parking_garage_length"])
                  : 0;

          sepratedShadeController =
              viewData["bungalow_basement"]['saperate_shade'] != null
                  ? viewData["bungalow_basement"]['saperate_shade'].toString()
                  : '';
          selectedParkingLocation =
              viewData["bungalow_basement"]['parking_garage_location'] != null
                  ? viewData["bungalow_basement"]['parking_garage_location']
                      .toString()
                  : '';

          additionalParkingSpecificController = viewData["bungalow_basement"]
                      ['parking_garage_specific_req'] !=
                  null
              ? viewData["bungalow_basement"]['parking_garage_specific_req']
              : '';

          additionalCarsController =
              viewData["bungalow_basement"]["no_of_cars"] != null
                  ? int.parse(viewData["bungalow_basement"]["no_of_cars"])
                  : 0;
          selectedParkingLocation =
              viewData['bungalow_basement']['parking_garage_location'] != null
                  ? viewData['bungalow_basement']['parking_garage_location']
                      .toString()
                  : selectedParkingLocation;
          additionalParkingSpecificController = viewData["bungalow_basement"]
                      ["parking_garage_specific_req"] !=
                  null
              ? viewData["bungalow_basement"]["parking_garage_specific_req"]
              : '';
          indoorRequirement =
              viewData["bungalow_basement"]['indoor_play_req'] == 1
                  ? true
                  : false;
          indoorNotRequired =
              viewData["bungalow_basement"]['indoor_play_req'] == 0
                  ? true
                  : false;
          sepratedShadeController =
              viewData["bungalow_basement"]["saperate_shade"] ?? '';

          indoorPlayLengthController =
              viewData["bungalow_basement"]['indoor_play_length'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['indoor_play_length']
                      .toString())
                  : 0;
          indoorPlayWidtController = viewData["bungalow_basement"]
                      ['indoor_play_width'] !=
                  null
              ? int.parse(
                  viewData["bungalow_basement"]['indoor_play_width'].toString())
              : 0;
          selectedIndoorLocation = viewData["bungalow_basement"]
                      ['indoor_play_location'] !=
                  null
              ? viewData["bungalow_basement"]['indoor_play_location'].toString()
              : '';
          indoorPlaySpecificRequirement = viewData["bungalow_basement"]
                                        ["indoor_play_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["indoor_play_specific_req"]
                                : '';
          barRequirement =
              viewData["bungalow_basement"]['bar_req'] == 1 ? true : false;

          barLengthController =
              viewData["bungalow_basement"]['bar_length'] != null
                  ? int.parse(
                      viewData["bungalow_basement"]['bar_length'].toString())
                  : 0;
          barWidthController = viewData["bungalow_basement"]['bar_width'] !=
                  null
              ? int.parse(viewData["bungalow_basement"]['bar_width'].toString())
              : 0;
          selectedBarLocation =
              viewData["bungalow_basement"]['bar_location'] != null
                  ? viewData["bungalow_basement"]['bar_location'].toString()
                  : '';
          if (barFaci != null) {
            if (barFaci.asMap().containsKey(0)) {
              if (barFaci[0] == '1') barFacility1 = true;
            }
            if (barFaci.asMap().containsKey(1)) {
              if (barFaci[1] == '2') barFacility2 = true;
            }
          }

          swimmingRequirement =
              viewData["bungalow_basement"]['swimming_pool_req'] == 1
                  ? true
                  : false;

          swimmingPoolLengthController =
              viewData["bungalow_basement"]['swimming_pool_length'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['swimming_pool_length']
                      .toString())
                  : 0;
          swimmingPoolWidthController =
              viewData["bungalow_basement"]['swimming_pool_width'] != null
                  ? int.parse(viewData["bungalow_basement"]
                          ['swimming_pool_width']
                      .toString())
                  : 0;
          swimmingLocation =
              viewData["bungalow_basement"]['swimming_pool_location'] != null
                  ? viewData["bungalow_basement"]['swimming_pool_location']
                      .toString()
                  : '';
          swimmingPoolSpecificRequirement =
              viewData["bungalow_basement"]['swimming_pool_location'] != null
                  ? viewData["bungalow_basement"]['swimming_pool_location']
                      .toString()
                  : '';
          gymRequirement =
              viewData["bungalow_basement"]['gym_req'] == 1 ? true : false;

          gymLengthController =
              viewData["bungalow_basement"]['gym_length'] != null
                  ? int.parse(
                      viewData["bungalow_basement"]['gym_length'].toString())
                  : 0;
          gymWidthController = viewData["bungalow_basement"]['gym_width'] !=
                  null
              ? int.parse(viewData["bungalow_basement"]['gym_width'].toString())
              : 0;
          gymLocation = viewData["bungalow_basement"]['gym_location'] != null
              ? viewData["bungalow_basement"]['gym_location'].toString()
              : '';
          gymSpecificRequirement =
              viewData["bungalow_basement"]['gym_specific_req'] != null
                  ? viewData["bungalow_basement"]['gym_specific_req'].toString()
                  : '';
          spaRequirement =
              viewData["bungalow_basement"]['spa_req'] == 1 ? true : false;

          spaLengthController =
              viewData["bungalow_basement"]['spa_length'] != null
                  ? int.parse(
                      viewData["bungalow_basement"]['spa_length'].toString())
                  : 0;
          spaWidthController = viewData["bungalow_basement"]['spa_width'] !=
                  null
              ? int.parse(viewData["bungalow_basement"]['spa_width'].toString())
              : 0;
          spaLocation = viewData["bungalow_basement"]['spa_location'] != null
              ? viewData["bungalow_basement"]['spa_location'].toString()
              : '';
          spaSpecificReq =
              viewData["bungalow_basement"]['spa_specific_req'] != null
                  ? viewData["bungalow_basement"]['spa_specific_req'].toString()
                  : '';
          gardenRequirement =
              viewData["bungalow_basement"]['garden_req'] == 1 ? true : false;

          gardenLocation = viewData["bungalow_basement"]['garden_type'] != null
              ? viewData["bungalow_basement"]['garden_type'].toString()
              : '';
          gardenSpecificRequiremnt = viewData["bungalow_basement"]
                      ['garden_specific_req'] !=
                  null
              ? viewData["bungalow_basement"]['garden_specific_req'].toString()
              : '';
          print(barFaci);
        }
        print(viewData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // print(otherFacilities);

    return viewData == null
        ? Container(child: CircularProgressIndicator())
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                requirementText("Basement Detail"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: BasementRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            BasementRequirement = value;
                                            BasementNotRequire = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: BasementNotRequire,
                                      onChanged: (value) {
                                        setState(() {
                                          BasementNotRequire = value;
                                          BasementRequirement = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (BasementRequirement == true) ...[
                  Row(
                    children: [
                      requirementText("Basement"),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * .04,
                          width: width * 0.4,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: Text(slectedBasement),
                                // value:  slectedBasement,
                                items: basementList
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it, child: Text(it)))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      slectedBasement = it!;
                                    })),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("Stilt Details"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: StiltRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            StiltRequirement = value;
                                            StiltNotRequire = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: StiltNotRequire,
                                      onChanged: (value) {
                                        setState(() {
                                          StiltNotRequire = value;
                                          StiltRequirement = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (StiltRequirement == true) ...[
                  Row(
                    children: [
                      requirementText("Basement"),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * .04,
                          width: width * 0.4,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              hint: Text(slectedstilt),
                              items: stiltList
                                  .map((it) => DropdownMenuItem<String>(
                                      value: it, child: Text(it)))
                                  .toList(),
                              onChanged: (it) => setState(
                                () {
                                  slectedstilt = it!;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  requirementText("Amenities"),
                ],
                requirementText("office"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: officeRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            officeRequirement = value;
                                            officeNotRequire = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: officeNotRequire,
                                      onChanged: (value) {
                                        setState(() {
                                          officeNotRequire = value;
                                          officeRequirement = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (officeRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(
                              //   height, width, 0.04, 0.15,
                              //     "length", officeLengthController
                              //     ),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["office_length"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                            ["office_length"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      officeLengthController = int.parse(value);
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["office_length"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                            ["office_length"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      officeLengthController = int.parse(value);
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      // DropDown(width, height, listOfficeLocation,
                      //     selectedOfficeLocation, 0.6, .035),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.6,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: Text(selectedOfficeLocation),

                                //value: selectedOfficeLocation,

                                elevation: 16,
                                items: listOfficeLocation
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      selectedOfficeLocation = it!;
                                    })),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Other Requirement"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 5,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  // multiSelected();
                                  final List<String> result = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MultiSelect(items: otherItems);
                                      });

                                  if (result != null) {
                                    setState(
                                      () {
                                        otherFacilities = result;
                                      },
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text("Office Facility"),
                                ),
                              ),
                              Wrap(
                                children: otherFacilities
                                    .map((e) => Chip(
                                          label: Text(e),
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("other Requirements"),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,"Other requirement", officeSpecificReqController)
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData != null &&
                                    viewData["bungalow_basement"]
                                            ["office_specific_req"] !=
                                        null
                                ? viewData["bungalow_basement"]
                                    ["office_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Other requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              officeSpecificReqController = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("servant requirement"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: servantRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            servantRequirement = value;
                                            servantNotRequired = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: servantNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          servantNotRequired = value;
                                          servantRequirement = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (servantRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 30,
                        child: Row(
                          children: [
                            Material(
                              elevation: 5,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.15,
                                child: TextFormField(
                                  initialValue: viewData != null &&
                                          viewData["bungalow_basement"]
                                                  ["servent_quarter_length"] !=
                                              null
                                      ? viewData["bungalow_basement"]
                                          ["servent_quarter_length"]
                                      : '',
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                      hintText: "Length",
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    serventLengthController = int.parse(value);
                                  },
                                ),
                              ),
                            ),
                            valueContainer(height, width, size, 0.04, 0.05),
                          ],
                        ),
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "Width", serventWidthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["servent_quarter_width"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                            ["servent_quarter_width"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "width",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      serventWidthController = int.parse(value);
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.6,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: Text(serventLocation),
                                // value: serventLocation,
                                elevation: 16,
                                items: serventItems
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      serventLocation = it!;
                                    })),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("No Of Servent"),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.2,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: Text(selectedServent),
                                // value: selectedServent,
                                elevation: 16,
                                items: noOfServents
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      selectedServent = it!;
                                    })),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Facilities"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Checkbox(
                        activeColor: checkColor,
                        checkColor: Colors.white,
                        value: serventFacility1,
                        onChanged: (value) => setState(
                          () {
                            serventFacility1 = value;
                          },
                        ),
                      ),
                      requirementText("One room + small kit + toilet")
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.14,
                      ),
                      SizedBox(
                        height: 20,
                        child: Checkbox(
                          activeColor: checkColor,
                          checkColor: Colors.white,
                          value: serventFacility2,
                          onChanged: (value) => setState(
                            () {
                              serventFacility2 = value;
                            },
                          ),
                        ),
                      ),
                      requirementText("One room + small kit + common toilet")
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Other Facilities"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,
                      //     "Other Requirement", serventSpecificController)

                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: viewData != null &&
                                    viewData["bungalow_basement"]
                                            ["servent_quarter_width"] !=
                                        null
                                ? viewData["bungalow_basement"]
                                    ["servent_quarter_width"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "width",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              serventWidthController = int.parse(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("Home Theater"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: HomeTheaterRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            HomeTheaterRequirement = value;
                                            HomeTheaterNotRequired = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: HomeTheaterNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          HomeTheaterNotRequired = value;
                                          HomeTheaterRequirement = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (HomeTheaterRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "length", homeTheaterLengthController),

                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["home_theater_length"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                            ["home_theater_length"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      homeTheaterLengthController =
                                          int.parse(value);
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "Width", homeTheaterWidthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["home_theater_width"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                            ["home_theater_width"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "width",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      homeTheaterWidthController =
                                          int.parse(value);
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("floor"),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.6,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: Text(homeTheaterFloor),
                                // value: homeTheaterFloor,
                                elevation: 16,
                                items: homeTheaterFloorItems
                                    .map(
                                      (it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      homeTheaterFloor = it!;
                                    })),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      requirementText("Seats"),
                      // DropDown(
                      //   width,
                      //   height,
                      //   seatsItems,
                      //   selectedSeats,
                      //   0.2,
                      //   0.03,
                      // ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.2,
                          margin: const EdgeInsets.all(3),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward),
                              ),
                              hint: Text(selectedSeats),
                              // value: selectedSeats,
                              elevation: 16,
                              items: seatsItems
                                  .map(
                                    (it) => DropdownMenuItem<String>(
                                      value: it,
                                      child: Text(
                                        it,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (it) => setState(
                                () {
                                  selectedSeats = it!;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (selectedSeats == "more") ...[
                        requirementTextField(height, width, 0.04, 0.2, "more")
                      ],
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requiremnt"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData != null &&
                                    viewData["bungalow_basement"]
                                            ["home_theater_specific_req"] !=
                                        null
                                ? viewData["bungalow_basement"]
                                    ["home_theater_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special Requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              homeTheaterSpecificController = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("Additional Parking Garage"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: AdditionalRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            AdditionalRequirement = value;
                                            AdditionalNotRequired = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                    activeColor: checkColor,
                                    checkColor: Colors.white,
                                    value: AdditionalNotRequired,
                                    onChanged: (value) {
                                      setState(() {
                                        AdditionalNotRequired = value;
                                        AdditionalRequirement = false;
                                      });
                                    },
                                  ),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (AdditionalRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 30,
                        child: Row(
                          children: [
                            // requirementTextFieldCont(height, width, 0.04,
                            // 0.15, "length", additionalParkingLength),
                            Material(
                              elevation: 5,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.15,
                                child: TextFormField(
                                  initialValue: viewData != null &&
                                          viewData["bungalow_basement"]
                                                  ["parking_garage_length"] !=
                                              null
                                      ? viewData["bungalow_basement"]
                                          ["parking_garage_length"]
                                      : '',
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                      hintText: "Length",
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    additionalParkingLength =
                                        int.parse(value.toString());
                                  },
                                ),
                              ),
                            ),
                            valueContainer(height, width, size, 0.04, 0.05),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 15,
                        child: requirementText("Width"),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 30,
                        child: Row(
                          children: [
                            // requirementTextFieldCont(height, width, 0.04,
                            //     0.15, "Width", additionalParkingWidth),
                            Material(
                              elevation: 5,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.15,
                                child: TextFormField(
                                  initialValue: viewData != null &&
                                          viewData["bungalow_basement"]
                                                  ["parking_garage_width"] !=
                                              null
                                      ? viewData["bungalow_basement"]
                                          ["parking_garage_width"]
                                      : '',
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                      hintText: "width",
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    additionalParkingWidth =
                                        int.parse(value.toString());
                                  },
                                ),
                              ),
                            ),
                            valueContainer(height, width, size, 0.04, 0.05),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Cars"),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      // requirementTextFieldCont(height, width, .04, .5,
                      //     "no. of cars", additionalCarsController)
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData != null &&
                                    viewData["bungalow_basement"]
                                            ["no_of_cars"] !=
                                        null
                                ? viewData["bungalow_basement"]["no_of_cars"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "no. of cars",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              additionalCarsController =
                                  int.parse(value.toString());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("location"),
                      // DropDown(
                      //   width,
                      //   height,
                      //   parkingLocation,
                      //   selectedParkingLocation,
                      //   0.5,
                      //   0.03,
                      // ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              // value: selectedParkingLocation,
                              elevation: 16,
                              hint: Text(selectedParkingLocation),
                              items: parkingLocation
                                  .map((it) => DropdownMenuItem<String>(
                                      value: it,
                                      child: Text(
                                        it,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (it) => setState(
                                () {
                                  selectedParkingLocation = it!;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("seprated Shade"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,
                      //     "Special Requirement", sepratedShadeController),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData != null &&
                                    viewData["bungalow_basement"]
                                            ["saperate_shade"] !=
                                        null
                                ? viewData["bungalow_basement"]
                                    ["saperate_shade"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special Requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              sepratedShadeController = value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requiremnt"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData != null &&
                                    viewData["bungalow_basement"]
                                            ["parking_garage_specific_req"] !=
                                        null
                                ? viewData["bungalow_basement"]
                                    ["parking_garage_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special Requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              additionalParkingSpecificController =
                                  value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("Indoor play area"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: indoorRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            indoorRequirement = value;
                                            indoorNotRequired = false;
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: indoorNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          indoorNotRequired = value;
                                          indoorRequirement = false;
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                if (indoorRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "length", indoorPlayLengthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["indoor_play_length"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                            ["indoor_play_length"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      indoorPlayLengthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,0.15, "Width", indoorPlayWidtController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData != null &&
                                            viewData["bungalow_basement"]
                                                    ["indoor_play_width"] !=
                                                null
                                        ? viewData["bungalow_basement"]
                                                ["indoor_play_width"]
                                            .toString()
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Width",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      indoorPlayWidtController = int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward),
                                ),
                                hint: Text(selectedIndoorLocation),
                                // value: selectedIndoorLocation,
                                elevation: 16,
                                items: itemsIndoorLocation
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      selectedIndoorLocation = it!;
                                    })),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requirement"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,
                      //     "Special Requirement", indoorPlaySpecificRequirement)
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue : viewData != null && viewData["bungalow_basement"]
                                        ["indoor_play_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["indoor_play_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special Requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              indoorPlaySpecificRequirement = value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("Bar"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value:
                                          viewData['bungalow_basement'] != null
                                              ? viewData['bungalow_basement']
                                                          ['bar_req'] ==
                                                      1
                                                  ? true
                                                  : barRequirement
                                              : barRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            barRequirement = value;
                                            barNotRequired = false;
                                            if (viewData['bungalow_basement'] !=
                                                null) {
                                              viewData['bungalow_basement']
                                                  ['bar_req'] = 3;
                                            }
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value:
                                          viewData['bungalow_basement'] != null
                                              ? viewData['bungalow_basement']
                                                          ['bar_req'] ==
                                                      0
                                                  ? true
                                                  : barNotRequired
                                              : barNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          barNotRequired = value;
                                          barRequirement = false;
                                          if (viewData['bungalow_basement'] !=
                                              null) {
                                            viewData['bungalow_basement']
                                                ['bar_req'] = 3;
                                          }
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (barRequirement == true || viewData != null
                    ? viewData['bungalow_basement']['bar_req'] == 1
                        ? true
                        : barRequirement == true
                    : barRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "length", barLengthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData["bungalow_basement"]
                                                ["bar_length"] !=
                                            null
                                        ? viewData["bungalow_basement"]
                                            ["bar_length"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      barLengthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "Width", barWidthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue:
                                        viewData["bungalow_basement"] != null
                                            ? viewData["bungalow_basement"]
                                                        ["bar_width"] !=
                                                    null
                                                ? viewData["bungalow_basement"]
                                                    ["bar_width"]
                                                : ''
                                            : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "width",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      barWidthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: viewData["bungalow_basement"] != null
                                    ? viewData["bungalow_basement"]
                                                ["bar_location"] !=
                                            null
                                        ? Text(viewData["bungalow_basement"]
                                            ["bar_location"])
                                        : Text(selectedBarLocation)
                                    : Text(selectedBarLocation),
                                // value: selectedBarLocation,
                                elevation: 16,
                                items: itemsBarLocation
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) =>
                                    setState(() => selectedBarLocation = it!)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  requirementText(
                    "Bar Facility",
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: height * 0.04,
                                    child: Checkbox(
                                        activeColor: checkColor,
                                        checkColor: Colors.white,
                                        value: barFaci != []
                                            ? barFaci[0] == '1'
                                                ? true
                                                : barFacility1
                                            : barFacility1,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              barFacility1 = value;

                                              if (barFaci != []) {
                                                barFaci[0] = '3';
                                              }
                                            },
                                          );
                                        }),
                                  ),
                                  requirementText("With bar room")
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(5),
                            elevation: 5,
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: height * 0.04,
                                    child: Checkbox(
                                        activeColor: checkColor,
                                        checkColor: Colors.white,
                                        value: barFaci != []
                                            ? barFaci[1] == '2'
                                                ? true
                                                : barFacility2
                                            : barFacility2,
                                        onChanged: (value) {
                                          setState(() {
                                            barFacility2 = value;
                                            if (barFaci != null) {
                                              barFaci[1] = '3';
                                            }
                                          });
                                        }),
                                  ),
                                  requirementText("With bar counter and lobby"),
                                  SizedBox(
                                    height: height * 0.01,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requirement"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,
                      // "Special requirement", barSpecificRequiremrnt),
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData["bungalow_basement"]
                                        ["bar_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["bar_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special Requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              barSpecificRequiremrnt =
                                  int.parse(value.toString());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
                requirementText("Swimming pool"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["swimming_pool_req"] ==
                                                  1
                                              ? true
                                              : swimmingRequirement
                                          : swimmingRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            swimmingRequirement = value;
                                            swimmingNotRequired = false;
                                            if (viewData != null
                                                ? viewData['bungalow_basement']
                                                        ["swimming_pool_req"] !=
                                                    null
                                                : false) {
                                              viewData['bungalow_basement']
                                                  ['swimming_pool_req'] = 3;
                                            }
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["swimming_pool_req"] ==
                                                  0
                                              ? true
                                              : swimmingNotRequired
                                          : swimmingNotRequired,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            swimmingNotRequired = value;
                                            swimmingRequirement = false;
                                            if (viewData != null
                                                ? viewData['bungalow_basement']
                                                        ["swimming_pool_req"] !=
                                                    null
                                                : false) {
                                              viewData['bungalow_basement']
                                                  ['swimming_pool_req'] = 3;
                                            }
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                if (swimmingRequirement == true || viewData != null
                    ? viewData['bungalow_basement']["swimming_pool_req"] == 1
                        ? true
                        : swimmingRequirement == true
                    : swimmingRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 30,
                        child: Row(
                          children: [
                            // requirementTextFieldCont(height, width, 0.04,
                            //     0.15, "length", swimmingPoolLengthController),
                            Material(
                              elevation: 5,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.15,
                                child: TextFormField(
                                  initialValue: viewData["bungalow_basement"]
                                              ["swimming_pool_length"] !=
                                          null
                                      ? viewData["bungalow_basement"]
                                          ["swimming_pool_length"]
                                      : '',
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                      hintText: "Length",
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    swimmingPoolLengthController =
                                        int.parse(value.toString());
                                  },
                                ),
                              ),
                            ),
                            valueContainer(height, width, size, 0.04, 0.05),
                          ],
                        ),
                      ),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "Width", swimmingPoolWidthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData["bungalow_basement"]
                                                ["swimming_pool_width"] !=
                                            null
                                        ? viewData["bungalow_basement"]
                                            ["swimming_pool_width"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Width",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      swimmingPoolWidthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              hint: viewData != null
                                  ? viewData["bungalow_basement"]
                                              ["swimming_pool_location"] !=
                                          null
                                      ? Text(viewData["bungalow_basement"]
                                          ["swimming_pool_location"])
                                      : Text(swimmingLocation)
                                  : Text(swimmingLocation),
                              elevation: 16,
                              items: itemsSwimmingLocation
                                  .map((it) => DropdownMenuItem<String>(
                                      value: it,
                                      child: Text(
                                        it,
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (it) => setState(
                                () {
                                  swimmingLocation = it!;
                                  if (viewData != null
                                      ? viewData["bungalow_basement"]
                                                  ["swimming_pool_location"] !=
                                              null
                                          ? true
                                          : false
                                      : false) {
                                    viewData["bungalow_basement"]
                                            ["swimming_pool_location"] =
                                        swimmingLocation;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requirement"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(
                      //     height,
                      //     width,
                      //     0.04,
                      //     0.5,
                      //     "Special Requirement",
                      //     swimmingPoolSpecificRequirement);

                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: viewData["bungalow_basement"]
                                        ["swimming_pool_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["swimming_pool_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special Requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              swimmingPoolSpecificRequirement = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
                requirementText("Gym"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["gym_req"] ==
                                                  1
                                              ? true
                                              : gymRequirement
                                          : gymRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            gymRequirement = value;
                                            gymNotRequired = false;
                                            if (viewData != null
                                                ? viewData['bungalow_basement']
                                                        ["gym_req"] !=
                                                    null
                                                : false) {
                                              viewData['bungalow_basement']
                                                  ['gym_req'] = 3;
                                            }
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                    activeColor: checkColor,
                                    checkColor: Colors.white,
                                    value: viewData != null
                                        ? viewData['bungalow_basement']
                                                    ["gym_req"] ==
                                                0
                                            ? true
                                            : gymNotRequired
                                        : gymNotRequired,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          gymNotRequired = value;
                                          gymRequirement = false;
                                          if (viewData != null
                                              ? viewData['bungalow_basement']
                                                      ["gym_req"] !=
                                                  null
                                              : false) {
                                            viewData['bungalow_basement']
                                                ['gym_req'] = 3;
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                if (gymRequirement == true || viewData != null
                    ? viewData["bungalow_basement"]['gym_req'] == 1
                        ? true
                        : gymRequirement == true
                    : gymRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "length", gymLengthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData["bungalow_basement"]
                                                ["gym_length"] !=
                                            null
                                        ? viewData["bungalow_basement"]
                                            ["gym_length"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      gymLengthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 30,
                        child: Row(
                          children: [
                            // requirementTextFieldCont(height, width, 0.04,
                            //     0.15, "Width", gymWidthController),
                            Material(
                              elevation: 5,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: SizedBox(
                                height: height * 0.04,
                                width: width * 0.15,
                                child: TextFormField(
                                  initialValue: viewData["bungalow_basement"]
                                              ["gym_width"] !=
                                          null
                                      ? viewData["bungalow_basement"]
                                          ["gym_width"]
                                      : '',
                                  style: const TextStyle(fontSize: 14),
                                  decoration: const InputDecoration(
                                      hintText: "Width",
                                      hintStyle: TextStyle(fontSize: 14),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8)),
                                  onChanged: (value) {
                                    gymWidthController =
                                        int.parse(value.toString());
                                  },
                                ),
                              ),
                            ),
                            valueContainer(height, width, size, 0.04, 0.05),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                                padding: EdgeInsets.all(5),
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.help,
                                  size: height * 0.03,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: viewData != null
                                    ? viewData["bungalow_basement"]
                                                ["gym_location"] !=
                                            null
                                        ? Text(viewData["bungalow_basement"]
                                            ["gym_location"])
                                        : Text(gymLocation)
                                    : Text(gymLocation),
                                elevation: 16,
                                items: itemsGymLocation
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      gymLocation = it!;
                                      if (viewData != null
                                          ? viewData["bungalow_basement"]
                                                  ["gym_location"] !=
                                              null
                                          : false) {
                                        viewData["bungalow_basement"]
                                            ["gym_location"] = gymLocation;
                                      }
                                    })),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requirement"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,
                      //     "Special Requirement ", gymSpecificRequirement)
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.15,
                          child: TextFormField(
                            initialValue: viewData["bungalow_basement"]
                                        ["gym_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["gym_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Length",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              swimmingPoolLengthController =
                                  int.parse(value.toString());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("spa"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["spa_req"] ==
                                                  1
                                              ? true
                                              : spaRequirement
                                          : spaRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            spaRequirement = value;
                                            spaNotRequired = false;
                                            if (viewData != null
                                                ? viewData['bungalow_basement']
                                                        ["spa_req"] !=
                                                    null
                                                : false) {
                                              viewData['bungalow_basement']
                                                  ['spa_req'] = 3;
                                            }
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["spa_req"] ==
                                                  0
                                              ? true
                                              : spaNotRequired
                                          : spaNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          spaNotRequired = value;
                                          spaRequirement = false;
                                          if (viewData != null
                                              ? viewData['bungalow_basement']
                                                      ["spa_req"] !=
                                                  null
                                              : false) {
                                            viewData['bungalow_basement']
                                                ['spa_req'] = 3;
                                          }
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                if (spaRequirement == true || viewData != null
                    ? viewData["bungalow_basement"]["spa_req"] == 1
                        ? true
                        : spaRequirement == true
                    : spaRequirement == true) ...[
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Length")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "length", spaLengthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData["bungalow_basement"]
                                                ["home_theater_specific_req"] !=
                                            null
                                        ? viewData["bungalow_basement"]
                                            ["home_theater_specific_req"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Length",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      spaLengthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 15,
                          child: requirementText("Width")),
                      Flexible(
                          fit: FlexFit.tight,
                          flex: 30,
                          child: Row(
                            children: [
                              // requirementTextFieldCont(height, width, 0.04,
                              //     0.15, "Width", spaWidthController),
                              Material(
                                elevation: 5,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  height: height * 0.04,
                                  width: width * 0.15,
                                  child: TextFormField(
                                    initialValue: viewData["bungalow_basement"]
                                                ["home_theater_specific_req"] !=
                                            null
                                        ? viewData["bungalow_basement"]
                                            ["home_theater_specific_req"]
                                        : '',
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                        hintText: "Width",
                                        hintStyle: TextStyle(fontSize: 14),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(8)),
                                    onChanged: (value) {
                                      spaWidthController =
                                          int.parse(value.toString());
                                    },
                                  ),
                                ),
                              ),
                              valueContainer(height, width, size, 0.04, 0.05),
                            ],
                          )),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 20,
                        child: Row(
                          children: [
                            requirementText("help"),
                            IconButton(
                              padding: EdgeInsets.all(5),
                              constraints: BoxConstraints(),
                              onPressed: () {},
                              icon: Icon(
                                Icons.help,
                                size: height * 0.03,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Location"),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: viewData != null
                                    ? viewData["bungalow_basement"]
                                                ["spa_location"] !=
                                            null
                                        ? Text(viewData["bungalow_basement"]
                                            ["spa_location"])
                                        : Text(spaLocation)
                                    : Text(spaLocation),
                                elevation: 16,
                                items: itemsSpaLocation
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      spaLocation = it!;
                                      if (viewData != null
                                          ? viewData["bungalow_basement"]
                                                  ["spa_location"] !=
                                              null
                                          : false) {
                                        viewData["bungalow_basement"]
                                            ["spa_location"] = spaLocation;
                                      }
                                    })),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText("Special Requirement"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, 0.04, 0.5,
                      //     "Special Requirement", spaSpecificReq)
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData["bungalow_basement"]
                                        ["spa_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["spa_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Length",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              spaLengthController = int.parse(value.toString());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                requirementText("Garden"),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["garden_req"] ==
                                                  1
                                              ? true
                                              : gardenRequirement
                                          : gardenRequirement,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            gardenRequirement = value;
                                            gardenNotRequired = false;
                                            if (viewData != null
                                                ? viewData['bungalow_basement']
                                                        ["garden_req"] !=
                                                    null
                                                : false) {
                                              viewData['bungalow_basement']
                                                  ['garden_req'] = 3;
                                            }
                                          },
                                        );
                                      }),
                                ),
                                requirementText("Required")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                  child: Checkbox(
                                      activeColor: checkColor,
                                      checkColor: Colors.white,
                                      value: viewData != null
                                          ? viewData['bungalow_basement']
                                                      ["garden_req"] ==
                                                  0
                                              ? true
                                              : gardenNotRequired
                                          : gardenNotRequired,
                                      onChanged: (value) {
                                        setState(() {
                                          gardenNotRequired = value;
                                          gardenRequirement = false;
                                          if (viewData != null
                                              ? viewData['bungalow_basement']
                                                      ["garden_req"] !=
                                                  null
                                              : false) {
                                            viewData['bungalow_basement']
                                                ['garden_req'] = 3;
                                          }
                                        });
                                      }),
                                ),
                                requirementText("Not Required"),
                                SizedBox(
                                  height: height * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if (gardenRequirement == true || viewData != null
                    ? viewData['bungalow_basement']["garden_req"] == 1
                        ? true
                        : gardenRequirement == true
                    : gardenRequirement == true) ...[
                  Row(
                    children: [
                      requirementText("Garden Type"),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: height * 0.03,
                          width: width * 0.5,
                          margin: const EdgeInsets.all(
                            3,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                hint: viewData != null
                                    ? viewData["bungalow_basement"]
                                                ["garden_type"] !=
                                            null
                                        ? Text(viewData["bungalow_basement"]
                                            ["garden_type"])
                                        : Text(gardenLocation)
                                    : Text(gardenLocation),
                                // value: gardenLocation,
                                elevation: 16,
                                items: gardenItems
                                    .map((it) => DropdownMenuItem<String>(
                                        value: it,
                                        child: Text(
                                          it,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        )))
                                    .toList(),
                                onChanged: (it) => setState(() {
                                      gardenLocation = it!;
                                      if (viewData != null
                                          ? viewData["bungalow_basement"]
                                                  ["garden_type"] !=
                                              null
                                          : false) {
                                        viewData["bungalow_basement"]
                                            ["garden_type"] = gardenLocation;
                                      }
                                    })),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      requirementText('Special Requirement'),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      // requirementTextFieldCont(height, width, .04, .5,
                      //     "Special requirement", gardenSpecificRequiremnt)
                      Material(
                        elevation: 5,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: SizedBox(
                          height: height * 0.04,
                          width: width * 0.5,
                          child: TextFormField(
                            initialValue: viewData["bungalow_basement"]
                                        ["spa_specific_req"] !=
                                    null
                                ? viewData["bungalow_basement"]
                                    ["garden_specific_req"]
                                : '',
                            style: const TextStyle(fontSize: 14),
                            decoration: const InputDecoration(
                                hintText: "Special requirement",
                                hintStyle: TextStyle(fontSize: 14),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8)),
                            onChanged: (value) {
                              gardenSpecificRequiremnt = value.toString();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Material(
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      child: SizedBox(
                        width: width * 9,
                        height: height * 0.3,
                        child: FutureBuilder(
                          future: getRecent(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return CarouselSlider.builder(
                                itemCount: bunglowPageRecentList.length,
                                itemBuilder: (context, i, id) {
                                  return Container(
                                    height: height * 0.4,
                                    width: width * 0.9,
                                    child: Image.network(
                                      imageUrl +
                                          bunglowPageRecentList[i]["img_path"],
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  viewportFraction: 1,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (BasementRequirement == true) {
                          basementReqInt = 1;
                        }
                        if (StiltRequirement == true) {
                          stilitReqInt = 1;
                        }
                        if (officeRequirement == true) {
                          officeReqInt = 1;

                          for (int i = 0; i < otherFacilities.length; i++) {
                            if (otherFacilities[i] == 'Pantry') {
                              officeFacility.add('1');
                            }
                            if (otherFacilities[i] == 'Staff Toilet') {
                              officeFacility.add('2');
                            }
                            if (otherFacilities[i] == 'Toilet') {
                              officeFacility.add('3');
                            }
                          }
                        }
                        if (spaRequirement == true) {
                          spaRequiredInt = 1;
                          int area = spaLengthController * spaWidthController;
                          spArea = area.toString();
                        }
                        if (gymRequirement == true) {
                          gymReqInt = 1;
                        }
                        if (swimmingRequirement == true) {
                          swimmingReqInt = 1;
                        }
                        if (barRequirement == true) {
                          barReqInt = 1;

                          if (barFacility1 == true) {
                            barFacility.add(1);
                          }
                          if (barFacility2 == true) {
                            barFacility.add(2);
                          }
                        }
                        if (indoorRequirement == true) {
                          indoorReqInt = 1;
                        }
                        if (HomeTheaterRequirement == true) {
                          homeReqInt = 1;
                        }
                        if (servantRequirement == true) {
                          servantReqInt = 1;
                          noServents = 1;
                          if (serventFacility1 == true) {
                            serventFacility.add(1);
                          }
                          if (serventFacility2 == true) {
                            serventFacility.add(2);
                          }
                        }
                        if (AdditionalRequirement == true) {
                          additionalReqInt = 1;
                        }
                        // print(
                        //     "indoor play width controller ${indoorPlayWidtController}");
                        // print(
                        //     "bar  specific requirement ${barSpecificRequiremrnt}");
                        // print("bar  width requirement ${barWidthController}");
                        // print("bar  length controler ${barLengthController}");
                      });

                      if (pageId != null) {
                        print("value is updating");
                        BasementPut(
                          179,
                          BasementRequirement!,
                          slectedBasement,
                          stilitReqInt,
                          slectedstilt,
                          officeRequirement!,
                          officeLengthController,
                          officeWidthController,
                          selectedOfficeLocation,
                          officeFacility,
                          officeSpecificReqController,
                          servantRequirement!,
                          serventLengthController,
                          serventWidthController,
                          serventSpecificController,
                          selectedServent,
                          serventFacility,
                          serventLocation,
                          serventSpecificController,
                          AdditionalRequirement!,
                          additionalParkingLength,
                          additionalParkingWidth,
                          additionalCarsController,
                          selectedParkingLocation,
                          sepratedShadeController,
                          additionalParkingSpecificController,
                          homeReqInt,
                          homeTheaterLengthController,
                          homeTheaterWidthController,
                          homeTheaterFloor,
                          selectedSeats,
                          homeTheaterSpecificController,
                          indoorRequirement!,
                          selectedIndoorLocation,
                          indoorPlayLengthController,
                          indoorPlayWidtController,
                          indoorPlaySpecificRequirement,
                          barReqInt,
                          selectedBarLocation,
                          barFacility,
                          barLengthController,
                          barWidthController,
                          barSpecificRequiremrnt,
                          swimmingReqInt,
                          swimmingLocation,
                          swimmingPoolLengthController,
                          swimmingPoolWidthController,
                          swimmingPoolSpecificRequirement,
                          gymRequirement!,
                          gymLocation,
                          gymLengthController,
                          gymWidthController,
                          gymSpecificRequirement,
                          spaRequiredInt,
                          spaLocation,
                          spaLengthController,
                          spaWidthController,
                          spaSpecificReq,
                          gardenRequirementInt,
                          gardenLocation,
                          gardenSpecificRequiremnt,
                        );
                      } else {
                        print("value is posting");

                        BasementPost(
                          123,
                          basementReqInt,
                          slectedBasement,
                          stilitReqInt,
                          slectedstilt,
                          officeReqInt,
                          officeLengthController,
                          officeWidthController,
                          selectedOfficeLocation,
                          officeFacility,
                          officeSpecificReqController,
                          servantReqInt,
                          serventLengthController,
                          serventWidthController,
                          serventSpecificController,
                          selectedServent,
                          serventFacility,
                          serventLocation,
                          serventSpecificController,
                          additionalReqInt,
                          additionalParkingLength,
                          additionalParkingWidth,
                          additionalCarsController,
                          selectedParkingLocation,
                          sepratedShadeController,
                          additionalParkingSpecificController,
                          homeReqInt,
                          homeTheaterLengthController,
                          homeTheaterWidthController,
                          homeTheaterFloor,
                          selectedSeats,
                          homeTheaterSpecificController,
                          indoorReqInt,
                          selectedIndoorLocation,
                          indoorPlayLengthController,
                          indoorPlayWidtController,
                          indoorPlaySpecificRequirement,
                          barReqInt,
                          selectedBarLocation,
                          barFacility,
                          barLengthController,
                          barWidthController,
                          barSpecificRequiremrnt,
                          swimmingReqInt,
                          swimmingLocation,
                          swimmingPoolLengthController,
                          swimmingPoolWidthController,
                          swimmingPoolSpecificRequirement,
                          gymReqInt,
                          gymLocation,
                          gymLengthController,
                          gymWidthController,
                          gymSpecificRequirement,
                          spaRequiredInt,
                          spaLocation,
                          spaLengthController,
                          spaWidthController,
                          spaSpecificReq,
                          gardenRequirementInt,
                          gardenLocation,
                          gardenSpecificRequiremnt,
                        );
                      }
                    },
                    child: Container(
                      height: height * 0.04,
                      decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: const Text(
                        "save and continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class MultiSelect extends StatefulWidget {
  List<String> items;

  MultiSelect({required this.items});
  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  List<String> selectedItems = [];

  void itemChanges(bool isSelected, String itemValue) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void cancel() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context, selectedItems);
  }

  void clear() {
    setState(() {
      selectedItems = [];
      Navigator.pop(context, selectedItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("office facility"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map(
                (item) => CheckboxListTile(
                  value: selectedItems.contains(item),
                  title: Text(item),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) => itemChanges(isChecked!, item),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text('clear all'),
          onPressed: clear,
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
          child: Text('Cancel'),
          onPressed: cancel,
        ),
        ElevatedButton(
          child: Text('Submit'),
          onPressed: submit,
        ),
      ],
    );
  }
}

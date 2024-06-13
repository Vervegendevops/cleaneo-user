import 'dart:convert';

import 'package:cleaneo_user/Dashboard/Address/deliveryInstructions_page.dart';
import 'package:cleaneo_user/Dashboard/Address/selectLocation.dart';
import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/main.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String Floor = '';
String Caddress = '';
String Type = '';
String HTReach = '';
List<dynamic> AddBook = [];

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController reachController = TextEditingController();
  final List<String> addresses = [
    "Home",
    "Work",
    "Other",
  ];
  _saveSelectedAddress(int index, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedAddressIndex', index);
    await prefs.setString('selectedAddress', address);
  }

  bool isfetched = false;
  Future<Object> fetchAddress() async {
    final url =
        'https://drycleaneo.com/CleaneoUser/api/showAddress/${UserData.read('ID')}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        AddBook = jsonDecode(response.body);
      });

      // print(AddBook[0]["Type"]); // Decode the response
    } else {
      // OTP = (1000 + Random().nextInt(9000)).toString();
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAddress();
  }

  String aselectedAddress = "Home";
  int selectedAddressIndex = -1;
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    var distance = 1.2;
    var address = "B-702, Sarthak the Sarjak, Bhaijipura Chokdi \n "
        "PDPU Crossroad , Beside Pulse Mall, Seventh \n "
        "Floor , Kudasan, Gujrat, India";
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawer(),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff006acb),
          ),
          child: Column(
            children: [
              SizedBox(height: mQuery.size.height * 0.034),
              Padding(
                padding: EdgeInsets.only(
                  top: mQuery.size.height * 0.058,
                  bottom: mQuery.size.height * 0.03,
                  left: mQuery.size.width * 0.045,
                  right: mQuery.size.width * 0.045,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: mQuery.size.height * 0.04,
                      ),
                    ),
                    SizedBox(
                      width: mQuery.size.width * 0.045,
                    ),
                    Text(
                      "My Addresses",
                      style: TextStyle(
                          fontSize: mQuery.size.height * 0.027,
                          color: Colors.white,
                          fontFamily: 'SatoshiBold'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return AddAddress();
                                },
                              ).then((value) => setState(() {
                                    fetchAddress();
                                  }));
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: mQuery.size.width * 0.045,
                                  height: mQuery.size.height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Color(0xff29b2fe),
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: mQuery.size.width * 0.04,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: mQuery.size.width * 0.02,
                                ),
                                Text(
                                  "Add Address",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.0195,
                                      fontFamily: 'SatoshiBold'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: ListView.builder(
                                  itemCount: AddBook.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 0.2,
                                                blurRadius: 7,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.055,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xff29b2fe),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.home,
                                                        color: Colors.white,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.032),
                                                  Text(
                                                    AddBook[index]["Type"] !=
                                                            null
                                                        ? AddBook[index]["Type"]
                                                        : '',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0185,
                                                      fontFamily: 'SatoshiBold',
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.028),
                                                  Icon(Icons.edit,
                                                      color: Colors.black54),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.028),
                                                  Icon(Icons.delete,
                                                      color: Colors.black54),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${AddBook[index]["Floor"] != null ? AddBook[index]["Floor"] : ''},',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      color: Colors.black54,
                                                      fontFamily:
                                                          'SatoshiRegular',
                                                    ),
                                                  ),
                                                  Text(
                                                    '${AddBook[index]["Caddress"] != null ? AddBook[index]["Caddress"] : ''},',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      color: Colors.black54,
                                                      fontFamily:
                                                          'SatoshiRegular',
                                                    ),
                                                  ),
                                                  Text(
                                                    'How to reach : ${AddBook[index]["HTReach"] != null ? AddBook[index]["HTReach"] : ''},',
                                                    style: TextStyle(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.015,
                                                      color: Colors.black54,
                                                      fontFamily:
                                                          'SatoshiRegular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.023),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.14),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return DeliveryInstructionPage();
                                                    }));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "View Delivery Instructions",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff29b2fe),
                                                          fontFamily:
                                                              'SatoshiBold',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.018,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                      Icon(
                                                        Icons.arrow_right,
                                                        color:
                                                            Color(0xff29b2fe),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: mQuery.size.height * 0.02,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController reachController = TextEditingController();
  Future<void> saveAddress() async {
    // Define the API endpoint
    String apiUrl = 'https://drycleaneo.com/CleaneoUser/api/AddAddress';
    print(Caddress);
    print(Floor);
    // Create the request body
    Map<String, String> requestBody = {
      'ID': UserData.read('ID').toString(),
      'Floor': Floor,
      'Caddress': Caddress,
      'Type': Type,
      'HTReach': HTReach,
      'Latitude': ALatitude,
      'Longitude': ALongitude
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Adress Saved succesfully');
        Navigator.pop(context);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //   return AddressPage();
        // }));
        // You can handle the response here if needed
      } else {
        // Handle error if the request was not successful
        print('Failed to sign up. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request
      print('Error signing up: $e');
    }
  }

  Future<Object> fetchAddress() async {
    final url =
        'https://drycleaneo.com/CleaneoUser/api/showAddress/CleaneoUser000012';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        AddBook = jsonDecode(response.body);
      });
      print(AddressBook); // Decode the response
    } else {
      // OTP = (1000 + Random().nextInt(9000)).toString();
    }
    return true;
  }

  final List<String> addresses = [
    "Home",
    "Work",
    "Other",
  ];

  _saveSelectedAddress(int index, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedAddressIndex', index);
    await prefs.setString('selectedAddress', address);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Caddress = '';
  }

  String aselectedAddress = "Home";
  int selectedAddressIndex = -1;
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mQuery.size.height * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mQuery.size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text("Enter Address Details",
                      style: TextStyle(
                        fontSize: mQuery.size.height * 0.022,
                        fontFamily: 'SatoshiBold',
                      )),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close))
                ],
              ),
            ),
            SizedBox(
              height: mQuery.size.height * 0.022,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mQuery.size.height * 0.022,
                  ),
                  Text(
                    "Complete address*",
                    style: TextStyle(
                        fontSize: mQuery.size.height * 0.0183,
                        fontFamily: 'SatoshiRegular',
                        color: Colors.black54),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchLocationScreen();
                        })).then((value) => setState(() {
                              Caddress = Caddress;
                            }));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/check-mark.png",
                            width: 16,
                          ),
                          SizedBox(
                            width: mQuery.size.width * 0.02,
                          ),
                          Container(
                            width: 250,
                            child: TextField(
                              enabled: false,
                              controller: addressController,
                              onSubmitted: (value) {
                                setState(() {
                                  Caddress = value;
                                });
                              },
                              style: TextStyle(fontFamily: 'SatoshiMedium'),
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: Caddress == ''
                                    ? 'Enter your address'
                                    : Caddress,
                                focusColor: Colors.grey,
                                border: InputBorder.none,
                                hintMaxLines: 1,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  Caddress = value;
                                });
                              },
                            ),
                          ),
                          // 66666666

                          // Text(
                          //   "CHANGE",
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontFamily:
                          //         'SatoshiMedium',
                          //     fontSize:
                          //         mQuery.size.height *
                          //             0.0173,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    "Floor (Optional)",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0183,
                      color: Colors.black54,
                      fontFamily: 'SatoshiRegular',
                    ),
                  ),
                  TextField(
                    controller: floorController,
                    onSubmitted: (value) {
                      setState(() {
                        Floor = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        Floor = value;
                      });
                    },
                    style: TextStyle(fontFamily: 'SatoshiMedium'),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      focusColor: Colors.grey,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: mQuery.size.height * 0.02,
                  ),
                  Text(
                    "How to reach (Optional)",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0183,
                      color: Colors.black54,
                      fontFamily: 'SatoshiRegular',
                    ),
                  ),
                  TextField(
                    controller: reachController,
                    onChanged: (value) {
                      setState(() {
                        HTReach = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        HTReach = value;
                      });
                    },
                    style: TextStyle(fontFamily: 'SatoshiMedium'),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: "Landmark/ Entry gate/ Street",
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'SatoshiRegular',
                        fontSize: mQuery.size.height * 0.0183,
                      ),
                      focusColor: Colors.grey,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    height: mQuery.size.height * 0.032,
                  ),
                  Text(
                    "Tag this location for later *",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0183,
                      color: Colors.black54,
                      fontFamily: 'SatoshiRegular',
                    ),
                  ),
                  SizedBox(
                    height: mQuery.size.height * 0.02,
                  ),
                  Row(children: [
                    for (int i = 0; i < addresses.length; i++)
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedAddressIndex = i;
                              aselectedAddress = addresses[i];
                              Type = aselectedAddress;
                              _saveSelectedAddress(i,
                                  addresses[i]); // Update the selected address
                            });
                          },
                          child: Container(
                            width: mQuery.size.width * 0.22,
                            height: mQuery.size.height * 0.045,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.2,
                                  blurRadius: 7,
                                  offset: Offset(0, 0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(6),
                              color: selectedAddressIndex == i
                                  ? Colors.cyan
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                addresses[i],
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.0195,
                                  color: selectedAddressIndex == i
                                      ? Colors.white
                                      : Colors.cyan,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ]),
                  SizedBox(
                    height: mQuery.size.height * 0.068,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return AddressPage();
                      // }));
                      saveAddress();
                      print(UserID);
                      print(Floor);
                      // Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: mQuery.size.height * 0.054,
                      decoration: BoxDecoration(
                          color: Color(0xff29b2fe),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Save Address",
                          style: TextStyle(
                              fontSize: mQuery.size.height * 0.022,
                              fontFamily: 'SatoshiBold',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

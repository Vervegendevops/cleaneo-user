import 'dart:async';
import 'dart:convert';
import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:cleaneo_user/Dashboard/testing/orderSubmission.dart';
import 'package:cleaneo_user/Dashboard/testing/orderSummary.dart';
import 'package:cleaneo_user/Dashboard/testing/quantity.dart';
import 'package:cleaneo_user/Dashboard/testing/weight.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/Onboarding%20page/login.dart';
import 'package:cleaneo_user/Payment/payment_page.dart';
import 'package:cleaneo_user/Payment/razorpay.dart';
import 'package:cleaneo_user/main.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cleaneo_user/Dashboard/Wash/Select%20Vendor/chooseVendor_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/byweight_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

int selectedServiceIndex = 0;
String selectedService = 'Wash';
List<String> serviceList = [
  "Wash",
  "Wash and Iron",
  "Dry Clean",
  "Wash and Steam",
  "Steam Iron",
  "Shoe and Bag Care"
];
List<String> serviceList2 = [];

class WashPage extends StatefulWidget {
  final String id;
  final String vendorAddress;
  WashPage({Key? key, required this.id, required this.vendorAddress});

  @override
  State<WashPage> createState() => _WashPageState();
}

int selectedContainerIndex = -1;

class _WashPageState extends State<WashPage> with TickerProviderStateMixin {
  Future<Object> fetchResponse(String phoneNumber) async {
    final url = 'https://drycleaneo.com/CleaneoUser/api/signedUp/$phoneNumber';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        userList = jsonDecode(response.body); // Decode the response
        print(userList);
        UserData.write('Wallet', userList['Wallet']);
        print(userList['Wallet']);

        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  TextEditingController searchController = TextEditingController();
  TextEditingController extranoteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController reachController = TextEditingController();
  int selectedAddressIndex = -1;
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

  List<int> kgValues = List.filled(13, 0);
  List<String> keysList = [];
  var caddress = "B-702, Sarthak the Sarjak";
  String aselectedAddress = "Home";
  String formattedToday = DateFormat('d MMMM').format(DateTime.now());
  String formattedTomorrow =
      DateFormat('d MMMM').format(DateTime.now().add(Duration(days: 1)));
  String formattedDayAfterTomorrow =
      DateFormat('d MMMM').format(DateTime.now().add(Duration(days: 2)));
  String DformattedToday =
      DateFormat('d MMMM').format(DateTime.now().add(Duration(days: 3)));
  String DformattedTomorrow =
      DateFormat('d MMMM').format(DateTime.now().add(Duration(days: 4)));
  String DformattedDayAfterTomorrow =
      DateFormat('d MMMM').format(DateTime.now().add(Duration(days: 5)));

  int length = 0;

  late TabController _tabController;
  bool _isDropdownOpen = false;
  late Timer _timer;
  bool isTrue = false;
  double totalKgValue = 0;
  void calculateTotalKgValue() {
    totalKgValue = kgValues.fold(0, (prev, curr) => prev + curr);
  }

  @override
  void initState() {
    super.initState();
    FinalTotalCost = 0;
    print("vendor address : ${widget.vendorAddress}");
    fetchResponse(UserData.read('phone'));
    _saveAddress(addressController.text);
    // updateC();
    CartItems = [];
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      // Your function logic goes here

      if (mounted) {
        setState(() {
          lengthOfCart = lengthOfCart;
          FinalTotalCost = FinalTotalCost;
          print('FinalTotalCost : $FinalTotalCost');
        });
      }
    });
    lengthOfCart = 0;
    fetchServices(widget.id);
    _tabController =
        TabController(length: selectedService == 'Wash' ? 2 : 1, vsync: this);
  }

  _saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('enteredAddress', address); // Save entered address
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
    _timer.cancel();
  }

  Map<String, dynamic> data = {};
  void fetchServices(String id) {
    // Make API call to fetch services based on id
    String apiUrl =
        'https://drycleaneo.com/CleaneoUser/api/service_details/$id';
    http.get(Uri.parse(apiUrl)).then((response) {
      if (response.statusCode == 200) {
        print("api calling");
        // Parse response and update services list
        setState(() {
          data = json.decode(response.body);
          // Initialize a list to store the names of keys
          isTrue = true;
          print(data);

          // Iterate over the keys starting from index 1
          data.forEach((key, value) {
            if (value != "[]" &&
                key != "ID" &&
                key != "created_at" &&
                key != "c_wash" &&
                key != "c_wash_iron" &&
                key != "c_dry_clean" &&
                key != "c_wash_steam" &&
                key != "c_steam_iron" &&
                key != "c_shoe_bag_care" &&
                key != "updated_at" &&
                key != "commission" &&
                key != "laundry_on_kg") {
              setState(() {
                if (key == 'wash') {
                  serviceList2.add('Wash');
                  keysList.add('Wash');
                } else if (key == 'wash_iron') {
                  serviceList2.add('Wash and Iron');
                  keysList.add('Wash and Iron');
                } else if (key == 'dry_clean') {
                  serviceList2.add('Dry Clean');
                  keysList.add('Dry Clean');
                } else if (key == 'wash_steam') {
                  serviceList2.add('Wash and Steam');
                  keysList.add('Wash and Steam');
                } else if (key == 'steam_iron') {
                  serviceList2.add('Steam Iron');
                  keysList.add('Steam Iron');
                } else if (key == 'shoe_bag_care') {
                  serviceList2.add('Shoe and Bag Care');
                  keysList.add('Shoe and Bag Care');
                }

                print(serviceList2);
              });
              length = keysList.length;
            }
          });

          // Now, keysList contains the names of keys with non-null values
          print(keysList);
          print(length);
        });
      } else {
        // Handle non-200 response status
        print('Request failed with status: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error fetching services: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return isTrue == false
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
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
                                Icon(Icons.arrow_back, color: Colors.white),
                                SizedBox(width: mQuery.size.width * 0.045),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isDropdownOpen = !_isDropdownOpen;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        serviceList2[selectedServiceIndex],
                                        style: TextStyle(
                                            fontSize:
                                                mQuery.size.height * 0.027,
                                            color: Colors.white,
                                            fontFamily: 'SatoshiBold'),
                                      ),
                                      SizedBox(
                                        width: mQuery.size.width * 0.02,
                                      ),
                                      Icon(Icons.arrow_drop_down,
                                          color: Colors.white),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            // height: MediaQuery.of(context).size.height * 0.7,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              tabs: [
                                Tab(text: "Quantity Wise"),
                                if (selectedService == 'Wash')
                                  Tab(text: "By Weight")
                              ],
                              labelColor: Color(0xff29b2fe),
                              indicatorColor: Color(0xff29b2fe),
                              labelStyle: TextStyle(
                                  fontSize: mQuery.size.height * 0.023,
                                  fontFamily: 'SatoshiBold'),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.65,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                quantityPage(
                                  TypeofData: selectedService,
                                  ID: widget.id,
                                  data: selectedService == 'Wash'
                                      ? data['c_wash']
                                      : selectedService == 'Wash and Iron'
                                          ? data['c_wash_iron']
                                          : selectedService == 'Dry Clean'
                                              ? data['c_dry_clean']
                                              : selectedService ==
                                                      'Wash and Steam'
                                                  ? data['c_wash_steam']
                                                  : selectedService ==
                                                          'Steam Iron'
                                                      ? data['c_steam_iron']
                                                      : selectedService ==
                                                              'Shoe and Bag Care'
                                                          ? data[
                                                              'c_shoe_bag_care']
                                                          : data[
                                                              'c_shoe_bag_care'],

                                  // Dry Clean
                                ),
                                if (selectedService == 'Wash') ByWeightPage()
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (FinalTotalCost >= 0 &&
                                  FinalTotalCost <= 349) {
                                Fluttertoast.showToast(
                                    msg: "Please add items worth ₹350");
                              } else {
                                _openBottomSheet(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                height: mQuery.size.height * 0.08,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    color: Color(0xff29b2fe),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: mQuery.size.height * 0.012,
                                        ),
                                        Text("${lengthOfCart} ITEMS",
                                            style: TextStyle(
                                              fontSize:
                                                  mQuery.size.height * 0.0195,
                                              color: Colors.white,
                                            )),
                                        Text("₹ $FinalTotalCost plus taxes",
                                            style: TextStyle(
                                                fontFamily: 'SatoshiMedium',
                                                fontSize:
                                                    mQuery.size.height * 0.0195,
                                                color: Colors.white))
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text("Proceed",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                mQuery.size.height * 0.024,
                                            fontFamily: 'SatoshiMedium')),
                                    SizedBox(
                                      width: mQuery.size.width * 0.02,
                                    ),
                                    Icon(
                                      Icons.arrow_right,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_isDropdownOpen)
                  Positioned(
                    top: mQuery.size.height * 0.14,
                    left: mQuery.size.height * 0.08,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDropdownOpen = false;
                        });
                      },
                      child: Container(
                        width: mQuery.size.width * 0.6,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0.2,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 0), // changes the position of the shadow
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: mQuery.size.height * 0.001,
                              ),
                              if (length == 1)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList2[i], i),
                              if (length == 2)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList2[i], i),
                              if (length == 3)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList2[i], i),
                              if (length == 4)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList2[i], i),
                              if (length == 5)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList2[i], i),
                              if (length == 6)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList2[i], i)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
  }

  Widget _buildDropdownRow(String text, int index) {
    var mQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedServiceIndex = index;
          selectedService = serviceList2[selectedServiceIndex];
          _isDropdownOpen = false;
          print(selectedServiceIndex);
          if (selectedService != "Wash") {
            _tabController = TabController(length: 1, vsync: this);
          } else {
            _tabController = TabController(length: 2, vsync: this);
          }
        });
        if (index == 2) {
          setState(() {});
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: mQuery.size.height * 0.008),
          child: Row(
            children: [
              Image.asset(
                index == 0
                    ? "assets/images/Wash & Iron.png"
                    : index == 1
                        ? "assets/images/Steam Iron.png"
                        : index == 2
                            ? "assets/images/Dry Clean.png"
                            : index == 3
                                ? "assets/images/Premium Wash.png"
                                : "assets/images/Shoe & Bag Care.png",
                width: index == 3 ? 28 : 24,
              ),
              SizedBox(width: mQuery.size.width * 0.01),
              Text(
                text,
                style: TextStyle(
                    fontSize: mQuery.size.height * 0.018,
                    fontFamily: 'SatoshiMedium'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    PickupDate = '';
    PickupTime = '';
    DeliveryDate = '';
    DeliveryTime = '';
    DateTime currentTime = DateTime.now();
    DateTime tenAM = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0);
    DateTime twoPM = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0);
    DateTime sixPM = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0);

    String totalSum = '₹ ${calculateTotal(prices).toStringAsFixed(2)}';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        List<String> dates = [
          formattedToday,
          formattedTomorrow,
          formattedDayAfterTomorrow
        ];
        List<String> dates3 = [];
        // dates3.add()
        List<String> times = ["10am - 12pm", "02pm - 04pm", "06pm - 08pm"];

        // List<String> dates2 = ["26 June", "28 June", "29 June"];
        List<String> dates2 = [
          DformattedToday,
          DformattedTomorrow,
          DformattedDayAfterTomorrow
        ];
        List<String> times2 = ["10am - 12pm", "02pm - 04pm", "06pm - 08pm"];

        int? selectedDateIndex; // Track the selected date index
        int? selectedTimeIndex;
        int? selectedDateIndex2; // Track the selected date index for delivery
        int? selectedTimeIndex2;

        bool showSecondDropdown =
            false; // Variable to control second dropdown visibility

        return StatefulBuilder(
          builder: (context, setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.8,
              minChildSize: 0.4,
              maxChildSize: 0.8,
              expand: false,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Schedule Your Order",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.022,
                              fontFamily: 'SatoshiBold',
                            ),
                          ),
                          Divider(),
                          Text(
                            "Pickup Slot",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.019,
                              fontFamily: 'SatoshiMedium',
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.016),
                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.21,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xfff8fcfe),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.2,
                                  blurRadius: 7,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: mQuery.size.height * 0.01),
                                Text(
                                  "SELECT PICKUP DATE",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.0173,
                                      fontFamily: 'SatoshiRegular',
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.008),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < dates.length; i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedDateIndex = i;
                                            PickupDate = dates[i];
                                            print(PickupDate);
                                          });
                                        },
                                        child: Container(
                                          width: mQuery.size.width * 0.2,
                                          height: mQuery.size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: selectedDateIndex == i
                                                  ? Color(0xff009c1a)
                                                  : Colors.grey,
                                            ),
                                            color: selectedDateIndex == i
                                                ? Color(0xff009c1a)
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              dates[i],
                                              style: TextStyle(
                                                fontFamily: 'SatoshiRegular',
                                                fontSize:
                                                    mQuery.size.height * 0.0172,
                                                color: selectedDateIndex == i
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: mQuery.size.height * 0.006),
                                Divider(),
                                SizedBox(height: mQuery.size.height * 0.006),
                                Text(
                                  "SELECT PICKUP TIME",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.0173,
                                      fontFamily: 'SatoshiRegular',
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.008),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < times.length; i++)
                                      GestureDetector(
                                        onTap: selectedDateIndex == 0
                                            ? (currentTime.isAfter(tenAM) &&
                                                    times[i] == "10am - 12pm"
                                                ? () {
                                                    setState() {
                                                      selectedTimeIndex = -1;
                                                    }
                                                  }
                                                : currentTime.isAfter(twoPM) &&
                                                        times[i] ==
                                                            "02pm - 04pm"
                                                    ? () {
                                                        setState() {
                                                          selectedTimeIndex =
                                                              -1;
                                                        }
                                                      }
                                                    : currentTime.isAfter(
                                                                sixPM) &&
                                                            times[i] ==
                                                                "06pm - 08pm"
                                                        ? () {
                                                            setState() {
                                                              selectedTimeIndex =
                                                                  -1;
                                                            }
                                                          }
                                                        : () {
                                                            setState(() {
                                                              selectedTimeIndex =
                                                                  i;
                                                              PickupTime =
                                                                  times[i];
                                                              print(PickupTime);
                                                            });
                                                          })
                                            : () {
                                                setState(() {
                                                  selectedTimeIndex = i;
                                                  PickupTime = times[i];
                                                  print(PickupTime);
                                                });
                                              },
                                        child: Container(
                                          width: mQuery.size.width * 0.25,
                                          height: mQuery.size.height * 0.04,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: selectedTimeIndex == i
                                                      ? Color(0xff009c1a)
                                                      : Colors.grey),
                                              color: selectedDateIndex == 0
                                                  ? (selectedTimeIndex == i
                                                      ? Color(0xff009c1a)
                                                      : currentTime.isAfter(tenAM) &&
                                                              times[i] ==
                                                                  "10am - 12pm"
                                                          ? const Color.fromARGB(
                                                              255, 210, 210, 210)
                                                          : currentTime.isAfter(
                                                                      twoPM) &&
                                                                  times[i] ==
                                                                      "02pm - 04pm"
                                                              ? const Color.fromARGB(
                                                                  255,
                                                                  210,
                                                                  210,
                                                                  210)
                                                              : currentTime.isAfter(sixPM) &&
                                                                      times[i] ==
                                                                          "06pm - 08pm"
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      210,
                                                                      210,
                                                                      210)
                                                                  : Colors.white)
                                                  : selectedTimeIndex == i
                                                      ? Color(0xff009c1a)
                                                      : Colors.white),
                                          child: Center(
                                            child: Text(
                                              times[i],
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.0156,
                                                  color: selectedTimeIndex == i
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.022),
                          Divider(),
                          SizedBox(height: mQuery.size.height * 0.006),
                          Text(
                            "Delivery Slot",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.019,
                              fontFamily: 'SatoshiMedium',
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.016),
                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.21,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xfff8fcfe),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.2,
                                  blurRadius: 7,
                                  offset: Offset(0,
                                      0), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: mQuery.size.height * 0.01),
                                Text(
                                  "SELECT DELIVERY DATE",
                                  style: TextStyle(
                                      fontFamily: 'SatoshiRegular',
                                      fontSize: mQuery.size.height * 0.0173,
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.008),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < dates2.length; i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedDateIndex2 = i;
                                            DeliveryDate = dates2[i];
                                            print(DeliveryDate);
                                          });
                                        },
                                        child: Container(
                                          width: mQuery.size.width * 0.2,
                                          height: mQuery.size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: selectedDateIndex2 == i
                                                  ? Color(0xff006acb)
                                                  : Colors.grey,
                                            ),
                                            color: selectedDateIndex2 == i
                                                ? Color(0xff006acb)
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              dates2[i],
                                              style: TextStyle(
                                                fontFamily: 'SatoshiRegular',
                                                fontSize:
                                                    mQuery.size.height * 0.0172,
                                                color: selectedDateIndex2 == i
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: mQuery.size.height * 0.006),
                                Divider(),
                                SizedBox(height: mQuery.size.height * 0.006),
                                Text(
                                  "SELECT DELIVERY TIME",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.0173,
                                      fontFamily: 'SatoshiRegular',
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.008),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < times2.length; i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTimeIndex2 = i;
                                            DeliveryTime = times2[i];
                                            print(DeliveryTime);
                                          });
                                        },
                                        child: Container(
                                          width: mQuery.size.width * 0.25,
                                          height: mQuery.size.height * 0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                              color: selectedTimeIndex2 == i
                                                  ? Color(0xff006acb)
                                                  : Colors.grey,
                                            ),
                                            color: selectedTimeIndex2 == i
                                                ? Color(0xff006acb)
                                                : Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              times2[i],
                                              style: TextStyle(
                                                fontFamily: 'SatoshiRegular',
                                                fontSize:
                                                    mQuery.size.height * 0.0156,
                                                color: selectedTimeIndex2 == i
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.01),
                          Divider(),
                          SizedBox(height: mQuery.size.height * 0.01),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Note: ",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'SatoshiMedium',
                                    fontSize: mQuery.size.height * 0.0185,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "Delivery of heavy and dry clean items may be delayed.",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'SatoshiRegular',
                                    fontSize: mQuery.size.height * 0.0165,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.02),
                          GestureDetector(
                            onTap: (PickupDate.isEmpty &&
                                    DeliveryDate.isEmpty &&
                                    PickupTime.isEmpty &&
                                    DeliveryTime.isEmpty)
                                ? () {
                                    print(PickupDate.isEmpty);
                                    print(PickupTime.isEmpty);
                                    print(DeliveryDate.isEmpty);
                                    print(DeliveryTime.isEmpty);
                                    Fluttertoast.showToast(
                                        msg:
                                            "Select Pickup and Delivery Slots.");
                                  }
                                : () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return OrderSummary(
                                          id: widget.id,
                                          vendorAddress: widget.vendorAddress);
                                    }));
                                  },
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: mQuery.size.height * 0.08,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: Color(0xff29b2fe),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: mQuery.size.height * 0.012,
                                          ),
                                          Text("${lengthOfCart} ITEMS",
                                              style: TextStyle(
                                                fontSize:
                                                    mQuery.size.height * 0.0195,
                                                color: Colors.white,
                                              )),
                                          Text("₹ $FinalTotalCost plus taxes",
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiMedium',
                                                  fontSize: mQuery.size.height *
                                                      0.0195,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text("Continue",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  mQuery.size.height * 0.024,
                                              fontFamily: 'SatoshiMedium')),
                                      SizedBox(
                                        width: mQuery.size.width * 0.02,
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mQuery.size.height * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Map<String, double> prices = {
    "Item Total": 1640,
    "Delivery Charges": 50,
    "Tax": 60,
  };
  Widget buildItemContainer(
      MediaQueryData mQuery,
      String type,
      String itemName,
      String itemPrice,
      int kgValue,
      Function() onRemovePressed,
      Function() onAddPressed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.02),
      width: double.infinity,
      height: mQuery.size.height * 0.07,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$itemName ($type)",
                style: TextStyle(
                  fontFamily: 'SatoshiMedium',
                  fontSize: mQuery.size.height * 0.017,
                ),
              ),
              Text(
                itemPrice,
                style: TextStyle(
                  fontSize: mQuery.size.height * 0.0155,
                  color: Colors.black54,
                  fontFamily: 'SatoshiRegular',
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          InkWell(
            onTap: onRemovePressed,
            child: Container(
              width: mQuery.size.width * 0.1,
              height: mQuery.size.height * 0.026,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: mQuery.size.width * 0.045,
                ),
              ),
            ),
          ),
          SizedBox(width: mQuery.size.width * 0.026),
          Container(
            width: 40,
            child: Center(
              child: Text(
                "$kgValue",
                style: TextStyle(
                    color: Color(0xff29b2fe),
                    fontFamily: 'SatoshiRegular',
                    fontSize: mQuery.size.height * 0.024),
              ),
            ),
          ),
          SizedBox(width: mQuery.size.width * 0.026),
          InkWell(
            onTap: onAddPressed,
            child: Container(
              width: mQuery.size.width * 0.1,
              height: mQuery.size.height * 0.026,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Icon(Icons.add, size: mQuery.size.width * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal(Map<String, double> prices) {
    double total = 0;
    prices.forEach((key, value) {
      total += value;
    });
    return total;
  }
}

class ContainerItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onTap;

  const ContainerItem({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: Offset(0, 0),
            ),
          ],
          color: isSelected ? Color(0xff29b2fe) : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontFamily: 'SatoshiMedium'),
        ),
      ),
    );
  }
}

class PaymentConfirmation extends StatefulWidget {
  String id;

  PaymentConfirmation({super.key, required this.id});

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  int isSelectedd = UserData.read('Wallet') == 0 ? 0 : 1;
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  Future<void> updateWallet() async {
    String userID = UserData.read('ID');
    String actualWallet = UserData.read('Wallet');
    int ActualWallet = int.parse(actualWallet);
    ActualWallet = ActualWallet - GrandTotalCostWithDelivery;
    // Define the API endpoint
    String apiUrl =
        'https://drycleaneo.com/CleaneoUser/api/updateWallet?userID=${userID}&amount=$ActualWallet';

    // Create the request body
    Map<String, String> requestBody = {
      'userID': userID,
      'amount': ActualWallet.toString(),
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);
    print(jsonBody);
    try {
      // Make the POST request
      http.Response response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print('Order created successful ${response.body}');
        transactionDetail();
        // createOrder();
      } else {
        print('Failed to Create Order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> transactionDetail() async {
    String userID = UserData.read('ID');
    print(userID);
    String amount = GrandTotalCostWithDelivery.toString();
    // Define the API endpoint
    String apiUrl = 'https://drycleaneo.com/CleaneoUser/api/transaction';

    // Create the request body
    Map<String, String> requestBody = {
      'UserID': userID,
      'PayID': 'debit',
      'Type': 'Wallet',
      'Amount': amount,
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);
    print(jsonBody);
    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        print(response.body);
        createOrder(response.body);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return OrderPlaced();
        // }));
      } else {
        print('Failed to Create Order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> transactionDetail2(String iddit) async {
    String userID = UserData.read('ID');
    print(userID);
    String amount = GrandTotalCostWithDelivery.toString();
    // Define the API endpoint
    String apiUrl = 'https://drycleaneo.com/CleaneoUser/api/transaction';

    // Create the request body
    Map<String, String> requestBody = {
      'UserID': userID,
      'PayID': iddit,
      'Type': 'Online',
      'Amount': amount,
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);
    print(jsonBody);
    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        print(response.body);
        createOrder(response.body);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return OrderPlaced();
        // }));
      } else {
        print('Failed to Create Order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  Future<void> createOrder(String idddd) async {
    String userID = UserData.read('ID');
    print(userID);
    // Define the API endpoint
    String apiUrl = 'https://drycleaneo.com/CleaneoUser/api/createOrder';

    // Create the request body
    Map<String, String> requestBody = {
      'userID': userID,
      'HTReach': AddBook[0]['HTReach'],
      'Floor': AddBook[0]['Floor'],
      'Caddress': AddBook[0]['Caddress'],
      'VendorId': '${widget.id}',
      'Items': jsonEncode(CartItems),
      'PickupDate': PickupDate,
      'PickupTime': PickupTime,
      'DeliveryDate': DeliveryDate,
      'DeliveryTime': DeliveryTime,
      'ExtraNote': ExtraNotes,
      'SupportYourRider': SupportRider,
      'DeliveryCharges': '${DeliveryCharge.toInt()}',
      'UserTotalCost': '$GrandTotalCostWithDelivery',
      'PaymentMode': idddd,
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);
    print(jsonBody);
    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );
      if (response.statusCode == 200) {
        print('Order created successful');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderPlaced();
        }));
      } else {
        print('Failed to Create Order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  void openPaymentPortal() async {
    int cost = FinalTotalCost * 100;
    var options = {
      'key': 'rzp_live_ciT70AxpLdSZ9B',
      // 'amount': cost,
      'amount': 200,
      'name': '${UserData.read('name')}',
      'description': 'Payment',
      'prefill': {
        'contact': '${UserData.read('phone')}',
        'email': '${UserData.read('email')}'
      },
      'external': {
        'wallets': ['paytm'],
      }
    };

    try {
      _razorpay?.open(options);
      print("Making payment");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.paymentId);
    print(response.data);

    String tt = response.paymentId.toString();
    transactionDetail2(tt);
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),

      // Customize your bottom sheet content here
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: isSelectedd == 1 ? Color(0xff29b2fe) : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              leading: Icon(
                Icons.wallet,
                color: isSelectedd == 1 ? Color(0xff29b2fe) : Colors.black,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cleaneo Wallet',
                    style: TextStyle(
                        color: isSelectedd == 1
                            ? Color(0xff29b2fe)
                            : Colors.black),
                  ),
                  Text(
                    'Balance : ${UserData.read('Wallet')}',
                    style: TextStyle(
                        color: isSelectedd == 1
                            ? Color(0xff29b2fe)
                            : Colors.black),
                  ),
                ],
              ),
              onTap: UserData.read('Wallet') == '0'
                  ? null
                  : () {
                      setState(() {
                        isSelectedd = 1;
                        paymentMode = 'Wallet';
                      });
                    },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: isSelectedd == 3 ? Color(0xff29b2fe) : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              leading: Icon(
                Icons.money,
                color: isSelectedd == 3 ? Color(0xff29b2fe) : Colors.black,
              ),
              title: Text(
                'Cash on Delivery',
                style: TextStyle(
                    color: isSelectedd == 3 ? Color(0xff29b2fe) : Colors.black),
              ),
              onTap: () {
                setState(() {
                  isSelectedd = 3;
                  paymentMode = 'Cash';
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: isSelectedd == 2 ? Color(0xff29b2fe) : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListTile(
              leading: Icon(
                Icons.payment,
                color: isSelectedd == 2 ? Color(0xff29b2fe) : Colors.black,
              ),
              title: Text(
                'Pay using UPI, Net Banking and Debit & Credit Cards',
                style: TextStyle(
                    color: isSelectedd == 2 ? Color(0xff29b2fe) : Colors.black),
              ),
              onTap: () {
                setState(() {
                  isSelectedd = 2;
                  paymentMode = 'Online';
                });
                // Navigate to the PaymentPage if needed
                // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()));
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            child: GestureDetector(
              onTap: () {
                if (isSelectedd == 1) {
                  if (int.parse(UserData.read('Wallet')) < GrandTotalCost) {
                    print('less balance');
                    Fluttertoast.showToast(
                        msg: "Insufficient Balance!", timeInSecForIosWeb: 4);
                  } else {
                    print('Order Created Successfully');
                    updateWallet();
                  }
                } else if (isSelectedd == 3) {
                  print('Vendor id : ${widget.id}');
                  // print('Vendor Address : ${widget.vendorAddress}');
                  print('Cart Items : ${jsonEncode(CartItems)}');
                  print('Pickup Date : $PickupDate');
                  print('Pickup Time : $PickupTime');
                  print('Delivery Date : $DeliveryDate');
                  print('Delivery Time : $DeliveryTime');
                  print(DeliveryCharge.toInt());
                  print('Extra note : $ExtraNotes');
                  print('Support your rider : $SupportRider');
                  print('Grand Total : $GrandTotalCostWithDelivery');

                  print(paymentMode);
                  createOrder('Cash');
                } else if (isSelectedd == 2) {
                  openPaymentPortal();
                }

                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return PaymentPage();
                // }));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Color(0xff29b2fe),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Continue Payment',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ] // Add more options as needed
            ),
      ),
    );
  }
}

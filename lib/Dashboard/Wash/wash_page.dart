import 'dart:async';
import 'dart:convert';
import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:cleaneo_user/Dashboard/testing/quantity.dart';
import 'package:cleaneo_user/Dashboard/testing/weight.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/Payment/payment_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:cleaneo_user/Dashboard/Wash/Select%20Vendor/chooseVendor_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/byweight_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/quantity_wise_page.dart';
import 'package:cleaneo_user/pages/dryclean_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class WashPage extends StatefulWidget {
  final String id;
  WashPage({Key? key, required this.id});

  @override
  State<WashPage> createState() => _WashPageState();
}

class _WashPageState extends State<WashPage> with TickerProviderStateMixin {
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

  int length = 0;
  int selectedContainerIndex = -1;
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
                key != "laundry_on_kg") {
              setState(() {
                keysList.add(key);
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
                                        serviceList[selectedServiceIndex],
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
                              _openBottomSheet(context);
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
                                  _buildDropdownRow(serviceList[i], i),
                              if (length == 2)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList[i], i),
                              if (length == 3)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList[i], i),
                              if (length == 4)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList[i], i),
                              if (length == 5)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList[i], i),
                              if (length == 6)
                                for (int i = 0; i < length; i++)
                                  _buildDropdownRow(serviceList[i], i)
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
          selectedService = serviceList[selectedServiceIndex];
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

        List<String> dates2 = ["26 June", "28 June", "29 June"];
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
                                        onTap: currentTime.isAfter(tenAM) &&
                                                times[i] == "10am - 12pm"
                                            ? null
                                            : currentTime.isAfter(twoPM) &&
                                                    times[i] == "02pm - 04pm"
                                                ? null
                                                : currentTime.isAfter(sixPM) &&
                                                        times[i] ==
                                                            "06pm - 08pm"
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          selectedTimeIndex = i;
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
                                              color: selectedTimeIndex == i
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
                                                              255, 210, 210, 210)
                                                          : currentTime.isAfter(
                                                                      sixPM) &&
                                                                  times[i] ==
                                                                      "06pm - 08pm"
                                                              ? const Color
                                                                  .fromARGB(255,
                                                                  210, 210, 210)
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
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Container(
                                        height: mQuery.size.height * 0.8,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16)),
                                            color: Colors.white),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height:
                                                    mQuery.size.height * 0.03,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Text(
                                                  "Order Summary",
                                                  style: TextStyle(
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.022,
                                                    fontFamily: 'SatoshiBold',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    mQuery.size.height * 0.02,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height:
                                                    mQuery.size.height * 0.12,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffebf7ed)),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Color(
                                                                0xff009c1a),
                                                          ),
                                                          child: Icon(
                                                            Icons.check,
                                                            color: Colors.white,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: mQuery
                                                                  .size.width *
                                                              0.032,
                                                        ),
                                                        Text(
                                                          "Pickup from ${aselectedAddress}",
                                                          style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0183,
                                                            fontFamily:
                                                                'SatoshiMedium',
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: SizedBox()),
                                                        TextButton(
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.7,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              16),
                                                                          topRight: Radius.circular(
                                                                              16)),
                                                                      color: Colors
                                                                          .white),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              mQuery.size.height * 0.03,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 16),
                                                                          child:
                                                                              Row(
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
                                                                          height:
                                                                              mQuery.size.height * 0.022,
                                                                        ),
                                                                        Divider(),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 16),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SizedBox(
                                                                                height: mQuery.size.height * 0.022,
                                                                              ),
                                                                              Text(
                                                                                "Complete address*",
                                                                                style: TextStyle(fontSize: mQuery.size.height * 0.0183, fontFamily: 'SatoshiRegular', color: Colors.black54),
                                                                              ),
                                                                              SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
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
                                                                                        controller: addressController,
                                                                                        style: TextStyle(fontFamily: 'SatoshiMedium'),
                                                                                        cursorColor: Colors.grey,
                                                                                        decoration: InputDecoration(
                                                                                          focusColor: Colors.grey,
                                                                                          border: InputBorder.none,
                                                                                          hintMaxLines: 1,
                                                                                        ),
                                                                                        onChanged: (value) {
                                                                                          setState(() {
                                                                                            caddress = value;
                                                                                            _saveAddress(caddress);
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    // 66666666

                                                                                    Text(
                                                                                      "CHANGE",
                                                                                      style: TextStyle(
                                                                                        color: Colors.red,
                                                                                        fontFamily: 'SatoshiMedium',
                                                                                        fontSize: mQuery.size.height * 0.0173,
                                                                                      ),
                                                                                    ),
                                                                                  ],
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
                                                                                          _saveSelectedAddress(i, addresses[i]); // Update the selected address
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
                                                                                          color: selectedAddressIndex == i ? Colors.cyan : Colors.white,
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: Text(
                                                                                            addresses[i],
                                                                                            style: TextStyle(
                                                                                              fontSize: mQuery.size.height * 0.0195,
                                                                                              color: selectedAddressIndex == i ? Colors.white : Colors.cyan,
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
                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                    return AddressPage();
                                                                                  }));
                                                                                },
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: mQuery.size.height * 0.054,
                                                                                  decoration: BoxDecoration(color: Color(0xff29b2fe), borderRadius: BorderRadius.circular(8)),
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "Save Address",
                                                                                      style: TextStyle(fontSize: mQuery.size.height * 0.022, fontFamily: 'SatoshiBold', color: Colors.white),
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
                                                              },
                                                            );
                                                          },
                                                          child: Text(
                                                            "CHANGE",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'SatoshiMedium',
                                                              fontSize: mQuery
                                                                      .size
                                                                      .height *
                                                                  0.0183,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: mQuery
                                                                  .size.width *
                                                              0.065,
                                                        ),
                                                        Text(
                                                          "$caddress" != null &&
                                                                  "$caddress" !=
                                                                      ""
                                                              ? "$caddress"
                                                              : "B-702, Sarthak the Sarjak",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0183,
                                                            fontFamily:
                                                                'SatoshiMedium',
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    mQuery.size.height * 0.015,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Clothes Detail",
                                                      style: TextStyle(
                                                        fontSize:
                                                            mQuery.size.height *
                                                                0.02,
                                                        fontFamily:
                                                            'SatoshiMedium',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    mQuery.size.height * 0.02,
                                              ),
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height:
                                                          mQuery.size.height *
                                                              0.4,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 0.2,
                                                            blurRadius: 7,
                                                            offset:
                                                                Offset(0, 0),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                              height: mQuery
                                                                      .size
                                                                      .height *
                                                                  0.015),

                                                          SizedBox(
                                                              height: mQuery
                                                                      .size
                                                                      .height *
                                                                  0.012),
                                                          Expanded(
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  CartItems
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                double
                                                                    pricePerKg =
                                                                    // double.parse(CartItems[index]
                                                                    //         [
                                                                    //         "price"]
                                                                    //     .split(
                                                                    //         " ")[1]);
                                                                    200;
                                                                double
                                                                    totalCost =
                                                                    // kgValues[
                                                                    //         index] *
                                                                    //     pricePerKg;
                                                                    300;

                                                                return Column(
                                                                  children: [
                                                                    buildItemContainer(
                                                                      mQuery,
                                                                      CartItems[
                                                                              index]
                                                                          [
                                                                          'type'],
                                                                      CartItems[
                                                                              index]
                                                                          [
                                                                          "name"],
                                                                      CartItems[
                                                                              index]
                                                                          [
                                                                          "price"],
                                                                      CartItems[
                                                                              index]
                                                                          [
                                                                          'quantity'],
                                                                      () {
                                                                        setState(
                                                                            () {
                                                                          kgValues[
                                                                              index] = kgValues[index] >
                                                                                  0
                                                                              ? kgValues[index] - 1
                                                                              : 0;
                                                                        });
                                                                      },
                                                                      () {
                                                                        setState(
                                                                            () {
                                                                          kgValues[
                                                                              index]++;
                                                                          calculateTotalKgValue();
                                                                        });
                                                                      },
                                                                    ),
                                                                    // Container(
                                                                    //   padding: EdgeInsets.only(
                                                                    //       right:
                                                                    //           28),
                                                                    //   child:
                                                                    //       Row(
                                                                    //     mainAxisAlignment:
                                                                    //         MainAxisAlignment.end,
                                                                    //     children: [
                                                                    //       Text(
                                                                    //         '₹ .toStringAsFixed(0)}',
                                                                    //         style:
                                                                    //             TextStyle(
                                                                    //           fontSize: mQuery.size.height * 0.0173,
                                                                    //           fontFamily: 'SatoshiMedium',
                                                                    //           color: Color(0xff29b2fe),
                                                                    //         ),
                                                                    //       ),
                                                                    //     ],
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          SizedBox(height: 10),
                                                          //////   Text("Hello Flutter",)/////
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          mQuery.size.height *
                                                              0.02,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("Extra Note",
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'SatoshiMedium',
                                                                    fontSize: mQuery
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: mQuery.size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            height: mQuery.size
                                                                    .height *
                                                                0.16,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      0.2,
                                                                  blurRadius: 7,
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                ),
                                                              ],
                                                            ),
                                                            child: TextField(
                                                              controller:
                                                                  extranoteController,
                                                              cursorColor:
                                                                  Colors
                                                                      .black54,
                                                              decoration:
                                                                  InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "Write message here",
                                                                      contentPadding: EdgeInsets.only(
                                                                          left:
                                                                              16,
                                                                          right:
                                                                              6),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontFamily:
                                                                            'SatoshiMedium',
                                                                        fontSize:
                                                                            mQuery.size.height *
                                                                                0.02,
                                                                      )),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          mQuery.size.height *
                                                              0.025,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height:
                                                          mQuery.size.height *
                                                              0.27,
                                                      color: Color(0xfff8feff),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 16),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: mQuery
                                                                        .size
                                                                        .height *
                                                                    0.016,
                                                              ),
                                                              Text(
                                                                "Support your Rider",
                                                                style: TextStyle(
                                                                    fontSize: mQuery
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                    fontFamily:
                                                                        'SatoshiMedium'),
                                                              ),
                                                              SizedBox(
                                                                height: mQuery
                                                                        .size
                                                                        .height *
                                                                    0.007,
                                                              ),
                                                              Text(
                                                                "Support your valet and make their day! 100% of your tip will "
                                                                "be transferred to your valet.",
                                                                style: TextStyle(
                                                                    fontSize: mQuery
                                                                            .size.height *
                                                                        0.0173,
                                                                    fontFamily:
                                                                        'SatoshiRegular',
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              SizedBox(
                                                                height: mQuery
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  ContainerItem(
                                                                    text:
                                                                        "+ ₹ 10",
                                                                    isSelected:
                                                                        selectedContainerIndex ==
                                                                            0,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        selectedContainerIndex =
                                                                            0;
                                                                      });
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                      width: mQuery
                                                                              .size
                                                                              .width *
                                                                          0.036),
                                                                  ContainerItem(
                                                                    text:
                                                                        "+ ₹ 20",
                                                                    isSelected:
                                                                        selectedContainerIndex ==
                                                                            1,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        selectedContainerIndex =
                                                                            1;
                                                                      });
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                      width: mQuery
                                                                              .size
                                                                              .width *
                                                                          0.036),
                                                                  ContainerItem(
                                                                    text:
                                                                        "+ ₹ 30",
                                                                    isSelected:
                                                                        selectedContainerIndex ==
                                                                            2,
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        selectedContainerIndex =
                                                                            2;
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: mQuery
                                                                        .size
                                                                        .height *
                                                                    0.022,
                                                              ),
                                                              Text(
                                                                "Offers",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'SatoshiMedium',
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.019,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: mQuery
                                                                        .size
                                                                        .height *
                                                                    0.0072,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/images/promo.svg",
                                                                    width: 22,
                                                                  ),
                                                                  SizedBox(
                                                                    width: mQuery
                                                                            .size
                                                                            .width *
                                                                        0.03,
                                                                  ),
                                                                  Text(
                                                                    "Select a promo code",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'SatoshiMedium',
                                                                      fontSize: mQuery
                                                                              .size
                                                                              .height *
                                                                          0.019,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      child:
                                                                          SizedBox()),
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      // Navigate to Offers Page
                                                                    },
                                                                    child: Text(
                                                                      "View Offers",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'SatoshiMedium',
                                                                          fontSize: mQuery.size.height *
                                                                              0.0183,
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          mQuery.size.height *
                                                              0.023,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Item Total",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'SatoshiRegular',
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.017,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              Text(
                                                                "₹ $FinalTotalCost",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.017,
                                                                  color: Colors
                                                                      .black54,
                                                                  fontFamily:
                                                                      'SatoshiRegular',
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: mQuery.size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          // DottedLine(
                                                          //   direction:
                                                          //       Axis.horizontal,
                                                          //   alignment:
                                                          //       WrapAlignment
                                                          //           .center,
                                                          //   lineLength:
                                                          //       double.infinity,
                                                          //   lineThickness: 1.0,
                                                          //   dashLength: 4.0,
                                                          //   dashColor:
                                                          //       Colors.black54,
                                                          //   dashRadius: 0.0,
                                                          //   dashGapLength: 4.0,
                                                          //   dashGapRadius: 0.0,
                                                          // ),
                                                          // SizedBox(
                                                          //   height: mQuery.size
                                                          //           .height *
                                                          //       0.01,
                                                          // ),
                                                          // Row(
                                                          //   children: [
                                                          //     Text(
                                                          //       "Delivery Charges",
                                                          //       style:
                                                          //           TextStyle(
                                                          //         fontSize: mQuery
                                                          //                 .size
                                                          //                 .height *
                                                          //             0.017,
                                                          //         color: Colors
                                                          //             .black54,
                                                          //         fontFamily:
                                                          //             'SatoshiRegular',
                                                          //       ),
                                                          //     ),
                                                          //     Expanded(
                                                          //         child:
                                                          //             SizedBox()),
                                                          //     Text(
                                                          //       "₹ ${prices["Delivery Charges"]?.toStringAsFixed(2)}",
                                                          //       style:
                                                          //           TextStyle(
                                                          //         fontSize: mQuery
                                                          //                 .size
                                                          //                 .height *
                                                          //             0.017,
                                                          //         color: Colors
                                                          //             .black54,
                                                          //         fontFamily:
                                                          //             'SatoshiRegular',
                                                          //       ),
                                                          //     )
                                                          //   ],
                                                          // ),
                                                          // SizedBox(
                                                          //   height: mQuery.size
                                                          //           .height *
                                                          //       0.01,
                                                          // ),
                                                          // DottedLine(
                                                          //   direction:
                                                          //       Axis.horizontal,
                                                          //   alignment:
                                                          //       WrapAlignment
                                                          //           .center,
                                                          //   lineLength:
                                                          //       double.infinity,
                                                          //   lineThickness: 1.0,
                                                          //   dashLength: 4.0,
                                                          //   dashColor:
                                                          //       Colors.black54,
                                                          //   dashRadius: 0.0,
                                                          //   dashGapLength: 4.0,
                                                          //   dashGapRadius: 0.0,
                                                          // ),
                                                          // SizedBox(
                                                          //   height: mQuery.size
                                                          //           .height *
                                                          //       0.01,
                                                          // ),
                                                          // Row(
                                                          //   children: [
                                                          //     Text(
                                                          //       "Tax",
                                                          //       style:
                                                          //           TextStyle(
                                                          //         fontSize: mQuery
                                                          //                 .size
                                                          //                 .height *
                                                          //             0.017,
                                                          //         color: Colors
                                                          //             .black54,
                                                          //         fontFamily:
                                                          //             'SatoshiRegular',
                                                          //       ),
                                                          //     ),
                                                          //     Expanded(
                                                          //       child:
                                                          //           SizedBox(),
                                                          //     ),
                                                          //     Text(
                                                          //       "₹ ${prices["Tax"]?.toStringAsFixed(2)}",
                                                          //       style:
                                                          //           TextStyle(
                                                          //         fontSize: mQuery
                                                          //                 .size
                                                          //                 .height *
                                                          //             0.017,
                                                          //         color: Colors
                                                          //             .black54,
                                                          //         fontFamily:
                                                          //             'SatoshiRegular',
                                                          //       ),
                                                          //     )
                                                          //   ],
                                                          // ),
                                                          Divider(),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Grand Total",
                                                                style: TextStyle(
                                                                    fontSize: mQuery
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                    fontFamily:
                                                                        'SatoshiMedium'),
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      SizedBox()),
                                                              Text(
                                                                '$FinalTotalCost',
                                                                style: TextStyle(
                                                                    fontSize: mQuery
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                    color: Color(
                                                                        0xff29b2fe),
                                                                    fontFamily:
                                                                        'SatoshiMedium'),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    mQuery.size.height * 0.02,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return PaymentPage();
                                                  }));
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height:
                                                          mQuery.size.height *
                                                              0.08,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xff29b2fe),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6)),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                  height: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.012),
                                                              Text(
                                                                "TOTAL",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'SatoshiRegular',
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.02,
                                                                ),
                                                              ),
                                                              Text(
                                                                '$FinalTotalCost',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'SatoshiRegular',
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.02,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Expanded(
                                                              child:
                                                                  SizedBox()),
                                                          Text(
                                                            "Make Payment",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: mQuery
                                                                        .size
                                                                        .height *
                                                                    0.024,
                                                                fontFamily:
                                                                    'SatoshiMedium'),
                                                          ),
                                                          SizedBox(
                                                              width: mQuery.size
                                                                      .width *
                                                                  0.02),
                                                          Icon(
                                                              Icons.arrow_right,
                                                              color:
                                                                  Colors.white)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          mQuery.size.height *
                                                              0.02,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
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
                                              height:
                                                  mQuery.size.height * 0.012),
                                          Text(
                                            "ITEMS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'SatoshiRegular',
                                                fontSize:
                                                    mQuery.size.height * 0.02),
                                          ),
                                          Text(
                                            "₹ 1,220 plus taxes",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'SatoshiRegular',
                                              fontSize:
                                                  mQuery.size.height * 0.02,
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        "Continue",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                mQuery.size.height * 0.024,
                                            fontFamily: 'SatoshiMedium'),
                                      ),
                                      SizedBox(width: mQuery.size.width * 0.02),
                                      Icon(Icons.arrow_right,
                                          color: Colors.white)
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
          Text(
            "$kgValue",
            style: TextStyle(
                color: Color(0xff29b2fe),
                fontFamily: 'SatoshiRegular',
                fontSize: mQuery.size.height * 0.024),
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

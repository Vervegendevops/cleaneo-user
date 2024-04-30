import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:cleaneo_user/Dashboard/Wash/Select%20Vendor/chooseVendor_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/byweight_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/quantity_wise_page.dart';
import 'package:cleaneo_user/pages/dryclean_page.dart';
import 'package:flutter/material.dart';

int selectedServiceIndex = 0;

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
  const WashPage({Key? key, required this.id});

  @override
  State<WashPage> createState() => _WashPageState();
}

class _WashPageState extends State<WashPage>
    with SingleTickerProviderStateMixin {
  List<String> keysList = [];
  int length = 0;
  late TabController _tabController;
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    fetchServices(widget.id);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void fetchServices(String id) {
    // Make API call to fetch services based on id
    String apiUrl =
        'https://drycleaneo.com/CleaneoUser/api/service_details/$id';
    http.get(Uri.parse(apiUrl)).then((response) {
      if (response.statusCode == 200) {
        print("api calling");
        // Parse response and update services list
        setState(() {
          Map<String, dynamic> data = json.decode(response.body);
          // Initialize a list to store the names of keys

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
      // Handle error
      print('Error fetching services: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return ChooseVendorPage();
                                // }));
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                            ),
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
                                        fontSize: mQuery.size.height * 0.027,
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
                            Tab(text: "By Weight"),
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
                        height: mQuery.size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            QuantityWisePage(),
                            ByWeightPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                        offset:
                            Offset(0, 0), // changes the position of the shadow
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
          _isDropdownOpen = false;
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
}

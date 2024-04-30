import 'dart:convert';

import 'package:cleaneo_user/Dashboard/Wash/Select%20Vendor/vendorDetails_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/wash_page.dart';
import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Map<String, dynamic>> vendorList = [];

class ChooseVendorPage extends StatefulWidget {
  String service;
  ChooseVendorPage({Key? key, required this.service}) : super(key: key);

  @override
  State<ChooseVendorPage> createState() => _ChooseVendorPageState();
}

class _ChooseVendorPageState extends State<ChooseVendorPage> {
  bool SI1 = false;
  List<Map<String, dynamic>> vendorList = [];
  Future<List<Map<String, dynamic>>> fetchResponse() async {
    final url =
        'https://drycleaneo.com/CleaneoUser/api/vendorListing/${widget.service}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> vendorListDynamic = jsonDecode(response.body);
        // Cast each item in the list to Map<String, dynamic>
        setState(() {
          vendorList = vendorListDynamic.cast<Map<String, dynamic>>();
        });

        print(vendorList);
        return vendorList;
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return []; // Return an empty list in case of an error.
    }
  }

  // List<Map<String, dynamic>> vendors = [
  //   {
  //     'name': 'Fresh Bubbles Laundry',
  //     'image':
  //         'https://t3.ftcdn.net/jpg/04/27/57/28/360_F_427572855_RhQYKzH4mAzkzIYhnGngBA4h4x5kUwnm.jpg',
  //     'acceptIn': '30 mins',
  //     'contactNo': '+91-9876543210',
  //     'rating': 4.5,
  //     'distance': 4.2,
  //   },
  //   {
  //     'name': 'Sparkle Cleaners',
  //     'image':
  //         'https://www.sparklecleaners.com/wp-content/uploads/2021/12/sparkle-logo.jpg',
  //     'acceptIn': '45 mins',
  //     'contactNo': '+91-9876543211',
  //     'rating': 4.8,
  //     'distance': 3.5,
  //   },
  //   // {
  //   //   'name': 'Shiny Washers',
  //   //   'image':
  //   //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQGJtl8W18dHWfa8c0g8DEt35z67KnJXwJFHgzO5-Jm-iyHwsZGTL6zsCJFX3MckHhct0&usqp=CAU',
  //   //   'acceptIn': '20 mins',
  //   //   'contactNo': '+91-9876543212',
  //   //   'rating': 4.2,
  //   //   'distance': 5.0,
  //   // },
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchResponse();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.service);
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff006acb),
        ),
        child: Column(
          children: [
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  Text(
                    "Choose Vendor",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.027,
                      color: Colors.white,
                      fontFamily: 'SatoshiBold',
                    ),
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
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: mQuery.size.width * 0.045,
                    right: mQuery.size.width * 0.045,
                  ),
                  child: ListView.builder(
                    itemCount: vendorList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Container();
                      }
                      var vendor = vendorList[index - 1];
                      String temp = vendor['selectedService'];
                      temp = temp.substring(1, temp.length - 1);

                      // Split the string by comma and trim each substring
                      List<String> items =
                          temp.split(',').map((item) => item.trim()).toList();
                      int Lengthh = items.length;
                      return Container(
                        margin:
                            EdgeInsets.only(bottom: mQuery.size.height * 0.036),
                        width: double.infinity,
                        height: mQuery.size.height * 0.24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Color(0xffe9f8ff),
                              width: double.infinity,
                              height: mQuery.size.height * 0.06,
                              padding: EdgeInsets.symmetric(
                                horizontal: mQuery.size.width * 0.032,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: mQuery.size.width * 0.095,
                                    height: mQuery.size.height * 0.095,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          SI1 == false
                                              ? "https://drycleaneo.com/CleaneoVendor/storage/images/${vendor['ID']}/storepicture/3.jpg"
                                              : "https://drycleaneo.com/CleaneoVendor/storage/images/${vendor['ID']}/storepicture/3.png",
                                        ),
                                        onError: (exception, stackTrace) {
                                          // If loading imageUrl1 fails, fallback to imageUrl2
                                          setState(() {
                                            SI1 = true;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: mQuery.size.width * 0.02),
                                  Text(
                                    vendor['name'],
                                    style: TextStyle(
                                      fontSize: mQuery.size.height * 0.016,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  vendor['rating'] == null
                                      ? Container()
                                      : Icon(
                                          Icons.star,
                                          size: mQuery.size.width * 0.047,
                                          color: Color(0xff29b2fe),
                                        ),
                                  SizedBox(width: mQuery.size.width * 0.01),
                                  vendor['rating'] == null
                                      ? Container()
                                      : Text(
                                          vendor['rating'].toString(),
                                          style: TextStyle(
                                              fontFamily: 'SatoshiBold'),
                                        )
                                ],
                              ),
                            ),
                            SizedBox(height: mQuery.size.height * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: mQuery.size.width * 0.032,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Services",
                                        style: TextStyle(
                                          fontSize: mQuery.size.height * 0.0172,
                                          fontFamily: 'SatoshiMedium',
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(
                                        height: mQuery.size.height * 0.004,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Lengthh >= 1
                                                  ? items[0] != null
                                                      ? items[0]
                                                      : ''
                                                  : '',
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.014),
                                            ),
                                            Text(
                                              Lengthh >= 2
                                                  ? items[1] != null
                                                      ? items[1]
                                                      : ''
                                                  : '',
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.014),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Lengthh >= 3
                                                  ? items[2] != null
                                                      ? items[2]
                                                      : ''
                                                  : '',
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.014),
                                            ),
                                            Text(
                                              Lengthh >= 4
                                                  ? items[3] != null
                                                      ? items[3]
                                                      : ''
                                                  : '',
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.014),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Lengthh >= 5
                                                  ? items[4] != null
                                                      ? items[4]
                                                      : ''
                                                  : '',
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.014),
                                            ),
                                            Text(
                                              Lengthh == 6
                                                  ? items[5] != null
                                                      ? items[5]
                                                      : ''
                                                  : '',
                                              style: TextStyle(
                                                  fontFamily: 'SatoshiRegular',
                                                  fontSize: mQuery.size.height *
                                                      0.014),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return VendorDetailsPage(
                                          vendorID: vendor['ID'],
                                        );
                                      }));
                                    },
                                    child: Container(
                                      height: mQuery.size.height * 0.045,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(6)),
                                          color: Color(0xff004c90)),
                                      child: Center(
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  mQuery.size.height * 0.018,
                                              fontFamily: 'SatoshiBold'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return WashPage(
                                          id: vendor['ID'],
                                        );
                                      }));
                                    },
                                    child: Container(
                                      height: mQuery.size.height * 0.045,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(6)),
                                          color: Color(0xff29b2fe)),
                                      child: Center(
                                        child: Text(
                                          "Proceed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  mQuery.size.height * 0.018,
                                              fontFamily: 'SatoshiBold'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

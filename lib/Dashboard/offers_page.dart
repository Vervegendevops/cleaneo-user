import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<Map<String, dynamic>> activeMainOffers = [];

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> offers = [];

  @override
  void initState() {
    super.initState();
    // Call your API to fetch offers data
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    // Replace this URL with your actual API endpoint
    var apiUrl = 'https://drycleaneo.com/cleaneomain/api/allCoupons';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Decode the response JSON
        var responseData = json.decode(response.body);
        setState(() {
          offers = List<Map<String, dynamic>>.from(responseData);
          activeMainOffers =
              offers.where((offer) => offer['status'] == 'online').toList();
          print(activeMainOffers);
        });
      } else {
        // Handle error, maybe show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load offers'),
          ),
        );
      }
    } catch (error) {
      // Handle error, maybe show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
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
                    "Offers",
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
                      topRight: Radius.circular(16)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: mQuery.size.width * 0.045,
                    right: mQuery.size.width * 0.045,
                  ),
                  child: ListView.builder(
                    itemCount: offers
                        .where((offer) => offer['status'] == 'online')
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      final onlineOffers = offers
                          .where((offer) => offer['status'] == 'online')
                          .toList();
                      return _buildOfferContainer(mQuery, onlineOffers[index]);
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

  Widget _buildOfferContainer(
      MediaQueryData mQuery, Map<String, dynamic> offer) {
    // Parse offer data and build UI
    // For example, you can access offer["coupon_code"], offer["discount"], etc.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 6,
              offset: Offset(0, 0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: mQuery.size.height * 0.05,
              padding:
                  EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.02),
              color: Color(0xffe9f7ff),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "Coupon Code : ",
                        style: TextStyle(
                            fontFamily: 'SatoshiBold',
                            fontSize: mQuery.size.height * 0.014),
                      ),
                      Text(
                        offer["coupon_code"],
                        style: TextStyle(
                            fontFamily: 'SatoshiBold',
                            color: Colors.green,
                            fontSize: mQuery.size.height * 0.015),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    offer["discount"],
                    style: TextStyle(
                        color: Color(0xff29b2fe),
                        fontFamily: 'SatoshiBold',
                        fontSize: mQuery.size.height * 0.016),
                  )
                ],
              ),
            ),
            SizedBox(height: mQuery.size.height * 0.012),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mQuery.size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${offer["discount"]} OFF",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.025,
                              color: Colors.black,
                              fontFamily: 'SatoshiBold',
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.005),
                          Text(
                            "Valid Upto ${offer["end_date"]}",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.014,
                              color: Colors.black,
                              fontFamily: 'SatoshiMedium',
                            ),
                          ),
                          SizedBox(height: mQuery.size.height * 0.005),
                        ],
                      ),

                      Text(
                        "On orders above ₹${offer["minimum_value"]}",
                        style: TextStyle(
                          fontSize: mQuery.size.height * 0.014,
                          color: Colors.black,
                          fontFamily: 'SatoshiMedium',
                        ),
                      ),
                      SizedBox(height: mQuery.size.height * 0.01),
                      // Add more details from the offer map here
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

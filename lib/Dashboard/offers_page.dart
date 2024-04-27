import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> offers = [
    {
      "title": "CLEANEO 1234",
      "use": "USE",
      "conditions": [
        "One place one time use",
        "Your discount will be credited within 24 hrs in your wallet",
        "One place one time use",
        "Your discount will be credited within 24 hrs in your wallet"
      ]
    },
    // Add more offers here if needed
  ];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
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
                    top: mQuery.size.height * 0.028,
                    left: mQuery.size.width * 0.045,
                    right: mQuery.size.width * 0.045,
                  ),
                  child: Column(
                    children: [
                      _buildOfferContainer(mQuery, offers[0]),
                      SizedBox(height: mQuery.size.height * 0.03),
                      _buildOfferContainer(mQuery, offers[0]),
                      SizedBox(height: mQuery.size.height * 0.03),
                      _buildOfferContainer(mQuery, offers[0]),
                    ],
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
    return Container(
      width: double.infinity,
      height: mQuery.size.height * 0.2,
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
      child: SingleChildScrollView(
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
                  Text(
                    offer["title"],
                    style: TextStyle(
                        fontFamily: 'SatoshiBold',
                        fontSize: mQuery.size.height * 0.0165),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    offer["use"],
                    style: TextStyle(
                        color: Color(0xff29b2fe),
                        fontFamily: 'SatoshiMedium',
                        fontSize: mQuery.size.height * 0.016),
                  )
                ],
              ),
            ),
            SizedBox(height: mQuery.size.height * 0.01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mQuery.size.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TERMS & CONDITIONS",
                        style: TextStyle(
                          fontSize: mQuery.size.height * 0.0162,
                          color: Colors.black54,
                          fontFamily: 'SatoshiRegular',
                        ),
                      ),
                      SizedBox(height: mQuery.size.height * 0.013),
                      for (var condition in offer["conditions"]) ...[
                        _buildConditionRow(mQuery, condition),
                        SizedBox(height: mQuery.size.height * 0.004),
                      ],
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

  Widget _buildConditionRow(MediaQueryData mQuery, String text) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: mQuery.size.width * 0.03,
            height: mQuery.size.height * 0.013,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff29b2fe)),
          ),
          SizedBox(width: mQuery.size.width * 0.006),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'SatoshiMedium',
                fontSize: mQuery.size.height * 0.0137),
          )
        ],
      ),
    );
  }
}

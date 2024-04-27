import 'package:cleaneo_user/Help/aboutus_page.dart';
import 'package:cleaneo_user/Help/customer_service_page.dart';
import 'package:cleaneo_user/Help/faqs_page.dart';
import 'package:cleaneo_user/Help/privacypolicy_page.dart';
import 'package:cleaneo_user/Help/termsandcondition_page.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    "Help",
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.3,
                      blurRadius: 1,
                      offset:
                          Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mQuery.size.width * 0.045),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mQuery.size.height * 0.037,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AboutusPage();
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            height: mQuery.size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      0), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  "About Us",
                                  style: TextStyle(
                                      fontFamily: 'SatoshiMedium',
                                      fontSize: mQuery.size.height * 0.019),
                                )),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PrivacyPolicyPage();
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            height: mQuery.size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      0), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      fontFamily: 'SatoshiMedium',
                                      fontSize: mQuery.size.height * 0.019),
                                )),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TermsAndConditionPage();
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            height: mQuery.size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      0), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                      fontFamily: 'SatoshiMedium',
                                      fontSize: mQuery.size.height * 0.019),
                                )),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FAQSPage();
                            }));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            height: mQuery.size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      0), // changes the position of the shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  "FAQs",
                                  style: TextStyle(
                                      fontFamily: 'SatoshiMedium',
                                      fontSize: mQuery.size.height * 0.019),
                                )),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity,
                          height: mQuery.size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(
                                    0, 0), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CustomerServicePage();
                              }));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                    child: Text(
                                  "Customer Service",
                                  style: TextStyle(
                                      fontFamily: 'SatoshiMedium',
                                      fontSize: mQuery.size.height * 0.019),
                                )),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

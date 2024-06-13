import 'package:cleaneo_user/Dashboard/Notifications/rating_page.dart';
import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportDisputePage extends StatefulWidget {
  const ReportDisputePage({Key? key}) : super(key: key);

  @override
  State<ReportDisputePage> createState() => _ReportDisputePageState();
}

class _ReportDisputePageState extends State<ReportDisputePage> {
  TextEditingController issueController = TextEditingController();

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;

  bool isOn = false;

  var disputeId = "#123456";

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RatingPage();
                        }));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  Text(
                    "Report Dispute",
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
                      offset: Offset(0, 0),
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
                        Container(
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
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff29b2fe),
                                value: isChecked1,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked1 = value!;
                                  });
                                },
                              ),
                              Text(
                                "Clothes Missing",
                                style: TextStyle(
                                    fontFamily: 'SatoshiMedium',
                                    fontSize: mQuery.size.height * 0.019),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Container(
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
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff29b2fe),
                                value: isChecked2,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked2 = value!;
                                  });
                                },
                              ),
                              Text(
                                "Inappropriate behaviour",
                                style: TextStyle(
                                    fontFamily: 'SatoshiMedium',
                                    fontSize: mQuery.size.height * 0.019),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Container(
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
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff29b2fe),
                                value: isChecked3,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked3 = value!;
                                  });
                                },
                              ),
                              Text(
                                "Lorem Ipsum is a dummy text",
                                style: TextStyle(
                                    fontFamily: 'SatoshiMedium',
                                    fontSize: mQuery.size.height * 0.019),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Container(
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
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff29b2fe),
                                value: isChecked4,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked4 = value!;
                                  });
                                },
                              ),
                              Text(
                                "Lorem Ipsum is a dummy text",
                                style: TextStyle(
                                    fontFamily: 'SatoshiMedium',
                                    fontSize: mQuery.size.height * 0.019),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Container(
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
                          child: Row(
                            children: [
                              Checkbox(
                                activeColor: Color(0xff29b2fe),
                                value: isChecked5,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked5 = value!;
                                  });
                                },
                              ),
                              Text(
                                "Lorem Ipsum is a dummy text",
                                style: TextStyle(
                                    fontFamily: 'SatoshiMedium',
                                    fontSize: mQuery.size.height * 0.019),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.03,
                        ),
                        Text(
                          "Any other dispute/ message?",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.019,
                            fontFamily: 'SatoshiBold',
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.135,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.3,
                                blurRadius: 10,
                                offset: Offset(
                                    0, 0), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: issueController,
                            cursorColor: Colors.black54,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write your issue here",
                                hintStyle: TextStyle(
                                    fontSize: mQuery.size.height * 0.019,
                                    fontFamily: 'SatoshiRegular',
                                    color: Colors.black54),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.027,
                        ),
                        Text(
                          "Upload Pictures",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.019,
                            fontFamily: 'SatoshiBold',
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.023,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              "assets/images/imagepicker.svg",
                              height: mQuery.size.height * 0.085,
                            ),
                            SvgPicture.asset(
                              "assets/images/imagepicker.svg",
                              height: mQuery.size.height * 0.085,
                            ),
                            SvgPicture.asset(
                              "assets/images/imagepicker.svg",
                              height: mQuery.size.height * 0.085,
                            ),
                            SvgPicture.asset(
                              "assets/images/imagepicker.svg",
                              height: mQuery.size.height * 0.085,
                            )
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.045),
                    child: GestureDetector(
                      onTap: () {
                        _showConfirmationDialog();
                      },
                      child: Container(
                        width: double.infinity,
                        height: mQuery.size.height * 0.06,
                        decoration: BoxDecoration(
                            color: Color(0xff29b2fe),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SatoshiBold',
                                fontSize: mQuery.size.height * 0.023),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mQuery.size.height * 0.02,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Center(
            child: Text(
              "Thank You for\nyour patience!",
              style: TextStyle(
                color: Color(0xff29b2fe),
                fontFamily: 'SatoshiBold',
                fontSize: mQuery.size.height * 0.028,
              ),
            ),
          ),
          content: SizedBox(
            height: mQuery.size.height * 0.25,
            child: Column(
              children: [
                Text(
                  "We are extremely sorry for the",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                Text(
                  "inconvenience caused. Our",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                Text(
                  "support team will enquire more",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                Text(
                  "about the issue and get back to",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                Text(
                  "you as soon as possible.",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                SizedBox(
                  height: mQuery.size.height * 0.023,
                ),
                Text(
                  "Your dispute ID is:",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                Text(
                  "$disputeId",
                  style: TextStyle(
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }),
                );
              },
              child: Container(
                width: double.infinity,
                height: mQuery.size.height * 0.06,
                decoration: BoxDecoration(
                  color: Color(0xff29b2fe),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Okay",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SatoshiBold',
                      fontSize: mQuery.size.height * 0.024,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

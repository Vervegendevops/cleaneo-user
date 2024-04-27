import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class DPVerificationPage extends StatefulWidget {
  const DPVerificationPage({Key? key}) : super(key: key);

  @override
  State<DPVerificationPage> createState() => _DPVerificationPageState();
}

class _DPVerificationPageState extends State<DPVerificationPage> {
  TextEditingController issueController = TextEditingController();
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  int focusedIndex = -1;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    final defaultPinTheme = PinTheme(
      width: mQuery.size.width * 0.23,
      height: mQuery.size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.45),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      textStyle: TextStyle(
        fontSize: mQuery.size.height * 0.04,
        fontWeight: FontWeight.w700,
      ),
    );
    return Scaffold(
      body: Column(
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
              children: [],
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Delivery Partner Verification",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.028,
                            fontFamily: 'SatoshiBold',
                          ),
                        ),
                      ),
                      SizedBox(height: mQuery.size.height * 0.02),
                      Divider(),
                      SizedBox(height: mQuery.size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.045),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Enter 4 Digit Code",
                              style: TextStyle(
                                  fontSize: mQuery.size.height * 0.0215,
                                  fontFamily: 'SatoshiBold'),
                            ),
                            SizedBox(height: mQuery.size.height * 0.006),
                            Text(
                              "Provided by the delivery partner",
                              style: TextStyle(
                                  fontSize: mQuery.size.height * 0.018,
                                  fontFamily: 'SatoshiMedium',
                                  color: Colors.black87),
                            ),
                            SizedBox(height: mQuery.size.height * 0.04),
                            Pinput(
                              length: 4,
                              defaultPinTheme: defaultPinTheme,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: mQuery.size.height * 0.37),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _showReportDisputeBottomSheet(context);
                            },
                            child: SvgPicture.asset(
                              "assets/images/alert.svg",
                              width: mQuery.size.width * 0.058,
                            ),
                          ),
                          SizedBox(width: mQuery.size.width * 0.033),
                          InkWell(
                            onTap: () {
                              _showReportDisputeBottomSheet(context);
                            },
                            child: Text(
                              "Report Dispute",
                              style: TextStyle(
                                fontSize: mQuery.size.height * 0.02,
                                color: Colors.red,
                                fontFamily: 'SatoshiMedium',
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: mQuery.size.height * 0.055),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          height: mQuery.size.height * 0.06,
                          decoration: BoxDecoration(
                              color: Color(0xff29b2fe),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              "Verify",
                              style: TextStyle(
                                  fontSize: mQuery.size.height * 0.022,
                                  color: Colors.white,
                                  fontFamily: 'SatoshiBold'),
                            ),
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
    );
  }

  void _showReportDisputeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: mQuery.size.height * 0.85,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mQuery.size.height * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.045),
                    child: Text(
                      "Raise Concern",
                      style: TextStyle(
                        fontFamily: 'SatoshiBold',
                        fontSize: mQuery.size.height * 0.025,
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: mQuery.size.width * 0.045,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "There is a problem with code",
                          style: TextStyle(
                            fontFamily: 'SatoshiMedium',
                            fontSize: mQuery.size.height * 0.022,
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.023),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.05,
                          padding:
                              EdgeInsets.only(left: mQuery.size.height * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 0),
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
                                "The code doesn't match",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.017,
                                  fontFamily: 'SatoshiMedium',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.024),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.05,
                          padding:
                              EdgeInsets.only(left: mQuery.size.height * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
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
                                  "The delivery partner hasn't received the code",
                                  style: TextStyle(
                                    fontSize: mQuery.size.height * 0.017,
                                    fontFamily: 'SatoshiMedium',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.024),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.05,
                          padding:
                              EdgeInsets.only(left: mQuery.size.height * 0.02),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 0),
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
                                "Wrong Code",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.017,
                                  fontFamily: 'SatoshiMedium',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.025),
                        Divider(),
                        SizedBox(height: mQuery.size.height * 0.025),
                        Text(
                          "Any other message?",
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
                                hintText: "Write your message here",
                                hintStyle: TextStyle(
                                    fontSize: mQuery.size.height * 0.019,
                                    fontFamily: 'SatoshiRegular',
                                    color: Colors.black54),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8)),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.055,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Enter Code",
                              style: TextStyle(
                                  color: Color(0xff29b2fe),
                                  fontFamily: 'SatoshiMedium',
                                  fontSize: mQuery.size.height * 0.021),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.042,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SatoshiBold',
                                    fontSize: mQuery.size.height * 0.024),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class OTPBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isFocused;

  OTPBox(
      {required this.controller,
      required this.focusNode,
      required this.isFocused});

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Container(
      width: mQuery.size.width * 0.18,
      height: mQuery.size.width * 0.63,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

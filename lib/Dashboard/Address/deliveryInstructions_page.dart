import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:flutter/material.dart';

class DeliveryInstructionPage extends StatefulWidget {
  const DeliveryInstructionPage({Key? key}) : super(key: key);

  @override
  State<DeliveryInstructionPage> createState() =>
      _DeliveryInstructionPageState();
}

class _DeliveryInstructionPageState extends State<DeliveryInstructionPage> {
  int selectedSwitch = -1; // Initialize selectedSwitch with -1
  var address = "B-702, Sarthak the Sarjak,";
  bool isChecked = false;

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
                        return AddressPage();
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
                    "Delivery Instructions",
                    style: TextStyle(
                        fontSize: mQuery.size.height * 0.028,
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
                child: Padding(
                  padding: EdgeInsets.only(
                    top: mQuery.size.height * 0.028,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          child: Row(
                            children: [
                              Container(
                                width: mQuery.size.width * 0.055,
                                height: mQuery.size.height * 0.04,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff29b2fe)),
                                child: Center(
                                  child: Icon(
                                    Icons.home,
                                    color: Colors.white,
                                    size: mQuery.size.width * 0.04,
                                  ),
                                ),
                              ),
                              SizedBox(width: mQuery.size.width * 0.07),
                              Text(
                                "$address",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.019,
                                  fontFamily: 'SatoshiMedium',
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.008,
                        ),
                        Divider(),
                        SizedBox(height: mQuery.size.height * 0.024),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.2,
                          margin: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.2,
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Radio(
                                        value: 1,
                                        groupValue: selectedSwitch,
                                        onChanged: (int? value) {
                                          setState(() {
                                            selectedSwitch = value!;
                                          });
                                        },
                                        activeColor: Color(0xff29b2fe),
                                      ),
                                    ),
                                    Text(
                                      "Contactless delivery at the door",
                                      style: TextStyle(
                                          fontFamily: 'SatoshiMedium',
                                          fontSize: mQuery.size.height * 0.018),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Radio(
                                        value: 2,
                                        groupValue: selectedSwitch,
                                        onChanged: (int? value) {
                                          setState(() {
                                            selectedSwitch = value!;
                                          });
                                        },
                                        activeColor: Color(0xff29b2fe),
                                      ),
                                    ),
                                    Text(
                                      "Contactless delivery to the guard",
                                      style: TextStyle(
                                          fontFamily: 'SatoshiMedium',
                                          fontSize: mQuery.size.height * 0.018),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.9,
                                      child: Radio(
                                        value: 3,
                                        groupValue: selectedSwitch,
                                        onChanged: (int? value) {
                                          setState(() {
                                            selectedSwitch = value!;
                                          });
                                        },
                                        activeColor: Color(0xff29b2fe),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hand me the order",
                                          style: TextStyle(
                                              fontFamily: 'SatoshiMedium',
                                              fontSize:
                                                  mQuery.size.height * 0.018),
                                        ),
                                        Text(
                                          "Order will be given directly to you",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'SatoshiRegular',
                                              fontSize:
                                                  mQuery.size.height * 0.014),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.032,
                        ),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.11,
                          margin: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.2,
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mQuery.size.height * 0.012,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mQuery.size.width * 0.045),
                                  child: Text(
                                    "Additional Instructions",
                                    style: TextStyle(
                                        fontSize: mQuery.size.height * 0.019,
                                        fontFamily: 'SatoshiBold'),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                      activeColor: Color(0xff29b2fe),
                                    ),
                                    Text(
                                      "Don't ring the bell",
                                      style: TextStyle(
                                          fontFamily: 'SatoshiMedium',
                                          fontSize:
                                              mQuery.size.height * 0.0175),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.032,
                        ),
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.16,
                          margin: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.045),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.2,
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: mQuery.size.height * 0.012,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mQuery.size.width * 0.045),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Add Voice directions",
                                        style: TextStyle(
                                            fontSize:
                                                mQuery.size.height * 0.019,
                                            fontFamily: 'SatoshiBold'),
                                      ),
                                      SizedBox(
                                        height: mQuery.size.height * 0.0055,
                                      ),
                                      Text(
                                        "Helps your valet reach your address 3-5 mins faster",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize:
                                                mQuery.size.height * 0.016,
                                            fontFamily: 'SatoshiMedium'),
                                      ),
                                      SizedBox(
                                        height: mQuery.size.height * 0.011,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Tap and hold to record",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.0165,
                                                    fontFamily:
                                                        'SatoshiMedium'),
                                              ),
                                              SizedBox(
                                                height:
                                                    mQuery.size.height * 0.0055,
                                              ),
                                              Text(
                                                "Please keep recording within 1 min",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.016,
                                                    fontFamily:
                                                        'SatoshiRegular'),
                                              )
                                            ],
                                          ),
                                          Expanded(child: SizedBox()),
                                          Container(
                                            width: mQuery.size.width * 0.247,
                                            height: mQuery.size.height * 0.04,
                                            decoration: BoxDecoration(
                                                color: Color(0xffff474b),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Center(
                                              child: Icon(
                                                Icons.mic,
                                                color: Colors.white,
                                                size: mQuery.size.width * 0.06,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.093,
                        ),
                        GestureDetector(
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            color: Colors.white,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: mQuery.size.width * 0.045),
                              decoration: BoxDecoration(
                                  color: Color(0xff29b2fe),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  "Save Address",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.022,
                                      color: Colors.white,
                                      fontFamily: 'SatoshiBold'),
                                ),
                              ),
                            ),
                          ),
                        )
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

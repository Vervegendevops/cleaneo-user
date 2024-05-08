import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/quantity_wise_page.dart';
import 'package:cleaneo_user/Payment/payment_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';

class ByWeightPage extends StatefulWidget {
  const ByWeightPage({Key? key});

  @override
  State<ByWeightPage> createState() => _ByWeightPageState();
}

class _ByWeightPageState extends State<ByWeightPage> {
  int kg = 0;
  int noCloths = 33;
  bool clothSoftenerSelected = false;
  bool antigermsSelected = false;

  int selectedContainerIndex = -1;
  int selectedDateIndex = 0;
  int selectedTimeIndex = -1;

  int selectedDateIndex2 = -1;
  int selectedTimeIndex2 = -1;

  int selectedAddressIndex = -1;

  final List<String> addresses = [
    "Home",
    "Work",
    "Other",
  ];

  String aselectedAddress = "Home";

  TextEditingController extranoteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController reachController = TextEditingController();

  _saveAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('enteredAddress', address); // Save entered address
  }

  @override
  void dispose() {
    super.dispose();
    _saveAddress(addressController.text);
    addressController.dispose();
  }

  _saveSelectedAddress(int index, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedAddressIndex', index);
    await prefs.setString('selectedAddress', address);
  }

  List<Map<String, dynamic>> itemList = [
    {"name": "Shirts", "price": "₹ 10 PER KG(200gm-400gm)"},
    {"name": "Blouse Designer", "price": "₹ 30 PER KG(100gm-300gm)"},
    {"name": "Lehenga Suit (Heavy)", "price": "₹ 180 PER KG(2kg-5kg)"},
    {
      "name": "Evening Dress (Heavy Work)",
      "price": "₹ 190 PER KG(500gm-800gm)"
    },
    {"name": "Night Suit", "price": "₹ 45 PER KG(200gm-500gm)"},
    {"name": "Waistcoat", "price": "₹ 50 PER KG(300gm-900gm)"},
    {"name": "Short", "price": "₹ 25 PER KG(100gm-300gm)"},
    {"name": "Skirt", "price": "₹ 25 PER KG(300gm-800gm)"},
    {"name": "Swimming Costume", "price": "₹ 30 PER KG(300gm-700gm)"},
    {"name": "Inner wear", "price": "₹ 15 PER KG(200gm-600gm)"},
    {"name": "Socks/Stocking", "price": "₹ 10 PER KG(20gm-80gm)"},
    {"name": "Frock", "price": "₹ 35 PER KG(500gm-1kg)"},
    {"name": "Jump Suits", "price": "₹ 50 PER KG(700gm-1600gm)"},
  ];

  var address = "Home";
  var caddress = "B-702, Sarthak the Sarjak";

  List<int> kgValues = List.filled(13, 0);
  double totalKgValue = 0;

  void calculateTotalKgValue() {
    totalKgValue = kgValues.fold(0, (prev, curr) => prev + curr);
  }

  Map<String, double> prices = {
    "Item Total": 1640,
    "Delivery Charges": 50,
    "Tax": 60,
  };

  double calculateTotal(Map<String, double> prices) {
    double total = 0;
    prices.forEach((key, value) {
      total += value;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mQuery.size.height * 0.03),
            Text(
              "Add Clothes",
              style: TextStyle(
                  fontSize: mQuery.size.height * 0.021,
                  fontFamily: 'SatoshiBold'),
            ),
            SizedBox(height: mQuery.size.height * 0.022),
            Container(
              width: double.infinity,
              height: mQuery.size.height * 0.135,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
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
                  children: [
                    SizedBox(
                      height: mQuery.size.height * 0.015,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/kg.svg",
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: mQuery.size.width * 0.033),
                        Text(
                          "Tentative KG",
                          style: TextStyle(
                            fontFamily: 'SatoshiMedium',
                            fontSize: mQuery.size.height * 0.017,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            setState(() {
                              kg = kg > 0 ? kg - 1 : 0;
                            });
                          },
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
                                size: mQuery.size.height * 0.02,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: mQuery.size.width * 0.026),
                        Text(
                          "$kg",
                          style: TextStyle(
                            color: Color(0xff29b2fe),
                            fontFamily: 'SatoshiRegular',
                            fontSize: mQuery.size.height * 0.024,
                          ),
                        ),
                        SizedBox(width: mQuery.size.width * 0.026),
                        InkWell(
                          onTap: () {
                            setState(() {
                              kg++;
                            });
                          },
                          child: Container(
                            width: mQuery.size.width * 0.1,
                            height: mQuery.size.height * 0.026,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: mQuery.size.height * 0.02,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "₹ 30 PER KG",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.017,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/cloths.png",
                          width: 28,
                        ),
                        SizedBox(width: mQuery.size.width * 0.018),
                        Text(
                          "Number of clothes, in total",
                          style: TextStyle(
                            fontFamily: 'SatoshiMedium',
                            fontSize: mQuery.size.height * 0.017,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          width: mQuery.size.width * 0.15,
                          height: mQuery.size.height * 0.036,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "$noCloths",
                              style: TextStyle(
                                fontSize: mQuery.size.height * 0.017,
                                color: Color(0xff29b2fe),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mQuery.size.height * 0.02,
            ),
            Text(
              "NOTE",
              style: TextStyle(
                  fontSize: mQuery.size.height * 0.019, color: Colors.red),
            ),
            SizedBox(
              height: mQuery.size.height * 0.01,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "The final charges will be based on the actual weight of the clothes. "
                        "Heavy items and dry cleaning items are not included in weight "
                        "category. To add those items go to ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'SatoshiRegular',
                        fontSize: mQuery.size.height * 0.018),
                  ),
                  TextSpan(
                    text: "'SEARCH'",
                    style: TextStyle(
                      color: Color(
                        0xff29b2fe,
                      ),
                      fontSize: mQuery.size.height * 0.019,
                      fontFamily: 'SatoshiRegular',
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage()), // Replace HomePage() with your home page widget
                        );
                      },
                  ),
                  TextSpan(
                    text: " on Dashboard",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: mQuery.size.height * 0.018,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mQuery.size.height * 0.05,
            ),
            Text("Select Add-On",
                style: TextStyle(
                    fontSize: mQuery.size.height * 0.021,
                    fontFamily: 'SatoshiBold')),
            SizedBox(
              height: mQuery.size.height * 0.02,
            ),
            Container(
              padding: EdgeInsets.only(right: 16),
              width: double.infinity,
              height: mQuery.size.height * 0.128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
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
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: clothSoftenerSelected,
                          activeColor: Color(0xff29b2fe),
                          onChanged: (value) {
                            setState(() {
                              clothSoftenerSelected = value!;
                            });
                          },
                        ),
                        Text(
                          "Cloth Softener",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.017,
                            fontFamily: 'SatoshiMedium',
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.add,
                          color: Colors.black54,
                          size: 18,
                        ),
                        SizedBox(
                          width: mQuery.size.width * 0.04,
                        ),
                        Text(
                          "₹ 5 PER KG",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'SatoshiRegular',
                            fontSize: mQuery.size.height * 0.017,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: antigermsSelected,
                          activeColor: Color(0xff29b2f2),
                          onChanged: (value) {
                            setState(() {
                              antigermsSelected = value!;
                            });
                          },
                        ),
                        Text(
                          "Anti-Germs Liquid",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.017,
                            fontFamily: 'SatoshiMedium',
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Icon(
                          Icons.add,
                          color: Colors.black54,
                          size: 18,
                        ),
                        SizedBox(
                          width: mQuery.size.width * 0.04,
                        ),
                        Text(
                          "₹ 5 PER KG",
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'SatoshiRegular',
                            fontSize: mQuery.size.height * 0.017,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: mQuery.size.height * 0.033,
            ),
            // GestureDetector(
            //   onTap: () {
            //     _openBottomSheet(context);
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     height: mQuery.size.height * 0.08,
            //     padding: EdgeInsets.symmetric(horizontal: 16),
            //     decoration: BoxDecoration(
            //         color: Color(0xff29b2fe),
            //         borderRadius: BorderRadius.circular(6)),
            //     child: Row(
            //       children: [
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             SizedBox(
            //               height: mQuery.size.height * 0.012,
            //             ),
            //             Text(
            //               "$noCloths ITEMS",
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontFamily: 'SatoshiMedium',
            //                 fontSize: mQuery.size.height * 0.0195,
            //               ),
            //             ),
            //             Text("₹ 1,500 plus taxes",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontFamily: 'SatoshiMedium',
            //                   fontSize: mQuery.size.height * 0.0195,
            //                 ))
            //           ],
            //         ),
            //         Expanded(child: SizedBox()),
            //         Text("Proceed",
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: mQuery.size.height * 0.024,
            //               fontFamily: 'SatoshiMedium',
            //             )),
            //         SizedBox(
            //           width: mQuery.size.width * 0.02,
            //         ),
            //         Icon(
            //           Icons.arrow_right,
            //           color: Colors.white,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _openBottomSheet(BuildContext context) {
    String totalSum = '₹ ${calculateTotal(prices).toStringAsFixed(2)}';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        List<String> dates = ["25 June", "26 June", "27 June"];
        List<String> times = ["10am - 12pm", "02pm - 04pm", "06pm - 08pm"];

        List<String> dates2 = ["25 June", "28 June", "29 June"];
        List<String> times2 = ["10am - 12pm", "02pm - 04pm", "06pm - 08pm"];

        int? selectedDateIndex; // Track the selected date index

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: mQuery.size.height * 0.86,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mQuery.size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "Schedule Your Order",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.022,
                              fontFamily: 'SatoshiBold',
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close))
                        ],
                      ),
                    ),
                    SizedBox(height: mQuery.size.height * 0.01),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                            height: mQuery.size.height * 0.23,
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
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.01),
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
                                          height: mQuery.size.height * 0.048,
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
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (int i = 0; i < times.length; i++)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTimeIndex = i;
                                          });
                                        },
                                        child: Container(
                                          width: mQuery.size.width * 0.25,
                                          height: mQuery.size.height * 0.048,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: selectedTimeIndex == i
                                                      ? Color(0xff009c1a)
                                                      : Colors.grey),
                                              color: selectedTimeIndex == i
                                                  ? Color(0xff009c1a)
                                                  : Colors.white),
                                          child: Center(
                                            child: Text(
                                              times[i],
                                              style: TextStyle(
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
                            height: mQuery.size.height * 0.23,
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
                                      fontSize: mQuery.size.height * 0.0173,
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.01),
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
                                          height: mQuery.size.height * 0.048,
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
                                                fontSize:
                                                    mQuery.size.height * 0.0176,
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
                                      color: Colors.black54),
                                ),
                                SizedBox(height: mQuery.size.height * 0.01),
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
                                          height: mQuery.size.height * 0.048,
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
                                                    mQuery.size.height * 0.11,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffebf7ed)),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xff009c1a),
                                                            ),
                                                            child: Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                              size: 12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: mQuery.size
                                                                    .width *
                                                                0.032,
                                                          ),
                                                          Text(
                                                            "Pickup from $address",
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
                                                              child:
                                                                  SizedBox()),
                                                          TextButton(
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
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
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                mQuery.size.height * 0.03,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 16),
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
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: mQuery.size.height * 0.022,
                                                                                ),
                                                                                Text(
                                                                                  "Complete address*",
                                                                                  style: TextStyle(fontSize: mQuery.size.height * 0.0183, color: Colors.black54),
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
                                                                                  style: TextStyle(fontSize: mQuery.size.height * 0.0183, color: Colors.black54),
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
                                                                                  style: TextStyle(fontSize: mQuery.size.height * 0.0183, color: Colors.black54),
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
                                                                                  style: TextStyle(fontSize: mQuery.size.height * 0.0183, color: Colors.black54),
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
                                                                color:
                                                                    Colors.red,
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
                                                            width: mQuery.size
                                                                    .width *
                                                                0.065,
                                                          ),
                                                          Text(
                                                            "$caddress",
                                                            style: TextStyle(
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
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16),
                                                child: Column(
                                                  children: [
                                                    // Text(
                                                    //   "Clothes Detail",
                                                    //   style: TextStyle(
                                                    //     fontSize: mQuery.size.height*0.02,
                                                    //     fontFamily: 'SatoshiMedium',),
                                                    // )
                                                  ],
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    // Container(
                                                    //   width: double.infinity,
                                                    //   height: mQuery.size.height * 0.4,
                                                    //   margin: EdgeInsets.symmetric(horizontal: 16),
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.circular(6),
                                                    //     color: Colors.white,
                                                    //     boxShadow: [
                                                    //       BoxShadow(
                                                    //         color: Colors.grey.withOpacity(0.5),
                                                    //         spreadRadius: 0.2,
                                                    //         blurRadius: 7,
                                                    //         offset: Offset(0, 0),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    //   child: Column(
                                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                                    //     children: [
                                                    //       SizedBox(height: mQuery.size.height * 0.015),
                                                    //       Padding(
                                                    //         padding: const EdgeInsets.only(left: 16),
                                                    //         child: Text(
                                                    //           "WASH",
                                                    //           style: TextStyle(
                                                    //             fontSize: mQuery.size.height*0.0173,
                                                    //             fontFamily: 'SatoshiMedium',
                                                    //             color: Color(0xff29b2fe),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //       SizedBox(height: mQuery.size.height * 0.012),
                                                    //       Expanded(
                                                    //         child: ListView.builder(
                                                    //           itemCount: itemList.length,
                                                    //           itemBuilder: (BuildContext context, int index) {
                                                    //             double pricePerKg = double.parse(itemList[index]["price"].split(" ")[1]);
                                                    //             double totalCost = kgValues[index] * pricePerKg;
                                                    //
                                                    //             return Column(
                                                    //               children: [
                                                    //                 buildItemContainer(
                                                    //                   mQuery,
                                                    //                   itemList[index]["name"],
                                                    //                   itemList[index]["price"],
                                                    //                   kgValues[index],
                                                    //                       () {
                                                    //                     setState(() {
                                                    //                       kgValues[index] = kgValues[index] > 0 ? kgValues[index] - 1 : 0;
                                                    //                     });
                                                    //                   },
                                                    //                       () {
                                                    //                     setState(() {
                                                    //                       kgValues[index]++;
                                                    //                       calculateTotalKgValue();
                                                    //                     });
                                                    //                   },
                                                    //                 ),
                                                    //                 Container(
                                                    //                   padding: EdgeInsets.only(right: 28),
                                                    //                   child: Row(
                                                    //                     mainAxisAlignment: MainAxisAlignment.end,
                                                    //                     children: [
                                                    //                       Text(
                                                    //                         '₹ ${(totalCost).toStringAsFixed(0)}',
                                                    //                         style: TextStyle(
                                                    //                           fontSize: mQuery.size.height*0.0173,
                                                    //                           fontFamily: 'SatoshiMedium',
                                                    //                           color: Color(0xff29b2fe),
                                                    //                         ),
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                 ),
                                                    //               ],
                                                    //             );
                                                    //           },
                                                    //         ),
                                                    //       ),
                                                    //       SizedBox(height: 10),
                                                    //
                                                    //       ////////    Text("Hello Flutter")   ///////
                                                    //     ],
                                                    //   ),
                                                    // ),

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
                                                              Text(
                                                                "Extra Note",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'SatoshiMedium',
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.02,
                                                                ),
                                                              ),
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
                                                              decoration: InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      "Write message here",
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              16,
                                                                          right:
                                                                              6),
                                                                  hintStyle: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontSize: mQuery
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                      fontFamily:
                                                                          'SatoshiRegular')),
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
                                                                            .size
                                                                            .height *
                                                                        0.0173,
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
                                                                "₹ ${prices["Item Total"]?.toStringAsFixed(2)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.017,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: mQuery.size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          DottedLine(
                                                            direction:
                                                                Axis.horizontal,
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            lineLength:
                                                                double.infinity,
                                                            lineThickness: 1.0,
                                                            dashLength: 4.0,
                                                            dashColor:
                                                                Colors.black54,
                                                            dashRadius: 0.0,
                                                            dashGapLength: 4.0,
                                                            dashGapRadius: 0.0,
                                                          ),
                                                          SizedBox(
                                                            height: mQuery.size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Delivery Charges",
                                                                style:
                                                                    TextStyle(
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
                                                                "₹ ${prices["Delivery Charges"]?.toStringAsFixed(2)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.017,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: mQuery.size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          DottedLine(
                                                            direction:
                                                                Axis.horizontal,
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            lineLength:
                                                                double.infinity,
                                                            lineThickness: 1.0,
                                                            dashLength: 4.0,
                                                            dashColor:
                                                                Colors.black54,
                                                            dashRadius: 0.0,
                                                            dashGapLength: 4.0,
                                                            dashGapRadius: 0.0,
                                                          ),
                                                          SizedBox(
                                                            height: mQuery.size
                                                                    .height *
                                                                0.01,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Tax",
                                                                style:
                                                                    TextStyle(
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
                                                                    SizedBox(),
                                                              ),
                                                              Text(
                                                                "₹ ${prices["Tax"]?.toStringAsFixed(2)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: mQuery
                                                                          .size
                                                                          .height *
                                                                      0.017,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              )
                                                            ],
                                                          ),
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
                                                                totalSum,
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
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return PaymentPage();
                                                      }));
                                                    },
                                                    child: Container(
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
                                                                style: TextStyle(
                                                                    fontSize: mQuery
                                                                            .size
                                                                            .height *
                                                                        0.02,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              Text(
                                                                totalSum,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
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
                                                  ),
                                                  SizedBox(
                                                    height: mQuery.size.height *
                                                        0.02,
                                                  ),
                                                ],
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
                                            "$noCloths ITEMS",
                                            style: TextStyle(
                                                fontSize:
                                                    mQuery.size.height * 0.02,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "₹ 1,220 plus taxes",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  mQuery.size.height * 0.02,
                                            ),
                                          )
                                        ],
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                        "View Cart",
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
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildItemContainer(
      MediaQueryData mQuery,
      String itemName,
      String itemPrice,
      int kgValue,
      Function() onRemovePressed,
      Function() onAddPressed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.033),
      width: double.infinity,
      height: mQuery.size.height * 0.07,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: TextStyle(
                  fontFamily: 'SatoshiMedium',
                  fontSize: mQuery.size.height * 0.017,
                ),
              ),
              Text(
                itemPrice,
                style: TextStyle(
                    fontSize: mQuery.size.height * 0.014,
                    color: Colors.grey,
                    fontFamily: 'SatoshiRegular'),
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
                child: Icon(Icons.remove, size: 14),
              ),
            ),
          ),
          SizedBox(width: mQuery.size.width * 0.026),
          Text(
            "$kgValue",
            style: TextStyle(
                color: Color(0xff29b2fe), fontSize: mQuery.size.height * 0.024),
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
                child: Icon(Icons.add, size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

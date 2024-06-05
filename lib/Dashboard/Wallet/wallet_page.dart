import 'dart:convert';
import 'package:cleaneo_user/Dashboard/Wallet/AddMoneyPopup.dart';
import 'package:cleaneo_user/main.dart';
import 'package:http/http.dart' as http;
import 'package:cleaneo_user/Dashboard/Wallet/addMoney_page.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final authentication = GetStorage();

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchResponse();
    selectedContainerIndex = -1;
  }

  String selectedAmount = '';
  late int selectedContainerIndex;
  Map userDataWallet = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Object> fetchResponse() async {
    final url =
        'https://drycleaneo.com/CleaneoUser/api/signedUp/${UserData.read('phone')}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          userDataWallet = jsonDecode(response.body);
        });

        print(userDataWallet['Wallet']);
        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  // Define a map to store the transactions data
  final List<Map<String, dynamic>> transactions =
      authentication.read('Authentication') == 'Guest'
          ? [
              {
                'image': "assets/images/drawer-images/shopping-bag.png",
                'title': "Paid for Order #1234567890",
                'amount': -100.00,
                'time': "11:30 AM",
              },
            ]
          : [
              {
                'image': "assets/images/drawer-images/shopping-bag.png",
                'title': "Paid for Order #1234567890",
                'amount': -100.00,
                'time': "11:30 AM",
              },
              {
                'image': "assets/images/drawer-images/wallet.png",
                'title': "Money added to wallet",
                'amount': 100.00,
                'time': "11:30 AM",
              },
              {
                'image': "assets/images/drawer-images/heart.png",
                'title': "Money Donated",
                'amount': -100.00,
                'time': "11:30 AM",
              },
              {
                'image': "assets/images/drawer-images/shopping-bag.png",
                'title': "Paid for Order #1234567890",
                'amount': -100.00,
                'time': "11:30 AM",
              },
            ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    var balance = 500.00;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
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
                    "Wallet",
                    style: TextStyle(
                        fontSize: mQuery.size.height * 0.027,
                        color: Colors.white,
                        fontFamily: 'SatoshiBold'),
                  ),
                  const Expanded(child: SizedBox()),
                  authentication.read('Authentication') == 'Guest'
                      ? Container()
                      : Text(
                          "Bal : ₹ ${userDataWallet['Wallet']}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: mQuery.size.height * 0.02,
                              fontFamily: 'SatoshiRegular'),
                        )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: mQuery.size.height * 0.028,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mQuery.size.width * 0.045,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openTransactionBottomSheet(context);
                              },
                              child: Image.asset(
                                "assets/images/filter.png",
                                width: mQuery.size.width * 0.05,
                              ),
                            ),
                            SizedBox(width: mQuery.size.width * 0.025),
                            GestureDetector(
                              onTap: () {
                                _openTransactionBottomSheet(context);
                              },
                              child: const Text(
                                "Transactions",
                                style: TextStyle(fontFamily: 'SatoshiMedium'),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            authentication.read('Authentication') == 'Guest'
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return AddMoneyPage();
                                      // }));
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container();
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: mQuery.size.width * 0.06,
                                      height: mQuery.size.height * 0.02,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff29b2fe),
                                          shape: BoxShape.circle),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: mQuery.size.width * 0.037,
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(width: mQuery.size.width * 0.017),
                            authentication.read('Authentication') == 'Guest'
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return MoneyInputWidget();
                                        },
                                      );
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return AddMoneyPage();
                                      // }));
                                      // showModalBottomSheet(
                                      //   context: context,
                                      //   builder: (context) {
                                      //     return Container(
                                      //       height: MediaQuery.of(context)
                                      //               .size
                                      //               .height *
                                      //           0.3,
                                      //       width: MediaQuery.of(context)
                                      //               .size
                                      //               .height *
                                      //           1,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.white,
                                      //           borderRadius: BorderRadius.only(
                                      //               topLeft:
                                      //                   Radius.circular(20),
                                      //               topRight:
                                      //                   Radius.circular(20))),
                                      //       child: Column(
                                      //         children: [
                                      //           GestureDetector(
                                      //             onTap: () {
                                      //               // Navigator.push(context,
                                      //               //     MaterialPageRoute(builder: (context) {
                                      //               //   return OTPPage();
                                      //               // }));
                                      //             },
                                      //             child: Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       20.0),
                                      //               child: Container(
                                      //                 width: double.infinity,
                                      //                 height:
                                      //                     mQuery.size.height *
                                      //                         0.06,
                                      //                 decoration: BoxDecoration(
                                      //                     color:
                                      //                         Color(0xff29b2fe),
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .circular(6)),
                                      //                 child: Center(
                                      //                   child: Row(
                                      //                     mainAxisAlignment:
                                      //                         MainAxisAlignment
                                      //                             .center,
                                      //                     children: [
                                      //                       Text(
                                      //                         "Add Money to Wallet",
                                      //                         style: TextStyle(
                                      //                           fontSize: mQuery
                                      //                                   .size
                                      //                                   .height *
                                      //                               0.02,
                                      //                           color: Colors
                                      //                               .white,
                                      //                           fontFamily:
                                      //                               'SatoshiBold',
                                      //                         ),
                                      //                       ),
                                      //                       SizedBox(
                                      //                         width: 5,
                                      //                       ),
                                      //                     ],
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     );
                                      //   },
                                      // );
                                    },
                                    child: Text(
                                      "Add Money",
                                      style: TextStyle(
                                          fontSize: mQuery.size.height * 0.018,
                                          color: const Color(0xff29b2fe),
                                          fontFamily: 'SatoshiMedium'),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: mQuery.size.height * 0.023),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mQuery.size.width * 0.045,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: mQuery.size.height * 0.013),
                            // Build list of transactions dynamically

                            for (var transaction in transactions) ...[
                              authentication.read('Authentication') == 'Guest'
                                  ? Container(
                                      width: double.infinity,
                                      height: mQuery.size.height * 0.5,
                                      child: const Center(
                                          child:
                                              Text('No Transactions to show')),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      height: mQuery.size.height * 0.08,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: mQuery.size.width * 0.03),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: const Offset(0,
                                                0), // changes the position of the shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            transaction['image'],
                                            color: const Color(0xff29b2fe),
                                            width: mQuery.size.width * 0.06,
                                          ),
                                          SizedBox(
                                              width: mQuery.size.width * 0.02),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: mQuery.size.height *
                                                      0.015),
                                              Row(
                                                children: [
                                                  Text(
                                                    transaction['title'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            mQuery.size.height *
                                                                0.017,
                                                        fontFamily:
                                                            'SatoshiMedium'),
                                                  ),
                                                  // SizedBox(width: mQuery.size.width * 0.06),
                                                  ///////////// FOR SPACE
                                                ],
                                              ),
                                              SizedBox(
                                                  height: mQuery.size.height *
                                                      0.0035),
                                              Text(
                                                transaction['time'],
                                                style: TextStyle(
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.0155,
                                                    fontFamily:
                                                        'SatoshiRegular'),
                                              )
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Text(
                                            transaction['amount'] >= 0
                                                ? "+ ₹ ${transaction['amount'].abs().toStringAsFixed(2)}"
                                                : "- ₹ ${transaction['amount'].abs().toStringAsFixed(2)}",
                                            style: TextStyle(
                                                color:
                                                    transaction['amount'] >= 0
                                                        ? Colors.green
                                                        : Colors.red,
                                                fontFamily: 'SatoshiMedium',
                                                fontSize:
                                                    mQuery.size.height * 0.015),
                                          )
                                        ],
                                      ),
                                    ),
                              SizedBox(height: mQuery.size.height * 0.03),
                            ]
                          ],
                        ),
                      )
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

  Widget _buildAmountContainer(
    MediaQueryData mQuery, {
    required String amount,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: mQuery.size.width * 0.17,
        height: mQuery.size.height * 0.085,
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xff29b2fe) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: const Offset(0, 0))
            ]),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "₹",
                  style: TextStyle(
                      fontFamily: 'SatoshiMedium',
                      color: isSelected ? Colors.white : Colors.black),
                ),
                TextSpan(
                  text: amount,
                  style: TextStyle(
                      fontSize: mQuery.size.height * 0.022,
                      fontFamily: 'SatoshiBold',
                      color: isSelected ? Colors.white : Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openTransactionBottomSheet(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: double.infinity,
              height: mQuery.size.height * 0.82,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mQuery.size.height * 0.03),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.045,
                      ),
                      child: Text(
                        "Filter Transactions",
                        style: TextStyle(
                          fontSize: mQuery.size.height * 0.023,
                          fontFamily: 'SatoshiBold',
                        ),
                      ),
                    ),
                    SizedBox(height: mQuery.size.height * 0.0075),
                    const Divider(),
                    SizedBox(height: mQuery.size.height * 0.016),
                    Column(
                      children: [
                        _buildRadioButton(
                          mQuery,
                          setState,
                          0,
                          "All",
                          Icons.check,
                        ),
                        SizedBox(height: mQuery.size.height * 0.025),
                        _buildRadioButton(
                          mQuery,
                          setState,
                          1,
                          "Debited",
                          Icons.check,
                        ),
                        SizedBox(height: mQuery.size.height * 0.025),
                        _buildRadioButton(
                          mQuery,
                          setState,
                          2,
                          "Credited",
                          Icons.check,
                        ),
                        SizedBox(height: mQuery.size.height * 0.023),
                        const Divider(),
                        SizedBox(height: mQuery.size.height * 0.02),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.045,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Filter by Date",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.0175,
                                  color: Colors.black54,
                                  fontFamily: 'SatoshiRegular',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.021),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "FROM",
                                    style: TextStyle(
                                      fontSize: mQuery.size.height * 0.018,
                                      fontFamily: 'SatoshiMedium',
                                    ),
                                  ),
                                  SizedBox(height: mQuery.size.height * 0.018),
                                  Container(
                                    width: mQuery.size.width * 0.42,
                                    height: mQuery.size.height * 0.25,
                                    // margin: EdgeInsets.only(
                                    //   left: mQuery.size.width * 0.045,
                                    // ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: RotatedBox(
                                        quarterTurns: 0,
                                        child: Container(
                                          child: Transform.scale(
                                            scale:
                                                0.75, // Adjust scale factor as needed to reduce the size
                                            child: CupertinoDatePicker(
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              initialDateTime: DateTime.now(),
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                // Do something when the date is changed
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(width: mQuery.size.width * 0.05),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "TO",
                                    style: TextStyle(
                                      fontSize: mQuery.size.height * 0.018,
                                      fontFamily: 'SatoshiMedium',
                                    ),
                                  ),
                                  SizedBox(height: mQuery.size.height * 0.018),
                                  Container(
                                    width: mQuery.size.width * 0.42,
                                    height: mQuery.size.height * 0.25,
                                    // margin: EdgeInsets.only(
                                    //   right: mQuery.size.width * 0.045,
                                    // ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: RotatedBox(
                                        quarterTurns: 0,
                                        child: Container(
                                          child: Transform.scale(
                                            scale:
                                                0.75, // Adjust scale factor as needed to reduce the size
                                            child: CupertinoDatePicker(
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              initialDateTime: DateTime.now(),
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                // Do something when the date is changed
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mQuery.size.height * 0.083),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.045,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const WalletPage();
                                  }));
                                },
                                child: Container(
                                  width: mQuery.size.width * 0.42,
                                  height: mQuery.size.height * 0.057,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff004c91),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'SatoshiBold',
                                        fontSize: mQuery.size.height * 0.022,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const WalletPage();
                                  }));
                                },
                                child: Container(
                                  width: mQuery.size.width * 0.42,
                                  height: mQuery.size.height * 0.057,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff29b2fe),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Apply",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'SatoshiBold',
                                        fontSize: mQuery.size.height * 0.022,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
  }

  Widget _buildRadioButton(MediaQueryData mQuery, Function setState, int index,
      String text, IconData iconData) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.045),
        child: Row(
          children: [
            Container(
              width: mQuery.size.width * 0.06,
              height: mQuery.size.height * 0.031,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xff29b2fe))),
              child: const Center(
                child: Text(
                  "₹",
                  style: TextStyle(color: Color(0xff29b2fe)),
                ),
              ),
            ),
            SizedBox(width: mQuery.size.width * 0.047),
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'SatoshiMedium',
                  fontSize: mQuery.size.height * 0.017),
            ),
            const Expanded(child: SizedBox()),
            Container(
              width: mQuery.size.width * 0.06,
              height: mQuery.size.height * 0.025,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff29b2fe)),
                color: selectedIndex == index ? Colors.cyan : Colors.white,
              ),
              child: selectedIndex == index
                  ? Icon(
                      iconData,
                      color: Colors.white,
                      size: mQuery.size.width * 0.03,
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}

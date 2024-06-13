import 'dart:convert';
import 'package:cleaneo_user/Dashboard/Address/selectLocation.dart';
import 'package:http/http.dart' as http;
import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/wash_page.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

double DeliveryCharge = 0;

class OrderSummary extends StatefulWidget {
  String id;
  String vendorAddress;
  String vendorLongitude;
  String vendorLatitude;
  OrderSummary(
      {super.key,
      required this.id,
      required this.vendorAddress,
      required this.vendorLongitude,
      required this.vendorLatitude});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  double deliveryChargeee = 0;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    fetchAddress();
    DeliveryCharge = 0;
    selectedContainerIndex = -1;

    GrandTotalCost = FinalTotalCost;
    GrandTotalCostWithDelivery = FinalTotalCost;
  }

  void calculateDeliveryCharges() {
    if (FinalTotalCost > 350 && FinalTotalCost <= 500) {
      if (deliveryChargeee < 5) {
        setState(() {
          DeliveryCharge = 30;
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee >= 5 && deliveryChargeee <= 7) {
        setState(() {
          DeliveryCharge = 30 + ((deliveryChargeee - 4) * 5);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee > 7 && deliveryChargeee < 10) {
        setState(() {
          DeliveryCharge = 30 + (3 * 5) + ((deliveryChargeee - 7) * 10);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else {
        DeliveryCharge = 30 + (3 * 5) + (20) + ((deliveryChargeee - 9) * 15);
        GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
        GrandTotalCostWithDelivery = GrandTotalCost;
      }
    } else if (FinalTotalCost > 500 && FinalTotalCost <= 800) {
      if (deliveryChargeee < 5) {
        setState(() {
          DeliveryCharge = 40;
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee >= 5 && deliveryChargeee <= 7) {
        setState(() {
          DeliveryCharge = 40 + ((deliveryChargeee - 4) * 5);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee > 7 && deliveryChargeee < 10) {
        setState(() {
          DeliveryCharge = 40 + (3 * 5) + ((deliveryChargeee - 7) * 10);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else {
        DeliveryCharge = 40 + (3 * 5) + (20) + ((deliveryChargeee - 9) * 15);
        GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
        GrandTotalCostWithDelivery = GrandTotalCost;
      }
    } else if (FinalTotalCost > 800 && FinalTotalCost <= 1200) {
      if (deliveryChargeee < 5) {
        setState(() {
          DeliveryCharge = 50;
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee >= 5 && deliveryChargeee <= 7) {
        setState(() {
          DeliveryCharge = 50 + ((deliveryChargeee - 4) * 5);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee > 7 && deliveryChargeee < 10) {
        setState(() {
          DeliveryCharge = 50 + (3 * 5) + ((deliveryChargeee - 7) * 10);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else {
        DeliveryCharge = 50 + (3 * 5) + (20) + ((deliveryChargeee - 9) * 15);
        GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
        GrandTotalCostWithDelivery = GrandTotalCost;
      }
    } else {
      if (deliveryChargeee < 5) {
        setState(() {
          DeliveryCharge = 0;
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee >= 5 && deliveryChargeee <= 7) {
        setState(() {
          DeliveryCharge = 0 + ((deliveryChargeee - 4) * 5);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else if (deliveryChargeee > 7 && deliveryChargeee < 10) {
        setState(() {
          DeliveryCharge = 0 + (3 * 5) + ((deliveryChargeee - 7) * 10);
          GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
          GrandTotalCostWithDelivery = GrandTotalCost;
        });
      } else {
        DeliveryCharge = 0 + (3 * 5) + (20) + ((deliveryChargeee - 9) * 15);
        GrandTotalCost = FinalTotalCost + DeliveryCharge.toInt();
        GrandTotalCostWithDelivery = GrandTotalCost;
      }
    }
  }

  Future<void> dis() async {
    final response = await http.get(Uri.parse(
        'https://drycleaneo.com/CleaneoUser/api/distance?address1=${widget.vendorAddress}&address2=${AddBook[0]['Caddress']}'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      setState(() {
        int testin = data.round();
        deliveryChargeee = testin.toDouble();
        calculateDeliveryCharges();
      });

      print("Distance : $data");
    }
  }

  Future<Object> fetchAddress() async {
    final url =
        'https://drycleaneo.com/CleaneoUser/api/showAddress/${UserData.read('ID')}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        AddBook = jsonDecode(response.body);
        if (AddBook.length > 0) {
          dis();
        }
      });

      // print(AddBook[0]["Type"]); // Decode the response
    } else {
      // OTP = (1000 + Random().nextInt(9000)).toString();
    }
    return true;
  }

  TextEditingController extranoteController = TextEditingController();

  List<int> kgValues = List.filled(13, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.022,
            fontFamily: 'SatoshiBold',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            AddBook.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return AddAddresss();
                          },
                        ).then((value) => setState(() {
                              fetchAddress();
                            }));
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return AddressPage();
                        // }));
                      },
                      child: Text(
                        "Add new Address",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.18,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: Color(0xffebf7ed)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff009c1a),
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.032,
                            ),
                            Text(
                              "Pickup from ${AddBook[0]['Type']}",
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.0183,
                                fontFamily: 'SatoshiMedium',
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "CHANGE",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'SatoshiMedium',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.0183,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.065,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                "${AddBook[0]['Floor']}\n${AddBook[0]['Caddress']}\nHow to Reach : ${AddBook[0]['HTReach']}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.0183,
                                  fontFamily: 'SatoshiMedium',
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    "Clothes Detail",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontFamily: 'SatoshiMedium',
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              // height: MediaQuery.of(context).size.height * 0.4,
              margin: EdgeInsets.symmetric(horizontal: 16),
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
              child: IntrinsicHeight(
                child: Expanded(
                  child: Column(
                    children: List.generate(CartItems.length, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            buildItemContainer(
                              MediaQuery.of(context),
                              CartItems[index]['type'],
                              CartItems[index]["name"],
                              CartItems[index]["price"],
                              CartItems[index]['quantity'],
                              () {
                                setState(() {
                                  kgValues[index] = kgValues[index] > 0
                                      ? kgValues[index] - 1
                                      : 0;
                                });
                              },
                              () {
                                setState(() {
                                  kgValues[index]++;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Extra Note",
                          style: TextStyle(
                            fontFamily: 'SatoshiMedium',
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.16,
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
                    child: TextField(
                      controller: extranoteController,
                      onChanged: (value) {
                        ExtraNotes = value;
                      },
                      onSubmitted: (value) {
                        ExtraNotes = value;
                      },
                      cursorColor: Colors.black54,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write message here",
                          contentPadding: EdgeInsets.only(left: 16, right: 6),
                          hintStyle: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'SatoshiMedium',
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.27,
              color: Color(0xfff8feff),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.016,
                      ),
                      Text(
                        "Support your Rider",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'SatoshiMedium'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.007,
                      ),
                      Text(
                        "Support your valet and make their day! 100% of your tip will "
                        "be transferred to your valet.",
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.0173,
                            fontFamily: 'SatoshiRegular',
                            color: Colors.black54),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        children: [
                          ContainerItem(
                            text: "+ ₹ 10",
                            isSelected: selectedContainerIndex == 0,
                            onTap: () {
                              if (selectedContainerIndex != 0) {
                                setState(() {
                                  selectedContainerIndex = 0;
                                  SupportRider = '10';
                                  GrandTotalCostWithDelivery =
                                      GrandTotalCost + 10;
                                  // print(
                                  //     selectedContainerIndex);
                                });
                              }
                            },
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.036),
                          ContainerItem(
                            text: "+ ₹ 20",
                            isSelected: selectedContainerIndex == 1,
                            onTap: () {
                              if (selectedContainerIndex != 1) {
                                setState(() {
                                  selectedContainerIndex = 1;
                                  SupportRider = '20';
                                  GrandTotalCostWithDelivery =
                                      GrandTotalCost + 20;
                                });
                              }
                            },
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.036),
                          ContainerItem(
                            text: "+ ₹ 30",
                            isSelected: selectedContainerIndex == 2,
                            onTap: () {
                              if (selectedContainerIndex != 2) {
                                setState(() {
                                  selectedContainerIndex = 2;
                                  SupportRider = '30';
                                  GrandTotalCostWithDelivery =
                                      GrandTotalCost + 30;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.022,
                      ),
                      Text(
                        "Offers",
                        style: TextStyle(
                          fontFamily: 'SatoshiMedium',
                          fontSize: MediaQuery.of(context).size.height * 0.019,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0072,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/promo.svg",
                            width: 22,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Text(
                            "Select a promo code",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.019,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {
                              // Navigate to Offers Page
                            },
                            child: Text(
                              "View Offers",
                              style: TextStyle(
                                  fontFamily: 'SatoshiMedium',
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.0183,
                                  color: Colors.red),
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
              height: MediaQuery.of(context).size.height * 0.023,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Item Total",
                        style: TextStyle(
                          fontFamily: 'SatoshiRegular',
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        "₹ $FinalTotalCost",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          color: Colors.black54,
                          fontFamily: 'SatoshiRegular',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Delivery Charges",
                        style: TextStyle(
                          fontFamily: 'SatoshiRegular',
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          color: Colors.black54,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        "₹ $DeliveryCharge",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.017,
                          color: Colors.black54,
                          fontFamily: 'SatoshiRegular',
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        "Grand Total",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: 'SatoshiMedium'),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        '$GrandTotalCostWithDelivery',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            color: Color(0xff29b2fe),
                            fontFamily: 'SatoshiMedium'),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                print('User Id : ${UserData.read('ID')}');
                print('vendor Latitude :${widget.vendorLatitude}');
                print('vendor Longitude :${widget.vendorLongitude}');
                print('Vendor id : ${widget.id}');
                print('Vendor Address : ${widget.vendorAddress}');
                print('Cart Items : ${jsonEncode(CartItems)}');
                print('Pickup Date : $PickupDate');
                print('Pickup Time : $PickupTime');
                print('Delivery Date : $DeliveryDate');
                print('Delivery Time : $DeliveryTime');
                print(DeliveryCharge.toInt());
                print('Extra note : $ExtraNotes');
                print('Support your rider : $SupportRider');
                print('Grand Total : $GrandTotalCostWithDelivery');
                if (AddBook.length > 0)
                  print('Address : ${AddBook[0]['Caddress']}');
                if (AddBook.length > 0) print('Floor : ${AddBook[0]['Floor']}');
                if (AddBook.length > 0)
                  print('How to reach : ${AddBook[0]['HTReach']}');
                if (AddBook.length > 0)
                  print('Latitude : ${AddBook[0]['Latitude']}');
                if (AddBook.length > 0)
                  print('Longitude : ${AddBook[0]['Longitude']}');
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return PaymentConfirmation(
                      id: widget.id,
                      vendorAddress: widget.vendorAddress,
                      vendorLatitude: widget.vendorLatitude,
                      vendorLongitude: widget.vendorLongitude,
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Color(0xff29b2fe),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.012),
                            Text(
                              "TOTAL",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SatoshiRegular',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ),
                            Text(
                              '$GrandTotalCostWithDelivery',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SatoshiRegular',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            )
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          "Make Payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.024,
                              fontFamily: 'SatoshiMedium'),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Icon(Icons.arrow_right, color: Colors.white)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemContainer(
      MediaQueryData mQuery,
      String type,
      String itemName,
      String itemPrice,
      int kgValue,
      Function() onRemovePressed,
      Function() onAddPressed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.02),
      width: double.infinity,
      height: mQuery.size.height * 0.07,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$itemName ($type)",
                style: TextStyle(
                  fontFamily: 'SatoshiMedium',
                  fontSize: mQuery.size.height * 0.017,
                ),
              ),
              Text(
                itemPrice,
                style: TextStyle(
                  fontSize: mQuery.size.height * 0.0155,
                  color: Colors.black54,
                  fontFamily: 'SatoshiRegular',
                ),
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
                child: Icon(
                  Icons.remove,
                  size: mQuery.size.width * 0.045,
                ),
              ),
            ),
          ),
          SizedBox(width: mQuery.size.width * 0.026),
          Container(
            width: 40,
            child: Center(
              child: Text(
                "$kgValue",
                style: TextStyle(
                    color: Color(0xff29b2fe),
                    fontFamily: 'SatoshiRegular',
                    fontSize: mQuery.size.height * 0.024),
              ),
            ),
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
                child: Icon(Icons.add, size: mQuery.size.width * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal(Map<String, double> prices) {
    double total = 0;
    prices.forEach((key, value) {
      total += value;
    });
    return total;
  }
}

class AddAddresss extends StatefulWidget {
  const AddAddresss({super.key});

  @override
  State<AddAddresss> createState() => _AddAddresssState();
}

class _AddAddresssState extends State<AddAddresss> {
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController reachController = TextEditingController();
  Future<void> saveAddress() async {
    // Define the API endpoint
    String apiUrl = 'https://drycleaneo.com/CleaneoUser/api/AddAddress';
    print(Caddress);
    print(Floor);
    // Create the request body
    Map<String, String> requestBody = {
      'ID': UserData.read('ID').toString(),
      'Floor': Floor,
      'Caddress': Caddress,
      'Type': Type,
      'HTReach': HTReach,
    };

    // Convert the request body to JSON format
    String jsonBody = jsonEncode(requestBody);

    try {
      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Adress Saved succesfully');
        Navigator.pop(context);
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) {
        //   return AddressPage();
        // }));
        // You can handle the response here if needed
      } else {
        // Handle error if the request was not successful
        print('Failed to sign up. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request
      print('Error signing up: $e');
    }
  }

  Future<Object> fetchAddress() async {
    final url =
        'https://drycleaneo.com/CleaneoUser/api/showAddress/CleaneoUser000012';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        AddBook = jsonDecode(response.body);
      });
      print(AddressBook); // Decode the response
    } else {
      // OTP = (1000 + Random().nextInt(9000)).toString();
    }
    return true;
  }

  final List<String> addresses = [
    "Home",
    "Work",
    "Other",
  ];

  _saveSelectedAddress(int index, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedAddressIndex', index);
    await prefs.setString('selectedAddress', address);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Caddress = '';
  }

  String aselectedAddress = "Home";
  int selectedAddressIndex = -1;
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      height: mQuery.size.height * 0.7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mQuery.size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
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
              height: mQuery.size.height * 0.022,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mQuery.size.height * 0.022,
                  ),
                  Text(
                    "Complete address*",
                    style: TextStyle(
                        fontSize: mQuery.size.height * 0.0183,
                        fontFamily: 'SatoshiRegular',
                        color: Colors.black54),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchLocationScreen();
                        })).then((value) => setState(() {
                              Caddress = Caddress;
                            }));
                      },
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
                              enabled: false,
                              controller: addressController,
                              onSubmitted: (value) {
                                setState(() {
                                  Caddress = value;
                                });
                              },
                              style: TextStyle(fontFamily: 'SatoshiMedium'),
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: Caddress == ''
                                    ? 'Enter your address'
                                    : Caddress,
                                focusColor: Colors.grey,
                                border: InputBorder.none,
                                hintMaxLines: 1,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  Caddress = value;
                                });
                              },
                            ),
                          ),
                          // 66666666

                          // Text(
                          //   "CHANGE",
                          //   style: TextStyle(
                          //     color: Colors.red,
                          //     fontFamily:
                          //         'SatoshiMedium',
                          //     fontSize:
                          //         mQuery.size.height *
                          //             0.0173,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    "Floor (Optional)",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0183,
                      color: Colors.black54,
                      fontFamily: 'SatoshiRegular',
                    ),
                  ),
                  TextField(
                    controller: floorController,
                    onSubmitted: (value) {
                      setState(() {
                        Floor = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        Floor = value;
                      });
                    },
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
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0183,
                      color: Colors.black54,
                      fontFamily: 'SatoshiRegular',
                    ),
                  ),
                  TextField(
                    controller: reachController,
                    onChanged: (value) {
                      setState(() {
                        HTReach = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        HTReach = value;
                      });
                    },
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
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0183,
                      color: Colors.black54,
                      fontFamily: 'SatoshiRegular',
                    ),
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
                              Type = aselectedAddress;
                              _saveSelectedAddress(i,
                                  addresses[i]); // Update the selected address
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
                              color: selectedAddressIndex == i
                                  ? Colors.cyan
                                  : Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                addresses[i],
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.0195,
                                  color: selectedAddressIndex == i
                                      ? Colors.white
                                      : Colors.cyan,
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
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return AddressPage();
                      // }));
                      saveAddress();
                      print(UserID);
                      print(Floor);
                      // Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: mQuery.size.height * 0.054,
                      decoration: BoxDecoration(
                          color: Color(0xff29b2fe),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Save Address",
                          style: TextStyle(
                              fontSize: mQuery.size.height * 0.022,
                              fontFamily: 'SatoshiBold',
                              color: Colors.white),
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
  }
}

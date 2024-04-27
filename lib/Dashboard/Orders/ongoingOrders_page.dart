import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class OngoingOrdersPage extends StatefulWidget {
  const OngoingOrdersPage({Key? key}) : super(key: key);

  @override
  State<OngoingOrdersPage> createState() => _OngoingOrdersPageState();
}

class _OngoingOrdersPageState extends State<OngoingOrdersPage> {
  final List<Map<String, dynamic>> orders = [
    {
      "date": "Today",
      "orderNo": "#1234567890",
      "price": 100.00,
      "phoneNo": "+91 1234567890",
      "orderType": "Online Paid",
      "items": [
        "WASH - 01 x Shirts (Woman), 02 x T-Shirts (Men)",
        "WASH & STREAM IRON - 02 x Kurta Designer (Men), 01 x Bed-Sheet Single",
        "DRY CLEAN - 02 x Bath Mate"
      ],
      "status": "Picked Up",
    },
    {
      "date": "26 Jun 2021 at 6:00 pm",
      "orderNo": "#1234567891",
      "price": 120.00,
      "phoneNo": "+91 1234567891",
      "orderType": "Cash On Delivery",
      "items": [
        "WASH - 01 x Shirts (Woman), 02 x T-Shirts (Men)",
        "WASH & STREAM IRON - 02 x Kurta Designer (Men), 01 x Bed-Sheet Single",
        "DRY CLEAN - 02 x Bath Mate"
      ],
      "status": "In Process",
    },
    {
      "date": "26 Jun 2021 at 6:00 pm",
      "orderNo": "#1234567891",
      "price": 120.00,
      "phoneNo": "+91 1234567891",
      "orderType": "Cash On Delivery",
      "items": [
        "WASH - 01 x Shirts (Woman), 02 x T-Shirts (Men)",
        "WASH & STREAM IRON - 02 x Kurta Designer (Men), 01 x Bed-Sheet Single",
        "DRY CLEAN - 02 x Bath Mate"
      ],
      "status": "In Process",
    },
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    List<Widget> orderWidgets = [];

    for (var order in orders) {
      orderWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: mQuery.size.height * 0.015),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                order['date'],
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'SatoshiRegular',
                  fontSize: mQuery.size.height * 0.017,
                ),
              ),
            ),
            SizedBox(height: mQuery.size.height * 0.005),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Color(0xffe9f7ff),
                      padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.033,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/drawer-images/shopping-bag.png",
                            color: Color(0xff29b2fe),
                            width: mQuery.size.width * 0.06,
                          ),
                          SizedBox(width: mQuery.size.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order ${order['orderNo']}",
                                style: TextStyle(
                                  fontFamily: 'SatoshiMedium',
                                  fontSize: mQuery.size.height * 0.0165,
                                ),
                              ),
                              Text(
                                "Order Type : ${order['orderType']}",
                                style: TextStyle(
                                  fontFamily: 'SatoshiRegular',
                                  fontSize: mQuery.size.height * 0.013,
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            "₹ ${order['price'].toStringAsFixed(2)}",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.017,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.033,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ITEMS",
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'SatoshiRegular',
                              fontSize: mQuery.size.height * 0.016,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: order['items']
                                .map<Widget>((item) => Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: mQuery.size.height * 0.0155,
                                        fontFamily: 'SatoshiRegular',
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.033,
                        vertical: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rider Details",
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'SatoshiRegular',
                              fontSize: mQuery.size.height * 0.017,
                            ),
                          ),
                          Row(
                            children: [
                              ProfilePicture(
                                name: "",
                                radius: mQuery.size.width * 0.046,
                                fontsize: 10,
                                img:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA3tt2QdkGYJ1268iokp1HHB3XB6PNaAZD_pssz3zFVg&s",
                              ),
                              SizedBox(width: mQuery.size.width * 0.015),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Raj(ID 123456)",
                                    style: TextStyle(
                                      fontSize: mQuery.size.height * 0.017,
                                      fontFamily: 'SatoshiMedium',
                                    ),
                                  ),
                                  Text(
                                    "${order['phoneNo']}",
                                    style: TextStyle(
                                      fontSize: mQuery.size.height * 0.015,
                                      fontFamily: 'SatoshiRegular',
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                width: mQuery.size.width * 0.18,
                                height: mQuery.size.height * 0.03,
                                decoration: BoxDecoration(
                                  color: order['status'] == "Picked Up"
                                      ? Color(0xffffeced)
                                      : Color(0xffe9f7ff),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    order['status'],
                                    style: TextStyle(
                                      color: order['status'] == "Picked Up"
                                          ? Colors.red
                                          : Color(0xff29b2fe),
                                      fontSize: mQuery.size.height * 0.014,
                                      fontFamily: 'SatoshiMedium',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Track Order",
                                style: TextStyle(
                                  color: Color(0xff29b2fe),
                                  fontSize: mQuery.size.height * 0.017,
                                  fontFamily: 'SatoshiRegular',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: mQuery.size.height * 0.015),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: orderWidgets,
      ),
    );
  }
}

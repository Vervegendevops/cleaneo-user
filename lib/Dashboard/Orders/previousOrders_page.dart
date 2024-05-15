import 'package:flutter/material.dart';

class PreviousOrdersPage extends StatefulWidget {
  const PreviousOrdersPage({Key? key}) : super(key: key);

  @override
  State<PreviousOrdersPage> createState() => _PreviousOrdersPageState();
}

class _PreviousOrdersPageState extends State<PreviousOrdersPage> {
  List<Map<String, dynamic>> orders = [
    {
      'orderNo': "#1234567890",
      'date': "04 Jul 2021 at 8:09 pm",
      'price': 100.00,
      'rating': 4.5,
      'items': [
        "WASH - 01 x Shirts (Woman), 02 x T-Shirts (Men)",
        "WASH & STREAM IRON - 02 x Kurta Designer (Men), 01 x Bed-Sheet Single",
        "DRY CLEAN - 02 x Bath Mate",
      ],
    },
    {
      'orderNo': "#1234567890",
      'date': "04 Jul 2021 at 8:09 pm",
      'price': 100.00,
      'rating': 4.5,
      'items': [
        "WASH - 01 x Shirts (Woman), 02 x T-Shirts (Men)",
        "WASH & STREAM IRON - 02 x Kurta Designer (Men), 01 x Bed-Sheet Single",
        "DRY CLEAN - 02 x Bath Mate",
      ],
    },
    {
      'orderNo': "#0987654321",
      'date': "26 Jun 2021 at 6:00 pm",
      'price': 150.00,
      'rating': null,
      'items': [
        "WASH - 01 x Shirts (Woman), 02 x T-Shirts (Men)",
        "WASH & STREAM IRON - 02 x Kurta Designer (Men), 01 x Bed-Sheet Single",
        "DRY CLEAN - 02 x Bath Mate",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var order in orders)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mQuery.size.height * 0.018),
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
                    width: double.infinity,
                    height: mQuery.size.height * 0.26,
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
                          height: mQuery.size.height * 0.045,
                          padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.033,
                          ),
                          color: Color(0xffe9f7ff),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/drawer-images/shopping-bag.png",
                                color: Color(0xff29b2fe),
                                width: mQuery.size.width * 0.06,
                              ),
                              SizedBox(width: mQuery.size.width * 0.02),
                              Text(
                                "Order ${order['orderNo']}",
                                style: TextStyle(
                                  fontFamily: 'SatoshiMedium',
                                  fontSize: mQuery.size.height * 0.0165,
                                ),
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
                        SizedBox(height: mQuery.size.height * 0.01),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.033,
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
                                children: [
                                  for (var item in order['items'])
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: item.split('-')[0].trim(),
                                            style: TextStyle(
                                              fontFamily: 'SatoshiMedium',
                                              color: Colors.black,
                                              fontSize:
                                                  mQuery.size.height * 0.0155,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '-${item.split('-')[1].trim()}',
                                            style: TextStyle(
                                              fontSize:
                                                  mQuery.size.height * 0.0155,
                                              fontFamily: 'SatoshiRegular',
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
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.033,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: mQuery.size.width * 0.18,
                                height: mQuery.size.height * 0.03,
                                decoration: BoxDecoration(
                                  color: Color(0xffe5f5e8),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    "Delivered",
                                    style: TextStyle(
                                      color: Color(0xff009c1a),
                                      fontSize: mQuery.size.height * 0.014,
                                      fontFamily: 'SatoshiMedium',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              order['rating'] != null
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: mQuery.size.width * 0.05,
                                          color: Color(0xff29b2fe),
                                        ),
                                        SizedBox(
                                          width: mQuery.size.width * 0.01,
                                        ),
                                        Text(
                                          "${order['rating']}",
                                          style: TextStyle(
                                            fontFamily: 'SatoshiMedium',
                                            fontSize:
                                                mQuery.size.height * 0.0155,
                                          ),
                                        ),
                                      ],
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        // Implement your review submission logic here
                                      },
                                      child: Text(
                                        "SUBMIT REVIEW",
                                        style: TextStyle(
                                          color: Color(0xff29b2fe),
                                          fontFamily: 'SatoshiMedium',
                                          fontSize: mQuery.size.height * 0.014,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

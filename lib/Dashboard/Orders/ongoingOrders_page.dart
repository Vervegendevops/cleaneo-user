import 'dart:convert';
import 'package:cleaneo_user/Dashboard/Orders/tracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> orders = [];

class OnGoingOrders extends StatefulWidget {
  final String userId;

  OnGoingOrders({super.key, required this.userId});

  @override
  State<OnGoingOrders> createState() => _OnGoingOrdersState();
}

class _OnGoingOrdersState extends State<OnGoingOrders> {
  List<TextDto2> orderList = [
    TextDto2("Your order has been placed", ""),
  ];

  List<TextDto2> shippedList = [
    TextDto2("Your order has been shipped", ""),
  ];

  List<TextDto2> outOfDeliveryList = [
    TextDto2("Your order is out for delivery", ""),
  ];

  List<TextDto2> deliveredList = [
    TextDto2("Your order has been delivered", ""),
  ];
  final authentication = GetStorage();

  Future<List<Map<String, dynamic>>> fetchUserOrders(String userId) async {
    final String apiUrl =
        'https://drycleaneo.com/CleaneoUser/api/user-orders/$userId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse JSON response directly into a list of maps
        final List<dynamic> jsonData = json.decode(response.body);

        // Convert JSON data to a list of maps
        orders = List<Map<String, dynamic>>.from(jsonData);
        print(response.body);
        print("---------------*********----------------");
        return orders;
      } else {
        // If the response status code is not 200, throw an exception or handle the error accordingly.
        throw Exception('Failed to fetch user orders: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      throw Exception('Error fetching user orders: $e');
    }
  }

  List<Map<String, dynamic>> parseItems(String itemsJson) {
    final List<dynamic> jsonData = json.decode(itemsJson);
    return List<Map<String, dynamic>>.from(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchUserOrders(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // Data loaded successfully
          List<Map<String, dynamic>> orders = snapshot.data!;
          // Build your UI using the fetched data
          return SingleChildScrollView(
            child: Column(
              children: orders.map((order) {
                // Extract basic order details
                final orderId = order['OrderID'];
                final pickupDate = order['PickupDate'];
                final deliveryDate = order['DeliveryDate'];
                final deliveryTime = order['DeliveryTime'];

                // Parse items JSON string into a list of maps
                List<Map<String, dynamic>> items =
                    List<Map<String, dynamic>>.from(
                        json.decode(order['Items']));

                return GestureDetector(
                  onTap: () {
                    showCustomModalBottomSheet(context, order);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey
                              .withOpacity(0.5), // color of the shadow
                          spreadRadius: 0, // spread radius
                          blurRadius: 5, // blur radius
                          offset:
                              const Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: mQuery.size.height * 0.05,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE9F8FF),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order ID: $orderId',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SatoshiBold'),
                                ),
                                Text(
                                  '₹ ${order['UserTotalCost']}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SatoshiBold'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SatoshiBold'),
                              ),
                              Text(
                                'Pickup Date: $pickupDate',
                                style: const TextStyle(
                                    fontFamily: 'SatoshiMedium'),
                              ),
                              Text(
                                'Delivery Date: $deliveryDate',
                                style: const TextStyle(
                                    fontFamily: 'SatoshiMedium'),
                              ),
                              Text(
                                'Delivery Time: $deliveryTime',
                                style: const TextStyle(
                                    fontFamily: 'SatoshiMedium'),
                              ),
                              const SizedBox(height: 10),
                              // GestureDetector(
                              //   onTap: () {
                              //     print('test');
                              //     showCustomModalBottomSheet(context, order);
                              //   },
                              //   child: const Text(
                              //     'Show More',
                              //     style: TextStyle(
                              //         color: Colors.blue,
                              //         fontWeight: FontWeight.bold,
                              //         fontFamily: 'SatoshiBold'),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        /*
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length > 5 ? 5 : items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Text(
                                '${item['name']} ${item['price']} X${item['quantity']}',
                              );
                            },
                          ),
                        ),
                        if (items.length > 5)
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: ListView.builder(
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        final item = items[index];
                                        return Text(
                                          '${item['type']}: ${item['name']} ${item['price']} X${item['quantity']}',
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text('See More'),
                          ),
                          */
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  void showCustomModalBottomSheet(
      BuildContext context, Map<String, dynamic> order) {
    int Ccount = jsonDecode(order['status']).length;
    List<dynamic> statusss = jsonDecode(order['status']);
    String formatDateString(String dateString) {
      DateTime dateTime = DateTime.parse(dateString);
      DateFormat formatter = DateFormat("d MMMM, y 'at' h:mm a");
      return formatter.format(dateTime);
    }

    final List<OrderStatus> orderStatuses = [
      OrderStatus(
          "Pending ",
          "The order has been placed but is not yet processed.",
          Ccount >= 1 ? true : false,
          // "(17 June 2023)"
          Ccount >= 1 ? '${formatDateString(statusss[0]['created_at'])}' : ''),
      OrderStatus(
          "Pickup by delivery agent ",
          "The delivery agent has been assigned to pick up the order.",
          Ccount >= 2 ? true : false,
          Ccount >= 2 ? '${statusss[0]['created_at']}' : ''),
      OrderStatus(
          "Order reached to vendor",
          "The order has reached the vendor for processing.",
          Ccount >= 3 ? true : false,
          Ccount >= 3 ? '${statusss[0]['created_at']}' : ''),
      OrderStatus(
          "Order in progress",
          "The vendor is currently preparing the order.",
          Ccount >= 4 ? true : false,
          Ccount >= 4 ? '${statusss[0]['created_at']}' : ''),
      OrderStatus(
          "Order ready to deliver",
          "The order is ready and awaiting pickup by the delivery agent.",
          Ccount >= 5 ? true : false,
          Ccount >= 5 ? '${statusss[0]['created_at']}' : ''),
      OrderStatus(
          "On its way",
          "The delivery agent has picked up the order from the vendor.",
          Ccount >= 6 ? true : false,
          Ccount >= 6 ? '${statusss[0]['created_at']}' : ''),
      OrderStatus(
          "Order delivered to user",
          "The order has been delivered to the user properly.",
          Ccount >= 7 ? true : false,
          Ccount >= 7 ? '${statusss[0]['created_at']}' : ''),
    ];
    List<Map<String, dynamic>> items = parseItems(order['Items']);
    var mQuery = MediaQuery.of(context);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding:
              const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SatoshiBold',
                ),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.3), // color of the shadow
                            spreadRadius: 0, // spread radius
                            blurRadius: 5, // blur radius
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: mQuery.size.width * 0.5,
                            padding: EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SatoshiBold'),
                                ),
                                Text(
                                  '${order['OrderID']}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'SatoshiMedium'),
                                ),
                                SizedBox(
                                  height: mQuery.size.height * 0.01,
                                ),
                                Text(
                                  'Delivery Date ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SatoshiBold'),
                                ),
                                Text(
                                  '${order['DeliveryDate']}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'SatoshiMedium'),
                                ),
                                SizedBox(
                                  height: mQuery.size.height * 0.01,
                                ),
                                Text(
                                  'Payment Mode ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'SatoshiBold'),
                                ),
                                Text(
                                  '${order['PaymentMode']}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      fontFamily: 'SatoshiMedium'),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pickup Date ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'SatoshiBold'),
                                  ),
                                  Text(
                                    '${order['PickupDate']}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                        fontFamily: 'SatoshiMedium'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mQuery.size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery Time ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'SatoshiBold'),
                                      ),
                                      Text(
                                        '${order['DeliveryTime']}',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                            fontFamily: 'SatoshiMedium'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mQuery.size.height * 0.01,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      height: 250,
                      child: ListView.builder(
                        itemCount: orderStatuses.length,
                        itemBuilder: (context, index) {
                          return OrderStatusWidget(
                            status: orderStatuses[index],
                            isFirst: index == 0,
                            isLast: index == orderStatuses.length - 1,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey
                                .withOpacity(0.3), // color of the shadow
                            spreadRadius: 0, // spread radius
                            blurRadius: 5, // blur radius
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Items',
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: 'SatoshiBold'),
                          ),
                          // Display list of items
                          SizedBox(height: 8.0),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: items.map((item) {
                              final int quantity =
                                  int.parse(item['quantity'].toString());
                              final double price =
                                  double.parse(item['price'].toString());
                              final double totalPrice = quantity * price;

                              return Row(
                                children: [
                                  Text(
                                    '•  ${item['quantity']}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'SatoshiBold'),
                                  ),
                                  Text(
                                    ' ${item['name']}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'SatoshiBold'),
                                  ),

                                  SizedBox(
                                    width: mQuery.size.width * 0.016,
                                  ),
                                  // Text(
                                  //   '${item['quantity']} x '
                                  //       '₹${item['price']}',
                                  //   style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontFamily: 'SatoshiMedium'
                                  //   ),
                                  // ),
                                  Expanded(child: SizedBox()),

                                  Text(
                                    "₹${totalPrice}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'SatoshiMedium'),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),

                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SatoshiBold'),
                              ),
                              Text(
                                "₹${items.fold(0, (sum, item) {
                                  final int quantity =
                                      int.parse(item['quantity'].toString());
                                  final double price =
                                      double.parse(item['price'].toString());
                                  return sum + (quantity * price).toInt();
                                }).toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mQuery.size.height * 0.032),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: mQuery.size.width * 0.7,
                            height: mQuery.size.height * 0.05,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                              child: Text(
                                "Close",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'SatoshiBold'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  final OrderStatus status;
  final bool isFirst;
  final bool isLast;

  const OrderStatusWidget({
    Key? key,
    required this.status,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (!isFirst) ...[
              Container(
                height: 20,
                width: 2,
                color: status.isCompleted ? Colors.green : Colors.grey,
              ),
            ],
            Icon(
              status.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: status.isCompleted ? Colors.green : Colors.grey,
            ),
            if (!isLast) ...[
              Container(
                height: 20,
                width: 2,
                color: status.isCompleted ? Colors.green : Colors.grey,
              ),
            ],
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    status.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    status.date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  status.subtitle,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderStatus {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final String date;

  OrderStatus(
    this.title,
    this.subtitle,
    this.isCompleted,
    this.date,
  );
}

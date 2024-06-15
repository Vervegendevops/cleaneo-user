import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

List<Map<String, dynamic>> orders = [];

class PreviousOrdersPage extends StatelessWidget {
  final authentication = GetStorage();
  final String userId;

  PreviousOrdersPage({required this.userId});

  Future<List<Map<String, dynamic>>> fetchUserOrders(String userId) async {
    final String apiUrl =
        'https://drycleaneo.com/CleaneoUser/api/user-orders/$userId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse JSON response directly into a list of maps
        final List<dynamic> jsonData = json.decode(response.body);

        // Filter orders based on the length of the "status" field
        List<Map<String, dynamic>> filteredOrders =
            List<Map<String, dynamic>>.from(jsonData.where((order) =>
                (json.decode(order['status']) as List<dynamic>).length == 2));

        return filteredOrders;
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
      future: fetchUserOrders(userId),
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

                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // color of the shadow
                        spreadRadius: 0, // spread radius
                        blurRadius: 5, // blur radius
                        offset: Offset(0, 0), // changes position of shadow
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
                              style:
                                  const TextStyle(fontFamily: 'SatoshiMedium'),
                            ),
                            Text(
                              'Delivery Date: $deliveryDate',
                              style:
                                  const TextStyle(fontFamily: 'SatoshiMedium'),
                            ),
                            Text(
                              'Delivery Time: $deliveryTime',
                              style:
                                  const TextStyle(fontFamily: 'SatoshiMedium'),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                showCustomModalBottomSheet(context, order);
                              },
                              child: const Text(
                                'Show More',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SatoshiBold'),
                              ),
                            ),
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
    List<Map<String, dynamic>> items = parseItems(order['Items']);
    var mQuery = MediaQuery.of(context);
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // color of the shadow
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
                      Text(
                        'Order ID: ${order['OrderID']}',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SatoshiMedium'),
                      ),
                      Text(
                        'Pickup Date: ${order['PickupDate']}',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SatoshiMedium'),
                      ),
                      Text(
                        'Delivery Date: ${order['DeliveryDate']}',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SatoshiMedium'),
                      ),
                      Text(
                        'Delivery Time: ${order['DeliveryTime']}',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'SatoshiMedium'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // color of the shadow
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
                      Text(
                        'Items:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'SatoshiBold',
                        ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• ${item['name']}: ${item['quantity']} x ₹${item['price']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'SatoshiMedium'),
                              ),
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
          ),
        );
      },
    );
  }
}

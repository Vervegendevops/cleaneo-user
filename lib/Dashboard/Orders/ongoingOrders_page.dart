import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

List<Map<String, dynamic>> orders = [];

class OnGoingOrders extends StatelessWidget {
  final authentication = GetStorage();
  final String userId;

  OnGoingOrders({required this.userId});

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

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchUserOrders(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
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
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order ID: $orderId'),
                      Text('Pickup Date: $pickupDate'),
                      Text('Delivery Date: $deliveryDate'),
                      Text('Delivery Time: $deliveryTime'),
                      SizedBox(height: 10),
                      Text(
                        'Items:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length > 5 ? 5 : items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Text(
                            '${item['type']}: ${item['name']} ${item['price']} X${item['quantity']}',
                          );
                        },
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
}

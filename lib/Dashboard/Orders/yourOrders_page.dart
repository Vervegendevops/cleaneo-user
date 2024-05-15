import 'dart:convert';
import 'package:cleaneo_user/Dashboard/Orders/ongoingOrders_page.dart';
import 'package:cleaneo_user/Dashboard/Orders/previousOrders_page.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

// List<Map<String, dynamic>> orders = [];
final authentication = GetStorage();
// Future<List<Map<String, dynamic>>> fetchUserOrders(String userId) async {
//   final String apiUrl =
//       'https://drycleaneo.com/CleaneoUser/api/user-orders/$userId';

//   try {
//     final response = await http.get(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       // Parse JSON response directly into a list of maps
//       final List<dynamic> jsonData = json.decode(response.body);

//       // Convert JSON data to a list of maps
//       List<Map<String, dynamic>> orders =
//           List<Map<String, dynamic>>.from(jsonData);
//       print(orders);
//       print("---------------");
//       return orders;
//     } else {
//       // make a listview builder
//       // If the response status code is not 200, throw an exception or handle the error accordingly.
//       throw Exception('Failed to fetch user orders: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle exceptions if any occur during the request.
//     throw Exception('Error fetching user orders: $e');
//   }
// }

class YourOrdersPage extends StatefulWidget {
  const YourOrdersPage({Key? key}) : super(key: key);

  @override
  State<YourOrdersPage> createState() => _YourOrdersPageState();
}

class _YourOrdersPageState extends State<YourOrdersPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  bool _isDropdownOpen = false;
  int _selectedRowIndex = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
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
                          SizedBox(width: mQuery.size.width * 0.045),
                          Row(
                            children: [
                              Text(
                                "Your Orders",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.027,
                                  color: Colors.white,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       fetchUserOrders('CleaneoUser000012');
                    //     },
                    //     child: Text("mQuery")),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        tabs: [
                          const Tab(
                            text: "Ongoing",
                          ),
                          const Tab(text: "Previous"),
                        ],
                        labelColor: const Color(0xff29b2fe),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: const Color(0xff29b2fe),
                        labelStyle: TextStyle(
                          fontSize: mQuery.size.height * 0.023,
                          fontFamily: 'SatoshiBold',
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: authentication.read('Authentication') == 'Guest'
                          ? mQuery.size.height * 0.47
                          : mQuery.size.height * 0.67,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: authentication.read('Authentication') == 'Guest'
                          ? Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.17,
                                ),
                                SvgPicture.asset(
                                  'assets/images/noorders.svg',
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                              ],
                            )
                          : TabBarView(
                              controller: _tabController,
                              children: [
                                OnGoingOrders(
                                  userId: 'CleaneoUser000012',
                                ),
                                const PreviousOrdersPage(),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

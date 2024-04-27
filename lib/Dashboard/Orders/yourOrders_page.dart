import 'package:cleaneo_user/Dashboard/Orders/ongoingOrders_page.dart';
import 'package:cleaneo_user/Dashboard/Orders/previousOrders_page.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

final authentication = GetStorage();

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
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: mQuery.size.width * 0.045,
                                    right: mQuery.size.width * 0.045,
                                  ),
                                  child: const OngoingOrdersPage(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: mQuery.size.width * 0.045,
                                    right: mQuery.size.width * 0.045,
                                  ),
                                  child: const PreviousOrdersPage(),
                                ),
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

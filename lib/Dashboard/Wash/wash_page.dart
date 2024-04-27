import 'package:cleaneo_user/Dashboard/Wash/Select%20Vendor/chooseVendor_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/byweight_page.dart';
import 'package:cleaneo_user/Dashboard/Wash/quantity_wise_page.dart';
import 'package:cleaneo_user/pages/dryclean_page.dart';
import 'package:flutter/material.dart';

class WashPage extends StatefulWidget {
  const WashPage({Key? key}) : super(key: key);

  @override
  State<WashPage> createState() => _WashPageState();
}

class _WashPageState extends State<WashPage>
    with SingleTickerProviderStateMixin {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChooseVendorPage();
                                }));
                              },
                              child:
                                  Icon(Icons.arrow_back, color: Colors.white),
                            ),
                            SizedBox(width: mQuery.size.width * 0.045),
                            Row(
                              children: [
                                Text(
                                  "Wash",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.027,
                                      color: Colors.white,
                                      fontFamily: 'SatoshiBold'),
                                ),
                                SizedBox(
                                  width: mQuery.size.width * 0.02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isDropdownOpen = !_isDropdownOpen;
                                    });
                                  },
                                  child: Icon(Icons.arrow_drop_down,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(text: "Quantity Wise"),
                            Tab(text: "By Weight"),
                          ],
                          labelColor: Color(0xff29b2fe),
                          indicatorColor: Color(0xff29b2fe),
                          labelStyle: TextStyle(
                              fontSize: mQuery.size.height * 0.023,
                              fontFamily: 'SatoshiBold'),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: mQuery.size.height,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            QuantityWisePage(),
                            ByWeightPage(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isDropdownOpen)
            Positioned(
              top: mQuery.size.height * 0.14,
              left: mQuery.size.height * 0.08,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isDropdownOpen = false;
                  });
                },
                child: Container(
                  height: mQuery.size.height * 0.24,
                  width: mQuery.size.width * 0.48,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.2,
                        blurRadius: 7,
                        offset:
                            Offset(0, 0), // changes the position of the shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: mQuery.size.height * 0.001,
                        ),
                        _buildDropdownRow("Wash & Iron", 0),
                        SizedBox(height: mQuery.size.height * 0.001),
                        _buildDropdownRow("Stream Iron", 1),
                        SizedBox(height: mQuery.size.height * 0.001),
                        _buildDropdownRow("Dry Clean", 2),
                        SizedBox(height: mQuery.size.height * 0.001),
                        _buildDropdownRow("Premium", 3),
                        SizedBox(height: mQuery.size.height * 0.001),
                        _buildDropdownRow("Shoe & Bag Care", 4),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownRow(String text, int index) {
    var mQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRowIndex = index;
          _isDropdownOpen = false;
        });
        if (index == 2) {
          // If "Dry Clean" is tapped
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DryCleanPage(); // Navigate to DrycleanPage
          }));
        }
      },
      child: Container(
        color:
            _selectedRowIndex == index ? Color(0xffd4f0ff) : Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: mQuery.size.height * 0.008),
          child: Row(
            children: [
              Image.asset(
                index == 0
                    ? "assets/images/Wash & Iron.png"
                    : index == 1
                        ? "assets/images/Steam Iron.png"
                        : index == 2
                            ? "assets/images/Dry Clean.png"
                            : index == 3
                                ? "assets/images/Premium Wash.png"
                                : "assets/images/Shoe & Bag Care.png",
                width: index == 3 ? 28 : 24,
              ),
              SizedBox(width: mQuery.size.width * 0.01),
              Text(
                text,
                style: TextStyle(
                    fontSize: mQuery.size.height * 0.018,
                    fontFamily: 'SatoshiMedium'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

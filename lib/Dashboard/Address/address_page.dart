import 'package:cleaneo_user/Dashboard/Address/deliveryInstructions_page.dart';
import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    var distance = 1.2;
    var address = "B-702, Sarthak the Sarjak, Bhaijipura Chokdi \n "
        "PDPU Crossroad , Beside Pulse Mall, Seventh \n "
        "Floor , Kudasan, Gujrat, India";
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: Container(
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
                    "My Addresses",
                    style: TextStyle(
                        fontSize: mQuery.size.height * 0.027,
                        color: Colors.white,
                        fontFamily: 'SatoshiBold'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Container(
                                width: mQuery.size.width * 0.045,
                                height: mQuery.size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: Color(0xff29b2fe),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: mQuery.size.width * 0.04,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mQuery.size.width * 0.02,
                              ),
                              Text(
                                "Add Address",
                                style: TextStyle(
                                    fontSize: mQuery.size.height * 0.0195,
                                    fontFamily: 'SatoshiBold'),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mQuery.size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.045),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: mQuery.size.height * 0.192,
                              padding: EdgeInsets.symmetric(
                                  horizontal: mQuery.size.width * 0.04),
                              decoration: BoxDecoration(
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
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: mQuery.size.height * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: mQuery.size.width * 0.055,
                                          height: mQuery.size.height * 0.04,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xff29b2fe)),
                                          child: Center(
                                            child: Icon(
                                              Icons.home,
                                              color: Colors.white,
                                              size: mQuery.size.width * 0.04,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: mQuery.size.width * 0.032,
                                        ),
                                        Text(
                                          "Home",
                                          style: TextStyle(
                                              fontSize:
                                                  mQuery.size.height * 0.0185,
                                              fontFamily: 'SatoshiBold'),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Container(
                                          width: mQuery.size.width * 0.04,
                                          height: mQuery.size.height * 0.05,
                                          decoration: BoxDecoration(
                                              color: Color(0xff29b2fe),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: mQuery.size.width * 0.03,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: mQuery.size.width * 0.028,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(
                                          width: mQuery.size.width * 0.028,
                                        ),
                                        Icon(
                                          Icons.delete,
                                          color: Colors.black54,
                                        )
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "$distance km",
                                            style: TextStyle(
                                                fontFamily: 'SatoshiBold',
                                                fontSize:
                                                    mQuery.size.height * 0.015),
                                          ),
                                          SizedBox(
                                            width: mQuery.size.width * 0.032,
                                          ),
                                          Text(
                                            "$address",
                                            style: TextStyle(
                                                fontSize:
                                                    mQuery.size.height * 0.015,
                                                color: Colors.black54,
                                                fontFamily: 'SatoshiRegular'),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: mQuery.size.height * 0.023,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: mQuery.size.width * 0.14),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return DeliveryInstructionPage();
                                          }));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "View Delivery Instructions",
                                              style: TextStyle(
                                                  color: Color(0xff29b2fe),
                                                  fontFamily: 'SatoshiBold',
                                                  fontSize: mQuery.size.height *
                                                      0.018),
                                            ),
                                            SizedBox(
                                              width: mQuery.size.width * 0.02,
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: Color(0xff29b2fe),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    },
                    child: Container(
                      width: double.infinity,
                      height: mQuery.size.height * 0.06,
                      color: Colors.white,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.symmetric(
                            horizontal: mQuery.size.width * 0.045),
                        decoration: BoxDecoration(
                            color: Color(0xff29b2fe),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            "Save Address",
                            style: TextStyle(
                                fontSize: mQuery.size.height * 0.02,
                                color: Colors.white,
                                fontFamily: 'SatoshiBold'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mQuery.size.height * 0.02,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({Key? key}) : super(key: key);

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    var refer = "CLEANEO12345678";
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
                    "Refer a Friend",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.027,
                      color: Colors.white,
                      fontFamily: 'SatoshiBold',
                    ),
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
                child: Padding(
                  padding: EdgeInsets.only(
                    top: mQuery.size.height * 0.03,
                    left: mQuery.size.width * 0.045,
                    right: mQuery.size.width * 0.045,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Refer CLEANEO to a \nfriend & get 10% OFF",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.023,
                            fontFamily: 'SatoshiMedium',
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.03,
                        ),
                        Text(
                          "Invite a friend to CLEANEO & the enjoy \n the discount on any one of your "
                          "orders \n         on 1st order of your friend",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.018,
                            color: Colors.black54,
                            fontFamily: 'SatoshiRegular',
                          ),
                        ),
                        Image.asset("assets/images/enjoy.png"),
                        SizedBox(
                          height: mQuery.size.height * 0.055,
                        ),
                        Text(
                          "Share your referal code",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.02,
                            fontFamily: 'SatoshiMedium',
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.05,
                        ),
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
                            decoration: BoxDecoration(
                                color: Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: mQuery.size.width * 0.035,
                                ),
                                Text(
                                  "$refer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: mQuery.size.height * 0.024,
                                    fontFamily: 'SatoshiMedium',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.02,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

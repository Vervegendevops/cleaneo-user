import 'package:cleaneo_user/Dashboard/Address/address_page.dart';
import 'package:cleaneo_user/Dashboard/Notifications/notification_page.dart';
import 'package:cleaneo_user/Dashboard/Orders/yourOrders_page.dart';
import 'package:cleaneo_user/Dashboard/Wallet/wallet_page.dart';
import 'package:cleaneo_user/Dashboard/home_page.dart';
import 'package:cleaneo_user/Dashboard/offers_page.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/Help/help_page.dart';
import 'package:cleaneo_user/Onboarding%20page/login.dart';
import 'package:cleaneo_user/Onboarding%20page/welcome.dart';
import 'package:cleaneo_user/Payment/manage_cards_page.dart';
import 'package:cleaneo_user/pages/donate.dart';
import 'package:cleaneo_user/pages/myprofile.dart';
import 'package:cleaneo_user/pages/refer_page.dart';
import 'package:cleaneo_user/pages/review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get_storage/get_storage.dart';

final authentication = GetStorage();

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    var versionNo = 1.1;
    var userName = UserData.read('name');
    var phoneNo = authentication.read('Authentication') == 'Guest'
        ? ""
        : "(+91) 9978997899";
    return Drawer(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyProfilePage();
                }));
              },
              child: Container(
                width: double.infinity,
                color: Color(0xfff3fbff),
                height: mQuery.size.height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mQuery.size.height * 0.058),
                    GestureDetector(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: mQuery.size.width * 0.028,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ProfilePicture(
                                name: authentication.read('Authentication') ==
                                        'Guest'
                                    ? "Welcome Guest"
                                    : '',
                                radius: 20,
                                fontsize: 10,

                                // img:
                                //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwKKzV4oKveaDEmBr38LXuMWTho1d1-mjOOcjau6XJ1A&s",
                              ),
                              SizedBox(
                                width: mQuery.size.width * 0.024,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: mQuery.size.height * 0.02,
                                      ),
                                      Text(
                                        authentication.read('Authentication') ==
                                                'Guest'
                                            ? "Welcome Guest"
                                            : "$userName",
                                        style: TextStyle(
                                            fontSize:
                                                mQuery.size.height * 0.022,
                                            fontFamily: 'SatoshiBold'),
                                      ),
                                      SizedBox(
                                        width: mQuery.size.width * 0.05,
                                      ),
                                      authentication.read('Authentication') ==
                                              'Guest'
                                          ? Container()
                                          : GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return MyProfilePage();
                                                }));
                                              },
                                              child: Image.asset(
                                                  "assets/images/drawer-images/edit.png",
                                                  color: Color(0xff29b2fe),
                                                  width: mQuery.size.width *
                                                      0.045),
                                            )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      authentication.read('Authentication') ==
                                              'Guest'
                                          ? Container()
                                          : Icon(
                                              Icons.phone_android,
                                              size: mQuery.size.width * 0.05,
                                            ),
                                      authentication.read('Authentication') ==
                                              'Guest'
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  authentication.write(
                                                      'Authentication', '');
                                                });
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoginPage();
                                                }));
                                              },
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                  color: Color(0xff29b2fe),
                                                ),
                                              ),
                                            )
                                          : Text(
                                              "$phoneNo",
                                              style: TextStyle(
                                                  fontSize: mQuery.size.height *
                                                      0.0185,
                                                  fontFamily: 'SatoshiMedium'),
                                            ),
                                      SizedBox(
                                        width: mQuery.size.width * 0.02,
                                      ),
                                      authentication.read('Authentication') ==
                                              'Guest'
                                          ? Container()
                                          : Container(
                                              width: mQuery.size.width * 0.04,
                                              height: mQuery.size.height * 0.04,
                                              decoration: const BoxDecoration(
                                                color: Color(0xff009c1a),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                              ),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.3,
                      blurRadius: 10,
                      offset:
                          Offset(3, 3), // changes the position of the shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }));
                          },
                          child: ListTile(
                            leading: Image.asset(
                                "assets/images/drawer-images/dashboard.png",
                                color: Color(0xff29b2fe),
                                width: mQuery.size.width * 0.065),
                            title: Text(
                              "Dashboard",
                              style: TextStyle(
                                fontFamily: 'SatoshiMedium',
                                fontSize: mQuery.size.height * 0.0212,
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return YourOrdersPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/shopping-bag.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Your Orders",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          authentication.read('Authentication') == 'Guest'
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      title: Text('Login Required'),
                                      content: Text(
                                          'To add Address to your Address Book . \nPlease Login'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xff29b2fe))),
                                            onPressed: () {
                                              setState(() {
                                                authentication.write(
                                                    'Authentication', '');
                                              });
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return LoginPage();
                                              }));
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    );
                                  },
                                )
                              : Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return AddressPage();
                                }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/location_icon.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Address Book",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return NotificationsPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/bell.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Notifications",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Donate();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/heart.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Impact",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WalletPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/wallet.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Wallet",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ManageCardsPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/credit-card.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Manage Cards",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OffersPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/offers.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Offers",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          authentication.read('Authentication') == 'Guest'
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      title: Text('Login Required'),
                                      content:
                                          Text('Please log in to continue.'),
                                      actions: <Widget>[
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xff29b2fe))),
                                            onPressed: () {
                                              setState(() {
                                                authentication.write(
                                                    'Authentication', '');
                                              });
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return LoginPage();
                                              }));
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))
                                      ],
                                    );
                                  },
                                )
                              : Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                  return ReferPage();
                                }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/gift.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Refer and Earn",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ReviewPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/star.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Reviews",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HelpPage();
                          }));
                        },
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/drawer-images/help.png",
                              color: Color(0xff29b2fe),
                              width: mQuery.size.width * 0.06),
                          title: Text(
                            "Help",
                            style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.0212,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: mQuery.size.height * 0.02),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.045),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff29b2fe),
                          borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      height: mQuery.size.height * 0.04,
                      child: Center(
                        child: Text(
                          "Join us as a partner",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: mQuery.size.height * 0.02,
                              fontFamily: 'SatoshiBold'),
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: mQuery.size.width * 0.045),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    authentication.write('Authentication', '');
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return WelcomePage();
                                    }));
                                  },
                                  child: Text(
                                    authentication.read('Authentication') ==
                                            "Guest"
                                        ? "Sign out from Guest"
                                        : "Sign Out",
                                    style: TextStyle(
                                        fontSize: mQuery.size.height * 0.022,
                                        color: Colors.black,
                                        fontFamily: 'SatoshiBold'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.0075,
                        ),
                        Text(
                          "CLEANEO V$versionNo",
                          style: TextStyle(
                              fontSize: mQuery.size.height * 0.015,
                              fontFamily: 'SatoshiRegular'),
                        ),
                      ],
                    ),
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

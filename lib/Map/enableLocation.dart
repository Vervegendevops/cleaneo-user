import 'package:cleaneo_user/Map/map.dart';
import 'package:cleaneo_user/end.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print("permision :  $permission");
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return mapPage();
      }));
    } else if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied ||
        permission == LocationPermission.unableToDetermine) {
      print('denied');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return mapPage();
        }));
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
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
                      Future<void> checkLocationPermission2() async {
                        LocationPermission permission =
                            await Geolocator.checkPermission();
                        print("permision :  $permission");
                        if (permission == LocationPermission.whileInUse ||
                            permission == LocationPermission.always) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return end();
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Enable location services to continue.'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(16.0),
                            ),
                          );
                          // permission = await Geolocator.requestPermission();
                        }
                      }

                      checkLocationPermission2();

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return HomePage();
                      // }));
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  Text(
                    "Enable Location Services",
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
                    children: [
                      SizedBox(height: mQuery.size.height * 0.037),
                      Text(
                        "Allow Cleaneo to use your \n "
                        "   location for services.",
                        style: TextStyle(
                            fontSize: mQuery.size.height * 0.0215,
                            fontFamily: 'SatoshiBold'),
                      ),
                      SizedBox(
                        height: mQuery.size.height * 0.2,
                      ),
                      Center(
                        child: Image.asset(
                          "assets/images/location.jpeg",
                          width: mQuery.size.width * 0.33,
                        ),
                      ),
                      SizedBox(
                        height: mQuery.size.height * 0.28,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () async {
                            checkLocationPermission();

                            // You can handle other status scenarios (such as isPermanentlyDenied) if needed
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Color(0xff29b2fe),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                "Enable Location Services",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                  color: Colors.white,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
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

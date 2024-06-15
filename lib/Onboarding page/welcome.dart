import 'dart:convert';

import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/Map/enableLocation.dart';
import 'package:cleaneo_user/Onboarding%20page/login.dart';
import 'package:cleaneo_user/Onboarding%20page/signup.dart';
import 'package:cleaneo_user/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for HapticFeedback
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:get_storage/get_storage.dart'; // Import dart:io for exit function
import 'package:http/http.dart' as http;

String auth = '';
String OTP = '';
final authentication = GetStorage();
List test = [];
String termsAndConditions = '';
String privacy = '';
String contentPolicy = '';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Future<bool> fetchTermsAndConditions() async {
    const url0 =
        'https://drycleaneo.com/CleaneoUser/api/termscondition/terms_conditions';
    const url1 =
        'https://drycleaneo.com/CleaneoUser/api/termscondition/privacyPolicy';
    const url2 =
        'https://drycleaneo.com/CleaneoUser/api/termscondition/contentPolicy';
    try {
      final response0 = await http.get(Uri.parse(url0));
      final response1 = await http.get(Uri.parse(url1));
      final response2 = await http.get(Uri.parse(url2));
      if (response0.statusCode == 200) {
        final List<dynamic> tandc = json.decode(response0.body);
        final List<dynamic> privacypolicy = json.decode(response1.body);
        final List<dynamic> contentpolicy = json.decode(response2.body);
        if (tandc.isNotEmpty &&
            privacypolicy.isNotEmpty &&
            contentpolicy.isNotEmpty) {
          termsAndConditions = tandc[0];
          privacy = privacypolicy[0];
          contentPolicy = contentpolicy[0];
          print(privacy);
          return true;
        } else {
          print('Error: Invalid data format');
          return false;
        }
      } else {
        throw Exception('Failed to fetch data: ${response0.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  double _opacity = 0.1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTermsAndConditions();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(UserData.read('ID'));
    print(UserData.read('authen'));

    auth = '';
    var mQuery = MediaQuery.of(context);
    return WillPopScope(
      // Intercept the back button press event
      onWillPop: () async {
        // Close the app completely
        await exit(0);
        return true;
      },
      child: AnimatedOpacity(
        opacity: _opacity, // Use the opacity variable
        duration: Duration(seconds: 1),
        child: Scaffold(
          body: Container(
            color: const Color(0xff006aca),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: mQuery.size.height * 0.15,
                  // height: mQuery.size.height * 0.29,
                ),
                Center(
                  child: SvgPicture.asset("assets/images/mainlogo.svg"),
                ),
                SizedBox(
                  height: mQuery.size.height * 0.07,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            auth = 'Signup';
                            HapticFeedback
                                .heavyImpact(); // Heavy haptic feedback
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUpPage();
                            }));
                          },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: mQuery.size.height * 0.02,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.04,
                        ),
                        GestureDetector(
                          onTap: () {
                            auth = 'login';
                            HapticFeedback
                                .heavyImpact(); // Heavy haptic feedback
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                                color: const Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: mQuery.size.height * 0.02,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.043,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: mQuery.size.width * 0.036,
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SatoshiBold',
                                  fontSize: mQuery.size.height * 0.02),
                            ),
                            SizedBox(
                              width: mQuery.size.width * 0.036,
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            authentication.write('Authentiation', 'Guest');
                            HapticFeedback
                                .heavyImpact(); // Heavy haptic feedback
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MapPage();
                            }));
                          },
                          child: Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                                color: const Color(0xff29b2fe),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                "Continue as Guest",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: mQuery.size.height * 0.02,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: mQuery.size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

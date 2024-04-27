import 'dart:async';

import 'package:cleaneo_user/Onboarding%20page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

final authentication = GetStorage();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 0.1;
      });
    });
    // Wait for 2 seconds and then navigate to the login page
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity, // Use the opacity variable
      duration: Duration(seconds: 2),
      child: Scaffold(
        body: Hero(
          tag: 'logoTag',
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child:
                SvgPicture.asset("assets/images/splash.svg", fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

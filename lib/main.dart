import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/SplashScreen/splash.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // runApp(DevicePreview(
  //   builder: (context) {
  //     return MyApp();
  //   },
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //hello
    UserData.write('UserData', '');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

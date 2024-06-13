import 'package:cleaneo_user/Dashboard/Orders/yourOrders_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderPlaced();
        }));
        return Future.value(true);
      },
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff007fff), Color(0xff6cb4ee)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: mQuery.size.height * 0.3,
              ),
              Lottie.asset("assets/images/ds.json",
                  width: mQuery.size.width * 0.8),
              SizedBox(height: 30),
              Text(
                'Order Placed Successfully!',
                style: TextStyle(
                    color: Color(0xff3a2b30),
                    fontSize: 20,
                    fontFamily: 'SatoshiBold'),
              ),
              Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return YourOrdersPage();
                  }));
                },
                child: Container(
                  width: double.infinity,
                  height: mQuery.size.height * 0.065,
                  margin: EdgeInsets.symmetric(
                      horizontal: mQuery.size.width * 0.045),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Text(
                      "View Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'SatoshiBold',
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mQuery.size.height * 0.06,
              )
            ],
          ),
        ),
      )),
    );
  }
}

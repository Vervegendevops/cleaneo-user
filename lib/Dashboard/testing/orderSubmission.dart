import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSubmittedSuccessfully extends StatefulWidget {
  const OrderSubmittedSuccessfully({super.key});

  @override
  State<OrderSubmittedSuccessfully> createState() =>
      _OrderSubmittedSuccessfullyState();
}

class _OrderSubmittedSuccessfullyState
    extends State<OrderSubmittedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OrderSubmittedSuccessfully();
        }));
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1),
              child: SvgPicture.asset(
                'assets/images/orderSubmitted.svg',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              'Thank You',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            Text(
              'Your Order has been successfully created',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

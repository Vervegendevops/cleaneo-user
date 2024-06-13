import 'dart:convert';
import 'dart:ffi';

import 'package:cleaneo_user/Dashboard/Wash/wash_page.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class quantityPage extends StatefulWidget {
  String data;
  String ID;
  String TypeofData;
  quantityPage(
      {super.key,
      required this.data,
      required this.ID,
      required this.TypeofData});
  // quantityPage({super.key});

  @override
  State<quantityPage> createState() => _quantityPageState();
}

class _quantityPageState extends State<quantityPage> {
  initState() {
    super.initState();
    inti();
  }

  Widget buildItemContainer(
      MediaQueryData mQuery,
      String itemName,
      String itemPrice,
      int kgValuee,
      Function() onRemovePressed,
      Function() onAddPressed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mQuery.size.width * 0.02),
      width: double.infinity,
      height: mQuery.size.height * 0.07,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: TextStyle(
                  fontFamily: 'SatoshiMedium',
                  fontSize: mQuery.size.height * 0.017,
                ),
              ),
              Text(
                '₹ $itemPrice PER PIECE',
                style: TextStyle(
                  fontSize: mQuery.size.height * 0.0155,
                  color: Colors.black54,
                  fontFamily: 'SatoshiRegular',
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          InkWell(
            onTap: onRemovePressed,
            child: Container(
              width: mQuery.size.width * 0.1,
              height: mQuery.size.height * 0.026,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: mQuery.size.width * 0.045,
                ),
              ),
            ),
          ),
          SizedBox(width: mQuery.size.width * 0.026),
          Container(
            width: 30,
            child: Center(
              child: Text(
                "$kgValuee",
                style: TextStyle(
                    color: Color(0xff29b2fe),
                    fontFamily: 'SatoshiRegular',
                    fontSize: mQuery.size.height * 0.024),
              ),
            ),
          ),
          SizedBox(width: mQuery.size.width * 0.026),
          InkWell(
            onTap: onAddPressed,
            child: Container(
              width: mQuery.size.width * 0.1,
              height: mQuery.size.height * 0.026,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Icon(Icons.add, size: mQuery.size.width * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<int> wash_kgValues = [];
  List<int> Wash_and_Iron_kgValues = [];
  List<int> Dry_Clean_kgValues = [];
  List<int> Wash_and_Steam_kgValues = [];
  List<int> Steam_Iron_kgValues = [];
  List<int> Shoe_and_Bag_Care_kgValues = [];

  void inti() {
    wash_kgValues = List.filled(200, 0);
    Wash_and_Iron_kgValues = List.filled(200, 0);

    Dry_Clean_kgValues = List.filled(200, 0);

    Wash_and_Steam_kgValues = List.filled(200, 0);

    Steam_Iron_kgValues = List.filled(200, 0);

    Shoe_and_Bag_Care_kgValues = List.filled(200, 0);
  }

  void calculateTotalPayment() {
    int len = CartItems.length;
    for (int i = 0; i < len; i++) {
      int price = int.parse(CartItems[i]['price']);
      print(price);

      int quat = (CartItems[i]['quantity']);
      print(quat);
      int finalPrice = price * quat;
      TotalCost = TotalCost + finalPrice;
      print(finalPrice);
      print(TotalCost);
      FinalTotalCost = TotalCost;
    }
  }

  @override
  Widget build(BuildContext context) {
    TotalCost = 0;
    // lengthOfCart = calculateTotalQuantity();
    List<Map<String, dynamic>> originalList =
        List<Map<String, dynamic>>.from(jsonDecode(widget.data));
    List<Map<String, dynamic>> newList = [];
    originalList.forEach((item) {
      String itemName = item.keys.first;
      String price = item.values.first.toString();
      String formattedPrice = price.replaceAll('₹ ', '');
      Map<String, dynamic> newItem = {
        "name": itemName,
        "price": formattedPrice
      };
      newList.add(newItem);
    });

    var mQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                Text(
                  "Add Clothes",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                      fontFamily: 'SatoshiBold'),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.023),
            Column(
              children: newList.map((item) {
                int index = newList.indexOf(item);
                return buildItemContainer(
                  mQuery,
                  item["name"],
                  item["price"],
                  widget.TypeofData == 'Wash'
                      ? wash_kgValues[index]
                      : widget.TypeofData == 'Wash and Iron'
                          ? Wash_and_Iron_kgValues[index]
                          : widget.TypeofData == 'Dry Clean'
                              ? Dry_Clean_kgValues[index]
                              : widget.TypeofData == 'Wash and Steam'
                                  ? Wash_and_Steam_kgValues[index]
                                  : widget.TypeofData == 'Steam Iron'
                                      ? Steam_Iron_kgValues[index]
                                      : Shoe_and_Bag_Care_kgValues[index],
                  () {
                    if (CartItems.isNotEmpty) {
                      int itemIndex = CartItems.indexWhere((cartItem) =>
                          cartItem["name"] == item["name"] &&
                          cartItem["type"] == selectedService);
                      if (CartItems[itemIndex]["quantity"] == 0) {
                        // If item exists in CartItems, increase its quantity
                        setState(() {
                          widget.TypeofData == 'Wash'
                              ? wash_kgValues[index]--
                              : widget.TypeofData == 'Wash and Iron'
                                  ? Wash_and_Iron_kgValues[index]--
                                  : widget.TypeofData == 'Dry Clean'
                                      ? Dry_Clean_kgValues[index]--
                                      : widget.TypeofData == 'Wash and Steam'
                                          ? Wash_and_Steam_kgValues[index]--
                                          : widget.TypeofData == 'Steam Iron'
                                              ? Steam_Iron_kgValues[index]--
                                              : Shoe_and_Bag_Care_kgValues[
                                                  index]--;
                          lengthOfCart--;

                          print(itemIndex);
                          CartItems.removeWhere((cartItem) =>
                              cartItem["name"] == item["name"] &&
                              cartItem["type"] == selectedService);
                          calculateTotalPayment();
                          print(CartItems);
                        });
                      } else {
                        setState(() {
                          widget.TypeofData == 'Wash'
                              ? wash_kgValues[index]--
                              : widget.TypeofData == 'Wash and Iron'
                                  ? Wash_and_Iron_kgValues[index]--
                                  : widget.TypeofData == 'Dry Clean'
                                      ? Dry_Clean_kgValues[index]--
                                      : widget.TypeofData == 'Wash and Steam'
                                          ? Wash_and_Steam_kgValues[index]--
                                          : widget.TypeofData == 'Steam Iron'
                                              ? Steam_Iron_kgValues[index]--
                                              : Shoe_and_Bag_Care_kgValues[
                                                  index]--;
                          lengthOfCart--;

                          CartItems[itemIndex]["quantity"] = widget
                                      .TypeofData ==
                                  'Wash'
                              ? wash_kgValues[index]
                              : widget.TypeofData == 'Wash and Iron'
                                  ? Wash_and_Iron_kgValues[index]
                                  : widget.TypeofData == 'Dry Clean'
                                      ? Dry_Clean_kgValues[index]
                                      : widget.TypeofData == 'Wash and Steam'
                                          ? Wash_and_Steam_kgValues[index]
                                          : widget.TypeofData == 'Steam Iron'
                                              ? Steam_Iron_kgValues[index]
                                              : Shoe_and_Bag_Care_kgValues[
                                                  index];
                          calculateTotalPayment();
                          print(CartItems);
                        });
                      }
                    }
                  },
                  () {
                    int itemIndex = CartItems.indexWhere((cartItem) =>
                        cartItem["name"] == item["name"] &&
                        cartItem["type"] == selectedService);
                    if (itemIndex != -1) {
                      // If item exists in CartItems, increase its quantity
                      setState(() {
                        widget.TypeofData == 'Wash'
                            ? wash_kgValues[index]++
                            : widget.TypeofData == 'Wash and Iron'
                                ? Wash_and_Iron_kgValues[index]++
                                : widget.TypeofData == 'Dry Clean'
                                    ? Dry_Clean_kgValues[index]++
                                    : widget.TypeofData == 'Wash and Steam'
                                        ? Wash_and_Steam_kgValues[index]++
                                        : widget.TypeofData == 'Steam Iron'
                                            ? Steam_Iron_kgValues[index]++
                                            : Shoe_and_Bag_Care_kgValues[
                                                index]++;
                        lengthOfCart++;

                        CartItems[itemIndex]["quantity"] = widget.TypeofData ==
                                'Wash'
                            ? wash_kgValues[index]
                            : widget.TypeofData == 'Wash and Iron'
                                ? Wash_and_Iron_kgValues[index]
                                : widget.TypeofData == 'Dry Clean'
                                    ? Dry_Clean_kgValues[index]
                                    : widget.TypeofData == 'Wash and Steam'
                                        ? Wash_and_Steam_kgValues[index]
                                        : widget.TypeofData == 'Steam Iron'
                                            ? Steam_Iron_kgValues[index]
                                            : Shoe_and_Bag_Care_kgValues[index];
                        calculateTotalPayment();
                        print(CartItems);
                      });
                    } else {
                      widget.TypeofData == 'Wash'
                          ? wash_kgValues[index]++
                          : widget.TypeofData == 'Wash and Iron'
                              ? Wash_and_Iron_kgValues[index]++
                              : widget.TypeofData == 'Dry Clean'
                                  ? Dry_Clean_kgValues[index]++
                                  : widget.TypeofData == 'Wash and Steam'
                                      ? Wash_and_Steam_kgValues[index]++
                                      : widget.TypeofData == 'Steam Iron'
                                          ? Steam_Iron_kgValues[index]++
                                          : Shoe_and_Bag_Care_kgValues[index]++;
                      lengthOfCart++;
                      Map<String, dynamic> newItemm = {
                        "type": "$selectedService",
                        "name": "${item["name"]}",
                        "price": "${item["price"]}",
                        "quantity": widget.TypeofData == 'Wash'
                            ? wash_kgValues[index]
                            : widget.TypeofData == 'Wash and Iron'
                                ? Wash_and_Iron_kgValues[index]
                                : widget.TypeofData == 'Dry Clean'
                                    ? Dry_Clean_kgValues[index]
                                    : widget.TypeofData == 'Wash and Steam'
                                        ? Wash_and_Steam_kgValues[index]
                                        : widget.TypeofData == 'Steam Iron'
                                            ? Steam_Iron_kgValues[index]
                                            : Shoe_and_Bag_Care_kgValues[index]
                      };
                      setState(() {
                        CartItems.add(newItemm);
                        calculateTotalPayment();
                        print(CartItems);
                      });
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

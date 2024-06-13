import 'package:cleaneo_user/Onboarding%20page/login.dart';
import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authentication = GetStorage();

class CardData {
  String? cardType;
  String cardNumber;
  String expiryDate;
  String cvv;
  String cardHolderName;

  CardData({
    required this.cardType,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardHolderName,
  });
}

class ManageCardsPage extends StatefulWidget {
  const ManageCardsPage({Key? key}) : super(key: key);

  @override
  State<ManageCardsPage> createState() => _ManageCardsPageState();
}

class _ManageCardsPageState extends State<ManageCardsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<CardData> cards = [];
  TextEditingController cardNoController = TextEditingController();
  TextEditingController mmyyController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String? selectedCardType;

  @override
  void initState() {
    super.initState();
    _loadCardData();
  }

  Future<void> _loadCardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cards = (prefs.getStringList('cards') ?? []).map((cardDataString) {
        List<String> data = cardDataString.split(",");
        return CardData(
          cardType: data[0],
          cardNumber: data[1],
          expiryDate: data[2],
          cvv: data[3],
          cardHolderName: data[4],
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);

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
              padding: const EdgeInsets.only(
                  top: 45, left: 16, right: 16, bottom: 20),
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
                    "Manage Cards",
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
                      SizedBox(
                        height: mQuery.size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              "Credit/Debit Cards",
                              style: TextStyle(
                                  fontSize: mQuery.size.height * 0.0212,
                                  fontFamily: 'SatoshiMedium'),
                            ),
                            Expanded(child: SizedBox()),
                            GestureDetector(
                              onTap: authentication.read('Authentication') ==
                                      'Guest'
                                  ? () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            surfaceTintColor: Colors.white,
                                            title: Text('Login Required'),
                                            content: Text(
                                                'Please log in to continue.'),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Color(
                                                                  0xff29b2fe))),
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
                                      );
                                    }
                                  : _openBottomSheet,
                              child: Row(
                                children: [
                                  Container(
                                    width: mQuery.size.width * 0.06,
                                    height: mQuery.size.height * 0.06,
                                    decoration: BoxDecoration(
                                        color: Color(0xff29b2fe),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Icon(Icons.add,
                                          color: Colors.white,
                                          size: mQuery.size.width * 0.03),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mQuery.size.width * 0.03,
                                  ),
                                  Text(
                                    "Add New",
                                    style: TextStyle(
                                        fontSize: mQuery.size.height * 0.018,
                                        color: Color(0xff29b2fe),
                                        fontFamily: 'SatoshiMedium'),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: mQuery.size.height * 0.025,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            for (int i = 0; i < cards.length; i++)
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    width: double.infinity,
                                    height: mQuery.size.height * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              0), // changes the position of the shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            if (cards[i].cardType != null)
                                              SvgPicture.asset(
                                                getImagePath(
                                                    cards[i].cardType!),
                                                width: 20,
                                                height: 24,
                                              ),
                                            SizedBox(
                                              width: mQuery.size.width * 0.03,
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "${cards[i].cardNumber} ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.018,
                                                    fontFamily: 'SatoshiMedium',
                                                  )),
                                              TextSpan(
                                                  text: "${cards[i].cvv}",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'SatoshiMedium',
                                                    fontSize:
                                                        mQuery.size.height *
                                                            0.018,
                                                  )),
                                            ])),
                                            Expanded(child: SizedBox()),
                                            GestureDetector(
                                                onTap: () {
                                                  _openDeleteBottomSheet(
                                                      cards[i]);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.black54,
                                                )),
                                            SizedBox(
                                              width: mQuery.size.width * 0.03,
                                            ),
                                            Container(
                                              width: mQuery.size.width * 0.05,
                                              height: mQuery.size.height * 0.04,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: 12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          "Valid Till ${cards[i].expiryDate}",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'SatoshiRegular',
                                            fontSize:
                                                mQuery.size.height * 0.0145,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height: mQuery.size.height *
                                          0.023), // Add space between containers
                                ],
                              ),
                            if (cards.isEmpty)
                              Column(
                                children: [
                                  SizedBox(
                                    height: mQuery.size.height * 0.21,
                                  ),
                                  Center(
                                    child: Text(
                                      "No Credit/debit \n  cards added ",
                                      style: TextStyle(
                                          fontSize: mQuery.size.height * 0.025,
                                          fontFamily: 'SatoshiBold',
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )
                          ],
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

  String getImagePath(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'mastercard':
        return "assets/images/mastercard.svg";
      case 'visa':
        return "assets/images/visa_card.svg";
      case 'amex':
        return "assets/images/amex.svg";
      default:
        return "";
    }
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: double.infinity,
              height: mQuery.size.height * 0.53,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: mQuery.size.height * 0.032),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "Add Debit/Credit Card",
                            style: TextStyle(
                                fontSize: mQuery.size.height * 0.024,
                                fontFamily: 'SatoshiMedium'),
                          ),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close the bottom sheet
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.black87,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: mQuery.size.height * 0.02),
                    Divider(),
                    SizedBox(height: mQuery.size.height * 0.01),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Card selection options
                            Row(
                              children: [
                                // Mastercard
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCardType = 'Mastercard';
                                    });
                                  },
                                  child: Container(
                                    width: mQuery.size.width * 0.15,
                                    height: mQuery.size.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: selectedCardType == 'Mastercard'
                                            ? Color(0xff29b2fe)
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/mastercard.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                // Visa
                                SizedBox(width: mQuery.size.width * 0.03),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCardType = 'Visa';
                                    });
                                  },
                                  child: Container(
                                    width: mQuery.size.width * 0.15,
                                    height: mQuery.size.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: selectedCardType == 'Visa'
                                            ? Color(0xff29b2fe)
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/visa_card.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                // Amex
                                SizedBox(width: mQuery.size.width * 0.03),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCardType = 'Amex';
                                    });
                                  },
                                  child: Container(
                                    width: mQuery.size.width * 0.15,
                                    height: mQuery.size.height * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0.5,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: selectedCardType == 'Amex'
                                            ? Color(0xff29b2fe)
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "assets/images/amex.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mQuery.size.height * 0.02),
                            // Card Number TextField
                            Container(
                              width: double.infinity,
                              height: mQuery.size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: cardNoController,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Card Number",
                                  hintStyle: TextStyle(
                                    fontSize: mQuery.size.height * 0.02,
                                    fontFamily: 'SatoshiRegular',
                                    color: Color(0xffABAFB1),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: mQuery.size.width * 0.032,
                                    vertical: mQuery.size.height * 0.018,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mQuery.size.height * 0.02),
                            // MM/YY and CVV TextFields
                            Row(
                              children: [
                                Container(
                                  width: mQuery.size.width * 0.43,
                                  height: mQuery.size.height * 0.055,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.grey,
                                    controller: mmyyController,
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: "MM/YY",
                                      hintStyle: TextStyle(
                                        fontSize: mQuery.size.height * 0.02,
                                        fontFamily: 'SatoshiRegular',
                                        color: Color(0xffABAFB1),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: mQuery.size.width * 0.032,
                                        vertical: mQuery.size.height * 0.018,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Container(
                                  width: mQuery.size.width * 0.43,
                                  height: mQuery.size.height * 0.055,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 4,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: TextField(
                                    cursorColor: Colors.grey,
                                    controller: cvvController,
                                    keyboardType: TextInputType.number,
                                    obscureText: true,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .digitsOnly // Allow only numeric input
                                    ],
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: "CVV",
                                      hintStyle: TextStyle(
                                        fontSize: mQuery.size.height * 0.02,
                                        fontFamily: 'SatoshiRegular',
                                        color: Color(0xffABAFB1),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: mQuery.size.width * 0.032,
                                        vertical: mQuery.size.height * 0.018,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: mQuery.size.height * 0.02),
                            // Name TextField
                            Container(
                              width: double.infinity,
                              height: mQuery.size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: nameController,
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    fontSize: mQuery.size.height * 0.02,
                                    fontFamily: 'SatoshiRegular',
                                    color: Color(0xffABAFB1),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: mQuery.size.width * 0.032,
                                    vertical: mQuery.size.height * 0.018,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mQuery.size.height * 0.05),
                            // Cancel and Add Buttons
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(
                                        context); // Close the bottom sheet
                                  },
                                  child: Container(
                                    width: mQuery.size.width * 0.43,
                                    height: mQuery.size.height * 0.055,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(0xff004c91),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          fontSize: mQuery.size.height * 0.02,
                                          color: Colors.white,
                                          fontFamily: 'SatoshiBold',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                GestureDetector(
                                  onTap: () async {
                                    if (selectedCardType!.isEmpty ||
                                        cardNoController.text.isEmpty ||
                                        mmyyController.text.isEmpty ||
                                        cvvController.text.isEmpty ||
                                        nameController.text.isEmpty) {
                                      // Show error message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        margin: EdgeInsets.only(
                                            bottom: mQuery.size.height * 0.55),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 1),
                                        // backgroundColor: Color(0xffededed),
                                        backgroundColor: Colors.white,
                                        content: Text(
                                          "All fields are required to add a card",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'SatoshiBold',
                                              fontSize:
                                                  mQuery.size.height * 0.022),
                                        ),
                                      ));
                                      return; // Don't proceed further
                                    }

                                    // If all fields are filled, proceed to add the card
                                    CardData newCard = CardData(
                                      cardType: selectedCardType,
                                      cardNumber: cardNoController.text,
                                      expiryDate: mmyyController.text,
                                      cvv: cvvController.text,
                                      cardHolderName: nameController.text,
                                    );

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    cards.add(newCard);
                                    List<String> cardDataList = [];
                                    for (CardData card in cards) {
                                      String cardDataString =
                                          "${card.cardType},${card.cardNumber},${card.expiryDate},${card.cvv},${card.cardHolderName}";
                                      cardDataList.add(cardDataString);
                                    }
                                    prefs.setStringList('cards', cardDataList);

                                    _loadCardData(); // Reload card data

                                    Navigator.pop(
                                        context); // Close the bottom sheet
                                  },
                                  child: Container(
                                    width: mQuery.size.width * 0.43,
                                    height: mQuery.size.height * 0.055,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Color(0xff29b2fe),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                          fontSize: mQuery.size.height * 0.02,
                                          color: Colors.white,
                                          fontFamily: 'SatoshiBold',
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openDeleteBottomSheet(CardData card) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var mQuery = MediaQuery.of(context);
        return Container(
          height: mQuery.size.height * 0.3,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: mQuery.size.height * 0.032,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Delete Card",
                        style: TextStyle(
                          fontSize: mQuery.size.height * 0.024,
                          fontFamily: 'SatoshiBold',
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black87,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: mQuery.size.height * 0.02,
                ),
                Divider(),
                SizedBox(
                  height: mQuery.size.height * 0.015,
                ),
                Text(
                  "Are you sure you want to \n    "
                  "   delete this card?",
                  style: TextStyle(
                    fontSize: mQuery.size.height * 0.02,
                    fontFamily: 'SatoshiMedium',
                  ),
                ),
                SizedBox(height: mQuery.size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: Container(
                          width: mQuery.size.width * 0.43,
                          height: mQuery.size.height * 0.055,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xff004c91),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                fontSize: mQuery.size.height * 0.02,
                                color: Colors.white,
                                fontFamily: 'SatoshiBold',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          _deleteCard(card);
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: mQuery.size.width * 0.43,
                          height: mQuery.size.height * 0.055,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xff21b2fe),
                          ),
                          child: Center(
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: mQuery.size.height * 0.02,
                                fontFamily: 'SatoshiBold',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteCard(CardData card) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cards.remove(card);
    });
    List<String> cardDataList = [];
    for (CardData card in cards) {
      String cardDataString =
          "${card.cardType},${card.cardNumber},${card.expiryDate},${card.cvv},${card.cardHolderName}";
      cardDataList.add(cardDataString);
    }
    prefs.setStringList('cards', cardDataList);
  }
}

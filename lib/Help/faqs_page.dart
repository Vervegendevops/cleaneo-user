import 'package:cleaneo_user/Help/help_page.dart';
import 'package:flutter/material.dart';

class FAQSPage extends StatefulWidget {
  const FAQSPage({Key? key}) : super(key: key);

  @override
  State<FAQSPage> createState() => _FAQSPageState();
}

class _FAQSPageState extends State<FAQSPage> {
  List<bool> isExpandedList = [false, false, false, false, false];

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
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HelpPage();
                        }));
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                  SizedBox(width: mQuery.size.width * 0.045),
                  Text(
                    "FAQs",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.027,
                      color: Colors.white,
                      fontFamily: 'SatoshiBold',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.3,
                      blurRadius: 1,
                      offset:
                          Offset(3, 3), // changes the position of the shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildFAQContainer(index, mQuery);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFAQContainer(int index, MediaQueryData mQuery) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: mQuery.size.height * 0.023),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpandedList[index] = !isExpandedList[index];
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset:
                          Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: mQuery.size.height * 0.01,
                        bottom: mQuery.size.height * 0.01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Text(
                              "I am not getting any emails", // Your Question or Title
                              style: TextStyle(
                                  fontFamily: 'SatoshiMedium',
                                  fontSize: mQuery.size.height * 0.019),
                            ),
                          ),
                          Icon(
                            isExpandedList[index]
                                ? Icons
                                    .arrow_drop_up // Drop-up icon when expanded
                                : Icons
                                    .arrow_drop_down, // Drop-down icon when not expanded
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isExpandedList[index],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Lorem ipsum dolor sit amet consectetur "
                          "adipisicing elit. Debitis voluptate dolor "
                          "doloremque amet fuga tempora ad ex molestias soluta non aperiam odio, labore eum",
                          style: TextStyle(
                            fontSize: mQuery.size.height * 0.0178,
                            fontFamily: 'SatoshiRegular',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

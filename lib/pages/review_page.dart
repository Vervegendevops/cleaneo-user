import 'package:cleaneo_user/pages/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get_storage/get_storage.dart';

final authentication = GetStorage();

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> reviews =
      authentication.read('Authentication') == 'Guest'
          ? []
          : [
              {
                'username': 'Rahul',
                'image':
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA3tt2QdkGYJ1268iokp1HHB3XB6PNaAZD_pssz3zFVg&s",
                'ratingPoint': 4.5,
                'reviewText':
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text. \n \n Lorem Ipsum is simply dummy text of printing and typesetting industry.'
              },
              {
                'username': 'Rahul',
                'image':
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA3tt2QdkGYJ1268iokp1HHB3XB6PNaAZD_pssz3zFVg&s",
                'ratingPoint': 4.5,
                'reviewText':
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text. \n \n Lorem Ipsum is simply dummy text of printing and typesetting industry.'
              },
              {
                'username': 'Rahul',
                'image':
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA3tt2QdkGYJ1268iokp1HHB3XB6PNaAZD_pssz3zFVg&s",
                'ratingPoint': 4.5,
                'reviewText':
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text. \n \n Lorem Ipsum is simply dummy text of printing and typesetting industry.'
              },
              // Add more reviews as needed
            ];

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
                    "Reviews",
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
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                ),
                child: authentication.read('Authentication') == 'Guest'
                    ? Center(child: Text('No Reviews to show'))
                    : Padding(
                        padding: EdgeInsets.only(
                          left: mQuery.size.width * 0.045,
                          right: mQuery.size.width * 0.045,
                          top: mQuery.size.width * 0.045,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(reviews.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: mQuery.size.height * 0.03),
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                    bottom: mQuery.size.height * 0.016),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
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
                                  children: [
                                    SizedBox(
                                        height: mQuery.size.height * 0.014),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mQuery.size.width * 0.035),
                                      child: Row(
                                        children: [
                                          ProfilePicture(
                                            name: "",
                                            radius: mQuery.size.width * 0.038,
                                            fontsize: 10,
                                            img: reviews[index]['image'],
                                          ),
                                          SizedBox(
                                            width: mQuery.size.width * 0.025,
                                          ),
                                          Text(
                                            reviews[index]['username'],
                                            style: TextStyle(
                                              fontSize:
                                                  mQuery.size.height * 0.02,
                                              fontFamily: 'SatoshiMedium',
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                          Icon(
                                            Icons.star,
                                            size: mQuery.size.width * 0.056,
                                            color: Color(0xff29b2fe),
                                          ),
                                          SizedBox(
                                            width: mQuery.size.width * 0.015,
                                          ),
                                          Text(
                                            "${reviews[index]['ratingPoint']}",
                                            style: TextStyle(
                                              fontSize:
                                                  mQuery.size.height * 0.02,
                                              fontFamily: 'SatoshiMedium',
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mQuery.size.width * 0.035),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              reviews[index]['reviewText'],
                                              style: TextStyle(
                                                fontSize:
                                                    mQuery.size.height * 0.018,
                                                fontFamily: 'SatoshiRegular',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
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

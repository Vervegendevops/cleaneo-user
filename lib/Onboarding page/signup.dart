import 'dart:convert';
import 'dart:math';
import 'package:cleaneo_user/FinalDataSet.dart';
import 'package:cleaneo_user/Global/global.dart';
import 'package:cleaneo_user/Onboarding%20page/login.dart';
import 'package:cleaneo_user/Onboarding%20page/otpScreen.dart';
import 'package:cleaneo_user/Onboarding%20page/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController nameController = TextEditingController();
TextEditingController phonenoController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  bool isPasswordVisible = false;

  bool isPasswordVisible2 = false;
  bool ispressed = false;
  PhoneNumber? phoneNumber;
  String selectedCountryCode = 'IN';
  double _opacity = 0.5;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Future<Object> fetchResponse(String phoneNumber) async {
    final url = 'https://drycleaneo.com/CleaneoUser/api/signedUp/$phoneNumber';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body);

        if (response.body == "false") {
          OTP = (1000 + Random().nextInt(9000)).toString();
          fetchResponse2();

          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return OTPPage();
          // }));
        } else {
          setState(() {
            ispressed = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User already exists. Please login.'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(16.0),
            ),
          );
        }
        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  Future<Object> fetchResponse2() async {
    final url = 'https://drycleaneo.com/CleaneoUser/api/count';
    String CountUser = '';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.body);
        CountUser = response.body;
        if (CountUser.length == 1) {
          UserID = 'Cleaneo0000$CountUser';
        } else if (CountUser.length == 2) {
          UserID = 'Cleaneo000$CountUser';
        } else if (CountUser.length == 3) {
          UserID = 'Cleaneo00$CountUser';
        } else if (CountUser.length == 4) {
          UserID = 'Cleaneo0$CountUser';
        } else {
          UserID = 'Cleaneo$CountUser';
        }
        print(UserID);
        fetchResponse3(Signupphone);
        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  Future<Object> fetchResponse3(String phoneNumber) async {
    final url =
        'http://app.pingbix.com/SMSApi/send?userid=cleaneoapp&password=EghpgNS3&sendMethod=quick&mobile=$phoneNumber&msg=Hello+$Signupname%2C%0D%0AYour+OTP+for+Cleaneo+login%2Fsignup+is+%3A+$OTP.%0D%0AThank+You&senderid=CLE123&msgType=text&dltEntityId=&dltTemplateId=1207171510723882445&duplicatecheck=true&output=json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('otp Sent');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OTPPage();
        }));
        return response.body == 'true';
      } else {
        // If the response status code is not 200, throw an exception or handle
        // the error accordingly.
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions if any occur during the request.
      print('Error fetching data: $e');
      return false; // Return false in case of an error.
    }
  }

  bool tns = false;

  @override
  Widget build(BuildContext context) {
    print(phoneNumber);
    var mQuery = MediaQuery.of(context);
    return AnimatedOpacity(
      opacity: _opacity, // Use the opacity variable
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WelcomePage();
                          }));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: mQuery.size.width * 0.045,
                    ),
                    Text(
                      "Sign Up",
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
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: mQuery.size.width * 0.045,
                        right: mQuery.size.width * 0.045,
                        top: mQuery.size.height * 0.025),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name*",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SatoshiBold',
                              fontSize: mQuery.size.height * 0.02,
                            ),
                          ),
                          SizedBox(
                            height: mQuery.size.height * 0.01,
                          ),
                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.grey,
                              controller: nameController,
                              onChanged: (value) {
                                setState(() {
                                  Signupname = value;
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  Signupname = value;
                                });
                              },
                              onEditingComplete: () {
                                // UserName = nameController as String;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Enter Full Name",
                                hintStyle: TextStyle(
                                    fontSize: mQuery.size.height * 0.02,
                                    fontFamily: 'SatoshiMedium',
                                    color: Color(0xffABAFB1)),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: mQuery.size.height * 0.0175),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: mQuery.size.height * 0.03,
                          ),
                          // PHONE NUMBER
                          Text(
                            "Phone Number*",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SatoshiBold',
                              fontSize: mQuery.size.height * 0.02,
                            ),
                          ),
                          SizedBox(
                            height: mQuery.size.height * 0.01,
                          ),

                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.066,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: mQuery.size.width * 0.03),
                                Icon(Icons.phone_outlined),
                                CountryCodePicker(
                                  onChanged: (code) {
                                    setState(() {
                                      selectedCountryCode = code.dialCode!;
                                    });
                                  },
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  dialogTextStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  initialSelection: 'IN',
                                  favorite: ['+91', 'IN'],
                                  showCountryOnly: false,
                                  showFlag: true,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                                // "|" symbol
                                SizedBox(
                                  height: mQuery.size.height * 0.03,
                                  child: VerticalDivider(
                                    thickness: 1.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: mQuery.size.width * 0.01),
                                // Phone number input
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.grey,
                                    controller: phonenoController,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    maxLength: 10,
                                    onChanged: (value) {
                                      setState(() {
                                        Signupphone = value;
                                        FinalPhoneNumber = value;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      setState(() {
                                        Signupphone = value;
                                        FinalPhoneNumber = value;
                                      });
                                    },
                                    onEditingComplete: () {
                                      // UserPhone = phonenoController as String;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .digitsOnly // Allow only numeric input
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "Enter Phone Number*",
                                      hintStyle: TextStyle(
                                        fontSize: mQuery.size.height * 0.02,
                                        fontFamily: 'SatoshiMedium',
                                        color: Color(0xffABAFB1),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 2),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      counter: SizedBox.shrink(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          (Signupphone.length > 0 && Signupphone.length < 10)
                              ? Text(
                                  "*Please enter a valid mobile number.",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.013,
                                      fontFamily: 'SatoshiMedium',
                                      color: Colors.red),
                                )
                              : Text(
                                  "*We'll send a one time 4-digit OTP to your phone",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.013,
                                      fontFamily: 'SatoshiMedium',
                                      color: Colors.grey),
                                ),

                          SizedBox(
                            height: mQuery.size.height * 0.03,
                          ),
                          // Email
                          Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SatoshiBold',
                              fontSize: mQuery.size.height * 0.02,
                            ),
                          ),
                          SizedBox(
                            height: mQuery.size.height * 0.01,
                          ),
                          Container(
                            width: double.infinity,
                            height: mQuery.size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.grey,
                              controller: emailController,
                              onChanged: (value) {
                                setState(() {
                                  Signupemail = value;
                                });
                              },
                              onSubmitted: (value) {
                                setState(() {
                                  Signupemail = value;
                                });
                              },
                              onEditingComplete: () {
                                // UserEmail = emailController as String;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "Enter Email",
                                hintStyle: TextStyle(
                                  fontSize: mQuery.size.height * 0.02,
                                  fontFamily: 'SatoshiMedium',
                                  color: Color(0xffABAFB1),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: mQuery.size.height * 0.0175),
                              ),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Color(0xffffffff),
                                activeColor: Color(0xff29b2fe),
                                value: tns,
                                onChanged: (value) {
                                  setState(() {
                                    tns = !tns;
                                  });
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "By Continuing, you agree to our  ",
                                        style: TextStyle(
                                          fontSize: mQuery.size.width * 0.025,
                                          color: tns == false
                                              ? Colors.grey
                                              : Colors.black,
                                          fontFamily: 'SatoshiRegular',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) {
                                          // return TS();
                                          // }));
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Terms of Service",
                                                        style: TextStyle(
                                                          fontSize: mQuery
                                                                  .size.height *
                                                              0.027,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'SatoshiBold',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        termsAndConditions,
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Terms of Service ",
                                              style: TextStyle(
                                                fontSize:
                                                    mQuery.size.width * 0.025,
                                                color: tns == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                                fontFamily: 'SatoshiMedium',
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: tns == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        ' , ',
                                        style: TextStyle(
                                          fontSize: mQuery.size.width * 0.025,
                                          color: tns == false
                                              ? Colors.grey
                                              : Colors.black,
                                          fontFamily: 'SatoshiMedium',
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) {
                                          // return PP();
                                          // }));
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Privacy Policy",
                                                        style: TextStyle(
                                                          fontSize: mQuery
                                                                  .size.height *
                                                              0.027,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'SatoshiBold',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                          height: mQuery
                                                                  .size.height *
                                                              0.01),
                                                      Text(
                                                        privacy,
                                                        style: TextStyle(
                                                            fontSize: mQuery
                                                                    .size
                                                                    .height *
                                                                0.0165,
                                                            fontFamily:
                                                                'SatoshiMedium'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Privacy Policy",
                                              style: TextStyle(
                                                fontSize:
                                                    mQuery.size.width * 0.025,
                                                color: tns == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                                fontFamily: 'SatoshiMedium',
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: tns == false
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      // return CP();
                                      // }));
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Content Policies",
                                                    style: TextStyle(
                                                      fontSize:
                                                          mQuery.size.height *
                                                              0.027,
                                                      color: Colors.black,
                                                      fontFamily: 'SatoshiBold',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    contentPolicy,
                                                    style: TextStyle(
                                                        fontSize:
                                                            mQuery.size.height *
                                                                0.0165,
                                                        fontFamily:
                                                            'SatoshiMedium'),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Content Policies",
                                      style: TextStyle(
                                        fontSize: mQuery.size.width * 0.025,
                                        color: tns == false
                                            ? Colors.grey
                                            : Colors.black,
                                        fontFamily: 'SatoshiMedium',
                                        decoration: TextDecoration.underline,
                                        decorationColor: tns == false
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),

                          SizedBox(
                            height: mQuery.size.height * 0.17,
                          ),
                          GestureDetector(
                            onTap: tns == false
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Please check the Terms of Service.'),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.all(16.0),
                                      ),
                                    );
                                  }
                                : () {
                                    auth = 'Signup';
                                    setState(() {
                                      ispressed = true;
                                    });
                                    if (FinalPhoneNumber.length == 10 &&
                                        Signupemail.length > 0 &&
                                        Signupname.length > 0) {
                                      fetchResponse(FinalPhoneNumber);
                                      // Navigator.push(context,
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return OTPPage();
                                      // }));
                                    }
                                  },
                            // onTap: () {
                            //   print(Signupname);
                            //   print(Signupemail);
                            //   print(Signupphone);
                            // },
                            child: Container(
                              width: double.infinity,
                              height: mQuery.size.height * 0.06,
                              decoration: BoxDecoration(
                                  color: (Signupemail.length > 0 &&
                                          Signupname.length > 0 &&
                                          Signupphone.length == 10 &&
                                          tns == true)
                                      ? Color(0xff29b2fe)
                                      : Color.fromARGB(145, 41, 179, 254),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ispressed == true
                                          ? "Sending Otp"
                                          : "Sign Up",
                                      style: TextStyle(
                                        fontSize: mQuery.size.height * 0.02,
                                        color: Colors.white,
                                        fontFamily: 'SatoshiBold',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    if (ispressed == true)
                                      GFLoader(
                                        type: GFLoaderType.ios,
                                        loaderColorOne: Colors.white,
                                        loaderColorThree: Colors.white,
                                        loaderColorTwo: Colors.white,
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mQuery.size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.02,
                                  fontFamily: 'SatoshiBold',
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: mQuery.size.height * 0.02,
                                      fontFamily: 'SatoshiBold',
                                      color: Color(0xff29b2fe)),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  }));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

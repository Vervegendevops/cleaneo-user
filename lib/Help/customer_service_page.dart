import 'package:cleaneo_user/Onboarding%20page/login.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

final authentication = GetStorage();

class CustomerServicePage extends StatefulWidget {
  const CustomerServicePage({Key? key}) : super(key: key);

  @override
  State<CustomerServicePage> createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {
  String _feedback = '';
  int maxWordLimit = 140;
  bool _showEmailOptions = false;

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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  Text(
                    "Customer Service",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.027,
                      color: Colors.white,
                      fontFamily: 'SatoshiBold',
                    ),
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.3,
                      blurRadius: 1,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 20, bottom: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showEmailOptions = !_showEmailOptions;
                            });
                          },
                          child: ContactInfoWidget(
                            icon: Icons.email_outlined,
                            label: "support@cleaneo.com",
                            email: "support@cleaneo.com", // email address
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.04),
                        if (_showEmailOptions)
                          SizedBox(height: mQuery.size.height * 0.04),
                        ContactInfoWidget(
                          icon: Icons.phone_android_outlined,
                          label: "(+91) 9978997899",
                          phoneNumber: "+919978997899", // phone number
                        ),
                        SizedBox(height: mQuery.size.height * 0.04),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: mQuery.size.width * 0.3),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: mQuery.size.width * 0.05,
                              ),
                              Text(
                                "OR",
                                style: TextStyle(
                                  fontSize: mQuery.size.height * 0.02,
                                  color: Colors.grey,
                                  fontFamily: 'SatoshiMedium',
                                ),
                              ),
                              SizedBox(
                                width: mQuery.size.width * 0.05,
                              ),
                              const Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.025),
                        Text(
                          "Write to us",
                          style: TextStyle(
                              fontFamily: 'SatoshiMedium',
                              fontSize: mQuery.size.height * 0.02),
                        ),
                        SizedBox(height: mQuery.size.height * 0.023),
                        FeedbackContainer(
                          feedback: _feedback,
                          onChanged: (text) {
                            // Limit the feedback to 140 words
                            if (text.length > maxWordLimit) {
                              text = text.substring(0, maxWordLimit);
                            }
                            setState(() {
                              _feedback = text;
                            });
                          },
                        ),
                        SizedBox(height: mQuery.size.height * 0.1),
                        ElevatedButton(
                          onPressed: () {
                            // Handle submission
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  title: Text('Login Required'),
                                  content: Text('Please log in to continue.'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xff29b2fe))),
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
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff29b2fe),
                            minimumSize: Size(
                                double.infinity, mQuery.size.height * 0.06),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: mQuery.size.height * 0.023,
                              color: Colors.white,
                              fontFamily: 'SatoshiBold',
                            ),
                          ),
                        ),
                      ],
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

class ContactInfoWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? email;
  final String? phoneNumber;

  ContactInfoWidget(
      {required this.icon, required this.label, this.email, this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        if (email != null) {
          _launchEmail(context, email!);
        } else if (phoneNumber != null) {
          _launchPhone(context, phoneNumber!);
        }
      },
      child: Column(
        children: [
          Container(
            width: mQuery.size.width * 0.15,
            height: mQuery.size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.cyan,
              size: 30,
            ),
          ),
          SizedBox(height: 8), // Adjust the space here
          Text(
            label,
            style: TextStyle(
              fontFamily: 'SatoshiMedium',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context, String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Feedback for Cleaneo'},
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch email'),
        ),
      );
    }
  }

  Future<void> _launchPhone(BuildContext context, String phoneNumber) async {
    final Uri _phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(_phoneLaunchUri.toString())) {
      await launch(_phoneLaunchUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch phone call'),
        ),
      );
    }
  }
}

class FeedbackContainer extends StatelessWidget {
  final String feedback;
  final ValueChanged<String> onChanged;
  final int maxWordLimit = 140;

  FeedbackContainer({required this.feedback, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    int currentWordCount = feedback.isEmpty ? 0 : feedback.split(' ').length;
    int remainingWords = maxWordLimit - currentWordCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: mQuery.size.height * 0.17,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            cursorColor: Colors.grey,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: onChanged,
            decoration: InputDecoration.collapsed(
              hintText: "",
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(height: mQuery.size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '$currentWordCount/140',
              style: TextStyle(
                color: remainingWords >= 0 ? Colors.black : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

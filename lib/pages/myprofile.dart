import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../Dashboard/home_page.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenoController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  PhoneNumber? phoneNumber;
  String selectedCountryCode = 'IN';
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

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
                top: mQuery.size.height*0.058,
                bottom: mQuery.size.height*0.03,
                left: mQuery.size.width*0.045,
                right: mQuery.size.width*0.045,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
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
                    "My Profile",
                    style: TextStyle(
                        fontSize: mQuery.size.height*0.027,
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
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: mQuery.size.height * 0.052),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: ClipOval(
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: _selectedImagePath != null
                                      ? Image.file(
                                    File(_selectedImagePath!),
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.cover,
                                  )
                                      : ProfilePicture(
                                    name: "",
                                    radius: 65,
                                    fontsize: 10,
                                    img:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwKKzV4oKveaDEmBr38LXuMWTho1d1-mjOOcjau6XJ1A&s",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xff29b2fe),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Image.asset("assets/images/drawer-images/edit.png",
                                width: mQuery.size.width*0.06,
                                color: Colors.white,),
                                onPressed: _pickImage,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: mQuery.size.height * 0.075),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name*",
                              style: TextStyle(
                                  fontSize: mQuery.size.height*0.02,
                                  fontFamily: 'SatoshiBold'),
                            ),
                            SizedBox(height: mQuery.size.height * 0.01),
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
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: mQuery.size.height*0.0155
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Enter Full Name",
                                  hintStyle: TextStyle(
                                    fontSize: mQuery.size.height*0.02,
                                    fontFamily: 'SatoshiMedium',
                                    color: Color(0xffABAFB1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mQuery.size.height * 0.03),
                            Text(
                              "Phone Number*",
                              style: TextStyle(
                                  fontSize: mQuery.size.height*0.02,
                                  fontFamily: 'SatoshiBold'),
                            ),
                            SizedBox(height: mQuery.size.height * 0.01),
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
                                  SizedBox(
                                      width: mQuery.size.width * 0.03),
                                  Icon(Icons.phone_outlined),
                                  CountryCodePicker(
                                    onChanged: (code) {
                                      setState(() {
                                        selectedCountryCode =
                                        code.dialCode!;
                                      });
                                    },
                                    initialSelection: 'IN',
                                    favorite: ['+91', 'IN'],
                                    showCountryOnly: false,
                                    showFlag: true,
                                    showOnlyCountryWhenClosed: false,
                                    alignLeft: false,
                                  ),
                                  SizedBox(
                                    height: mQuery.size.height * 0.03,
                                    child: VerticalDivider(
                                      thickness: 1.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: mQuery.size.width * 0.02),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      cursorColor: Colors.grey,
                                      controller: phonenoController,
                                      maxLength: 10,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly // Allow only numeric input
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "Enter Phone Number*",
                                        hintStyle: TextStyle(
                                          fontSize: mQuery.size.height*0.02,
                                          fontFamily: 'SatoshiMedium',
                                          color: Color(0xffABAFB1),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          top: mQuery.size.height*0.00005
                                        ),
                                        counter: SizedBox.shrink(),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mQuery.size.height * 0.03),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: mQuery.size.height*0.02,
                                  fontFamily: 'SatoshiBold'),
                            ),
                            SizedBox(height: mQuery.size.height * 0.01),
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
                              child: TextField(
                                cursorColor: Colors.grey,
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: mQuery.size.height*0.014
                                  ),
                                  prefixIcon: Icon(Icons.email_outlined),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: "Enter Email",
                                  hintStyle: TextStyle(
                                    fontSize: mQuery.size.height*0.02,
                                    fontFamily: 'SatoshiMedium',
                                    color: Color(0xffABAFB1),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: mQuery.size.height * 0.068),
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return HomePage();
                                }));
                              },
                              child: Container(
                                width: double.infinity,
                                height: mQuery.size.height * 0.06,
                                decoration: BoxDecoration(
                                    color: Color(0xff29b2fe),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                  child: Text(
                                    "Save & Continue",
                                    style: TextStyle(
                                      fontSize: mQuery.size.height*0.022,
                                      color: Colors.white,
                                      fontFamily: 'SatoshiBold'
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
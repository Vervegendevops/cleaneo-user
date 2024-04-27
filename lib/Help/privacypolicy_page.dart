import 'package:cleaneo_user/Help/help_page.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
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
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: mQuery.size.width * 0.045,
                  ),
                  Text(
                    "Privacy Policy",
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
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "Lorem ipsum dolor sit amet consectetur "
                    "adipisicing elit. Debitis voluptate dolor "
                    "doloremque amet fuga tempora ad ex molestias soluta non aperiam odio, labore eum ullam excepturi minus libero? Cupiditate laborum mollitia assumenda nnulla doloremque sapiente corporis! Numquam quae voluptates magni suscipit dolores molestiae, deserunt aliquam obcaecati officiis cum eveniet iure architecto nostrum fuga facere incidunt soluta eligendi sed dolorum, quo repellendus distinctio aspernatur consectetur! Beatae repudiandae, consequatur quod hic quae nam blanditiis assumenda placeat necessitatibus dolore nihil est. Expedita delectus.",
                    style: TextStyle(
                      fontSize: mQuery.size.height * 0.0178,
                      fontFamily: 'SatoshiMedium',
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

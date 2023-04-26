import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../utils/WAWidgets.dart';
import 'AGAppAgentOnBoardingScreen.dart';
import 'AGAppAuthCheckScreen.dart';
import 'AGAppCustomerAuthCheck.dart';
import 'AGAppCustomerOnboardingScreen.dart';
import 'AGAppCustomerPortfolioScreen.dart';
import 'AGAppmainScreenImage.dart';
import 'AGAppAgentLoginScreen.dart';

class AGAppMianScreen extends StatefulWidget {
  const AGAppMianScreen({Key? key}) : super(key: key);

  @override
  State<AGAppMianScreen> createState() => _AGAppMianScreenState();
}

class _AGAppMianScreenState extends State<AGAppMianScreen> {
  final Uri _urlForOutLook = Uri.parse('https://outlook.office365.com/mail/');
  Future<void> _launchUrlOutLook() async {
    if (!await launchUrl(_urlForOutLook)) {
      throw Exception('Could not launch $_urlForOutLook');
    }
  }

  final Uri _urlForGmail = Uri.parse('https://mail.google.com/mail/');
  Future<void> _launchUrlGmail() async {
    if (!await launchUrl(_urlForGmail)) {
      throw Exception('Could not launch $_urlForOutLook');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 40,
        //actions: [],
        title: Text("Agency Banking",
            style: boldTextStyle(size: 24, color: white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
              gradient: LinearGradient(
                  colors: [Colors.teal, Color.fromARGB(255, 0, 255, 229)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
           // height: context.mediaQuerySize.height,
            width: context.mediaQuerySize.width,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('images/mobile_banking/wa_bg.jpg'),
            //         fit: BoxFit.cover)),
            child: Column(
              children: [
               
                 GifView.asset(
                "images/mobile_banking/Record_2023_03_27_10_27_09_12.gif",
                height: 250,
                width: 500,
                frameRate: 30,
                progress: Text("Loading..."), // default is 15 FPS
              ),
                10.height,
                Center(
                  child: Wrap(
                    spacing: 60,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: [
                      
                      GestureDetector(
                        onTap: () {
                          AGAppAgentOnboardingScreen().launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                // backgroundImage: AssetImage("images/mobile_banking/agentOnboarding-removebg-preview.png"),
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/agentonboarding2-removebg-preview.png"),
                              ),
                              Text("   Agent \nOn Boarding",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                         // WALoginScreen(/*data: data*/).launch(context);
                         AGAPPAuthCheckScreen().launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/agentOnboarding-removebg-preview.png"),
                              ),
                              Text("Agent Porfolio",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AGAppCustomerOnboardScreen().launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/customeronboarding-removebg-preview.png"),
                              ),
                              Text("Customer \nOn Boarding",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //CustomerPortfolioScreen().launch(context);
                          AGAPPCustomerAuthCheckScreen().launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/existing_customer-removebg-preview.png"),
                              ),
                              Text("Customer Porfolio",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/helpoption2-removebg-preview.png"),
                              ),
                              Text("Help",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

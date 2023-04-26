import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:gif_view/gif_view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAWidgets.dart';
import 'AGAppAgentLink-DelinkScreen.dart';
import 'AGAppAgentOnBoardingScreen.dart';
import 'AGAppAuthCheckScreen.dart';
import 'AGAppCustomerOnboardingScreen.dart';
import 'AGAppCustomerTransScreen.dart';
import 'AGAppEditProfileScreen.dart';
import 'AGAppMainScreen.dart';
import 'AGAppmainScreenImage.dart';
import 'WAEditProfileScreen.dart';
import 'AGAppAgentLoginScreen.dart';
import 'WAUploadKYCScreen.dart';

class CustomerPortfolioScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const CustomerPortfolioScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);


  @override
  State<CustomerPortfolioScreen> createState() =>
      _CustomerPortfolioScreenState(/*data:data*/);
}

class _CustomerPortfolioScreenState extends State<CustomerPortfolioScreen> {
  //  _CustomerPortfolioScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
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
        backgroundColor: Colors.teal,
        title: Column(
          children: [
            Text("Welcome: Yousuf",
                style: boldTextStyle(color: Colors.black, size: 20)),

            // Text(" Yousuf",
            //     style: boldTextStyle(color: Colors.black, size: 20))

            // Text("${agentname.toString()}")
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: CircleAvatar(
        //       child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        //     ),
        //   ),
        // ],

        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(Icons.document_scanner_outlined,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("KYC",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Log Out",style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.contact_page_outlined,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Profile",style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ],
            offset: Offset(0, 70),
            color: Colors.teal,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog

              if (value == 1) {
                WAKYCuploadScreen().launch(context);
                //_showDialog(context);
                // if value 2 show dialog
              } else if (value == 2) {
                 SessionManager().destroy();
                  AGAppMianScreen(/*data: data,*/).launch(context);
                // _showDialog(context);
              } else if (value == 3) {
                AGAppEditProfileScreen(/*data: data,*/).launch(context);
              }
            },
          ),
        ],
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: context.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Icon(Icons.arrow_back,
              color: appStore.isDarkModeOn ? white : black),
        ).onTap(() {
          finish(context);
        }),
        centerTitle: true,
        elevation: 0.0,
        brightness: Brightness.dark,
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
                // GifView.asset(
                //   "images/mobile_banking/Record_2023_03_27_10_27_09_12.gif",
                //   height: 250,
                //   width: 500,
                //   frameRate: 30,
                //   progress: Text("Loading..."), // default is 15 FPS
                // ),
                Image(image: AssetImage("images/mobile_banking/Screenshot_2023-03-29_091634-removebg-preview.png"),height: 250,width: 500,),
                10.height,
                Center(
                  child: Wrap(
                    spacing: 60,
                    runSpacing: 30,
                    alignment: WrapAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //AGAppAgentOnboardingScreen().launch(context);
                          AgentLinkAndDlinkScreen(/*data: data,*/).launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                // backgroundImage: AssetImage("images/mobile_banking/agentOnboarding-removebg-preview.png"),
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/Screenshot_2023-03-29_092048-removebg-preview.png"),
                              ),
                              Text("   Agent Link \n   De-Link",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // WALoginScreen(/*data: data*/).launch(context);
                          //AGAPPAuthCheckScreen().launch(context);
                          AGAppCustomerTransScreen().launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/Screenshot_2023-03-29_094435-removebg-preview.png"),
                              ),
                              Text("Transaction \nHistory",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                         WAKYCuploadScreen().launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/Screenshot_2023-03-29_094737-removebg-preview.png"),
                              ),
                              Text("Customer \nKYC",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //WAEditProfileScreen(data: data,).launch(context);
                          AGAppEditProfileScreen(/*data: data,*/).launch(context);
                        },
                        child: Container(
                          width: 125,
                          height: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1.0,
                                ),
                              ]),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: AssetImage(
                                    "images/mobile_banking/Screenshot_2023-03-29_094934-removebg-preview.png"),
                              ),
                              Text("Customer \nProfile",
                                  style: boldTextStyle(size: 13, color: black))
                            ],
                          ),
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     width: 125,
                      //     height: 120,
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(10),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             blurRadius: 1.0,
                      //           ),
                      //         ]),
                      //     child: Column(
                      //       children: [
                      //         CircleAvatar(
                      //           radius: 40,
                      //           backgroundColor: Colors.grey[300],
                      //           backgroundImage: AssetImage(
                      //               "images/mobile_banking/helpoption2-removebg-preview.png"),
                      //         ),
                      //         Text("Help",
                      //             style: boldTextStyle(size: 13, color: black))
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

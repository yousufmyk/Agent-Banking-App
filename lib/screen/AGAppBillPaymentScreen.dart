import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:mobile_banking/screen/AGAppWithdrawScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAWidgets.dart';
import 'AGAppAgentEditProfileScreen.dart';
import 'AGAppBillPayment.dart';
import 'AGAppCashinCashoutScreen.dart';
import 'AGAppCorporateOnboardingScreen.dart';
import 'AGAppCustomerTransScreen.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppKycUploadScreen.dart';
import 'AGAppMainScreen.dart';
import 'AGAppMobileRechargeScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';
import 'AGAppRentPaymentScreen.dart';
import 'AGAppSliderAdvrtScreen.dart';
import 'AGAppTransferScreen.dart';

class AGAppBillPaymentScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppBillPaymentScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<AGAppBillPaymentScreen> createState() =>
      _AGAppBillPaymentScreenState(/*data: data*/);
}

class _AGAppBillPaymentScreenState extends State<AGAppBillPaymentScreen> {
  // _AGAppBillPaymentScreenState({
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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          children: [
            Text("Bill Payment",
                style: boldTextStyle(color: Colors.black, size: 20)),

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
                AGAppKYCuploadScreen().launch(context);
                //_showDialog(context);
                // if value 2 show dialog
              } else if (value == 2) {
                 SessionManager().destroy();
                  AGAppMianScreen(/*data: data,*/).launch(context);
                // _showDialog(context);
              } else if (value == 3) {
                AGAppAgentEditProfileScreen(/*data: data,*/).launch(context);
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
      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          children: [
            50.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    AGAppMobileRechargeScreen(
                      //data: data,
                    ).launch(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image(
                            image: AssetImage(
                                "images/mobile_banking/mobile recharge.png")),
                        Text("Mobile Recharge")
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    AGAppRentPaymentScreen(/*data: data,*/).launch(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image(
                            image: AssetImage("images/mobile_banking/loans.png")),
                        Text("Rent Payment")
                      ],
                    ),
                  ),
                )
              ],
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    children: [
                      Image(
                          image: AssetImage(
                              "images/mobile_banking/electricity.png")),
                      Text("Electricity")
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Image(
                          image: AssetImage("images/mobile_banking/water.png")),
                      Text("Water")
                    ],
                  ),
                )
              ],
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    children: [
                      Image(
                          image: AssetImage(
                              "images/mobile_banking/Insurance.png")),
                      Text("Insurance")
                    ],
                  ),
                ),
               
              ],
            ),
            20.height,
            15.height,
            Container(
              width: 350,
              child: Row(
                children: [
                  Divider(thickness: 2).expand(),
                  Divider(thickness: 2).expand(),
                ],
              ),
            ).center(),
            15.height,
            AGAppBillPaymentSliderAdvert()
          ],
        ),
      ),
    );
  }
}

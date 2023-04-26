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
import 'AGAppAgentTransaction.dart';
import 'AGAppBalanceInq.dart';
import 'AGAppBillPaymentScreen.dart';
import 'AGAppCashinCashoutScreen.dart';
import 'AGAppChooseLoansScreen.dart';
import 'AGAppCorporateOnboardingScreen.dart';
import 'AGAppCustomerTransScreen.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppKycUploadScreen.dart';
import 'AGAppLoansScreen.dart';
import 'AGAppMainScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';
import 'AGAppSliderAdvrtScreen.dart';
import 'AGAppTransferScreen.dart';
import 'WABillPayScreen.dart';
import 'WADashboardScreen.dart';
import 'WAHomeScreen.dart';

class AGAppFinancialScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppFinancialScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<AGAppFinancialScreen> createState() =>
      _AGAppFinancialScreenState(/*data: data*/);
}

class _AGAppFinancialScreenState extends State<AGAppFinancialScreen> {
  // _AGAppFinancialScreenState({
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
    var agentname = SessionManager().get("userdata");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          children: [
            Text("Agent 01",
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      showInDialog(context, builder: (context) {
                        return BalanceInq();
                      });
                    },
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                                "images/mobile_banking/balance check.png"),
                            width: 80,
                            height: 100,
                          ),
                          Text("Balance Enquiry",
                              style:
                                  boldTextStyle(color: Colors.grey, size: 15))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // AGAppBillPaymentScreen(
                      //   data: data,
                      // ).launch(context);
                      //AGAppLoanScreen(data: data,).launch(context);

                      ChooseLoanScreen(
                       // data: data,
                      ).launch(context);
                      // WABillPayScreen(
                      //   data: data,
                      // ).launch(context);
                    },
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                AssetImage("images/mobile_banking/loans.png"),
                            width: 80,
                            height: 100,
                          ),
                          Text("Loan",
                              style:
                                  boldTextStyle(color: Colors.grey, size: 15))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AGAppBillPaymentScreen(
                       // data: data,
                      ).launch(context);
                      // WABillPayScreen(
                      //   data: data,
                      // ).launch(context);
                    },
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                                "images/mobile_banking/billpayment.png"),
                            width: 80,
                            height: 100,
                          ),
                          Text("Bill Payment",
                              style:
                                  boldTextStyle(color: Colors.grey, size: 15))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              20.height,
              //this is the middle image
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        WADashboardScreen(
                          //data: data,
                        ).launch(context);
                      },
                      child: Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  "images/mobile_banking/Screenshot 2023-03-29 195302.png"),
                              width: 80,
                              height: 80,
                            ),
                            Text("Agent \nDashboard",
                                style:
                                    boldTextStyle(color: Colors.grey, size: 15))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                                "images/mobile_banking/Agency Banking.png"),
                            width: 100,
                            height: 100,
                          ),
                          Text("Agency Banking",
                              style:
                                  boldTextStyle(color: Colors.blue, size: 20))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //AGAppCustomerTransScreen().launch(context);
                        AGAppAgentTransScreen().launch(context);
                      },
                      child: Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image:
                                  AssetImage("images/mobile_banking/bill.png"),
                              width: 100,
                              height: 100,
                            ),
                            Text("Transaction \nHistory",
                                style:
                                    boldTextStyle(color: Colors.grey, size: 15))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //middle image ends here
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      AGAppCashInCashOutScreen().launch(context);
                    },
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                AssetImage("images/mobile_banking/cashout.png"),
                            width: 100,
                            height: 100,
                          ),
                          Text("Cash In / Cash out",
                              style:
                                  boldTextStyle(color: Colors.grey, size: 15))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AGAppTransferScreen(
                        //data: data,
                      ).launch(context);
                    },
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(
                                "images/mobile_banking/transferIMG.png"),
                            width: 100,
                            height: 100,
                          ),
                          Text("Transfer",
                              style:
                                  boldTextStyle(color: Colors.grey, size: 15))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

              AGAppSliderAdvert()
            ],
          ),
        ),
      ),
    );
  }
}

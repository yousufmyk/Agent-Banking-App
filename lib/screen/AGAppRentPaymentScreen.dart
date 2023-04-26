import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mobile_banking/screen/AGAppWithdrawScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAWidgets.dart';
import 'AGAppBillPayment.dart';
import 'AGAppCashinCashoutScreen.dart';
import 'AGAppCorporateOnboardingScreen.dart';
import 'AGAppCustomerTransScreen.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppMobileRechargeScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';
import 'AGAppSliderAdvrtScreen.dart';
import 'AGAppTransferScreen.dart';
import 'AGRentPaymentScreen.dart';

class AGAppRentPaymentScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppRentPaymentScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<AGAppRentPaymentScreen> createState() =>
      _AGAppRentPaymentScreenState(/*data: data*/);
}

class _AGAppRentPaymentScreenState extends State<AGAppRentPaymentScreen> {
  // _AGAppRentPaymentScreenState({
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
        title: Text("Rent Payment",
            style: boldTextStyle(color: Colors.black, size: 20)),
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
            20.height,
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    AGAppRentPayScreen(
                     // data: data,
                    ).launch(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        size: 60,
                        color: Colors.blueAccent,
                      ),
                      15.width,
                      Text("Home/Shop Rent",
                          style: boldTextStyle(color: Colors.black, size: 15))
                    ],
                  ),
                ),
                10.height,
                Row(
                  children: [
                    Icon(
                      Icons.home_filled,
                      size: 60,
                      color: Color.fromARGB(255, 224, 199, 84),
                    ),
                    15.width,
                    Text("Socity Maintenance",
                        style: boldTextStyle(color: Colors.black, size: 15))
                  ],
                ),
                10.height,
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.redAccent,
                    ),
                    15.width,
                    Text("Broker Payment",
                        style: boldTextStyle(color: Colors.black, size: 15))
                  ],
                ),
                10.height,
                Row(
                  children: [
                    Icon(
                      Icons.money,
                      size: 60,
                      color: Colors.greenAccent,
                    ),
                    15.width,
                    Text("Property Deposit",
                        style: boldTextStyle(color: Colors.black, size: 15))
                  ],
                ),
                10.height,
              ],
            )
          ],
        ),
      ),
    );
  }
}

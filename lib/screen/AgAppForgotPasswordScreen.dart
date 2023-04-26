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
import 'AGAppOtpVerificationScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';
import 'AGAppSliderAdvrtScreen.dart';
import 'AGAppTransferScreen.dart';
import 'WABillPayScreen.dart';
import 'WADashboardScreen.dart';
import 'WAHomeScreen.dart';

class AGAppForgotPasswordScreen extends StatefulWidget {
  @override
  State<AGAppForgotPasswordScreen> createState() =>
      _AGAppForgotPasswordScreenState(/*data: data*/);
}

class _AGAppForgotPasswordScreenState extends State<AGAppForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.teal,
        title: Text("Forogt Password",
            style: boldTextStyle(color: Colors.black, size: 20)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(
                          "images/mobile_banking/Screenshot_2023-04-06_115223-removebg-preview.png"),
                      width: 500,
                      height: 250,
                    ),
                    Text("Forgot Password?",
                        style: boldTextStyle(color: Colors.black, size: 20)),
                    16.height,
                    Text("Don't worry we'll help you to recover your password"),
                    26.height,
                    GestureDetector(
                      onTap: (){
                        AGAppOtpVerificationScreen().launch(context);
                      },
                      child: Container(
                        width: 250,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 8, 65, 112),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Text(
                          "OTP Verification",
                          style: boldTextStyle(color: Colors.white, size: 20),
                        )),
                        
                      ),
                    ),
                    36.height,
                    Container(
                      width: 250,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 8, 65, 112),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        "Security Questions",
                        style: boldTextStyle(color: Colors.white, size: 20),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

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

import '../Controllers/OtpControllersForAgentApp.dart';
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

import 'AGAppEnterOtpScreen.dart';
import 'AGAppKycUploadScreen.dart';
import 'AGAppLoansScreen.dart';
import 'AGAppMainScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';
import 'AGAppSliderAdvrtScreen.dart';
import 'AGAppTransferScreen.dart';
import 'WABillPayScreen.dart';
import 'WADashboardScreen.dart';
import 'WAHomeScreen.dart';
import 'package:http/http.dart' as http;

class AGAppOtpVerificationScreen extends StatefulWidget {
  @override
  State<AGAppOtpVerificationScreen> createState() =>
      _AGAppOtpVerificationScreenState(/*data: data*/);
}

class _AGAppOtpVerificationScreenState
    extends State<AGAppOtpVerificationScreen> {
  final controller = Get.put(AgentAppOtpController());

  FocusNode usernameFocus = FocusNode();

  verfiyEmail() async {
    //var length = await image!.length();
    final email = controller.username.text.toString();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/checkexistedCustomerDetails');

    var request = http.MultipartRequest('GET', uri);

    request.fields['EmailId'] = email;
    request.fields['InstId'] = 'OMA';

    var response = await request.send();

    if (response.statusCode == 200) {
      final emailrespStr = await response.stream.bytesToString();
      print('Sucess');

      if (emailrespStr == "true") {
        var status = Text(
          "Email Not Available",
          style: TextStyle(color: Colors.redAccent),
        );
        setState(() {
          //emailStatus = status;
        });
      }
      if (emailrespStr == "false") {
        var status = Text(
          "Email Available",
          style: TextStyle(color: Colors.greenAccent),
        );
        setState(() {
          // emailStatus = status;
        });
      }
      try {
        final response = await http.post(
          Uri.parse('http://10.0.33.181:8089/NanoAgencyBanking/v1/app/sendOTP'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "instId": "OMA",
            "userName": email,
            "requestType": "AGENT-PWDRESET"
          }),
        );
        if (response.statusCode == 200) {
          print("otpSendSucess");
          AGAppEnterOtpScreen().launch(context);
        } else {
          print("error in otp send api");
        }
      } catch (e) {
        print(response.statusCode.toString());
      }

      print(emailrespStr);
    } else {
      print(response.toString());
      final emailrespStr = await response.stream.bytesToString();
      //print(response.statusCode);
      print('failed');
      print(emailrespStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.teal,
        title: Text("OTP Verification",
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
                          "images/mobile_banking/Screenshot_2023-04-06_121442-removebg-preview.png"),
                      width: 500,
                      height: 250,
                    ),
                    Text("Enter your user name here",
                        style: boldTextStyle(color: Colors.black, size: 20)),
                    16.height,
                    //Text("Don't worry we'll help you to recover your password"),
                    26.height,
                    AppTextField(
                      decoration: waInputDecoration(
                          hint: 'Enter your user name here',
                          bgColor: Colors.transparent,
                          prefixIcon: Icons.person),
                      textFieldType: TextFieldType.EMAIL,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.username,
                      focus: usernameFocus,
                      //nextFocus: passWordFocusNode,
                    ).paddingOnly(left: 28, right: 28),

                    36.height,
                    GestureDetector(
                      onTap: () {
                        verfiyEmail();
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
                          "Proceed",
                          style: boldTextStyle(color: Colors.white, size: 20),
                        )),
                      ),
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

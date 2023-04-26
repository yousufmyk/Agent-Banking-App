import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:mobile_banking/screen/AGAppWithdrawScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Controllers/OtpControllersForAgentApp.dart';
import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAColors.dart';
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

class AGAppEnterOtpScreen extends StatefulWidget {
  @override
  State<AGAppEnterOtpScreen> createState() =>
      _AGAppEnterOtpScreenState(/*data: data*/);
}

class _AGAppEnterOtpScreenState extends State<AGAppEnterOtpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmnewPasswordController = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode confirmnewPasswordFocus = FocusNode();

  final controller = Get.put(AgentAppOtpController());

  var otpstatus = '';
  Future verifyotp() async {
    final username = controller.username.text.toString();

    final response = await http.post(
      Uri.parse('http://10.0.33.181:8089/NanoAgencyBanking/v1/app/validateOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "instId": "OMA",
        "otp": pinController.text.toString(),
        "userName": username
      }),
    );
    var data = jsonDecode(response.body);
    var msg = (data as Map)['responseMessage'];
    if (response.statusCode == 200) {
      print(msg);
      print("sucess");
      print(username);
      setState(() {
        otpstatus = msg.toString();
      });
    } else {
      setState(() {
        otpstatus = msg.toString();
      });
      print(msg);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete All field')));
      print(response.statusCode);
    }
  }

  Future resetPassword() async {
    final username = controller.username.text.toString();
    final newpwd = newPasswordController.text.toString();
    final confirmNewPwd = confirmnewPasswordController.text.toString();

    final response = await http.post(
      Uri.parse(
          'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/passwordResetOrChange/pwdReset'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "instId": "OMA",
        "userName": username,
        "newPassword": newpwd,
        "confirmNewPassword": confirmNewPwd,
        "deviceType": "MOBILE"
      }),
    );
    var data = jsonDecode(response.body);
    // var msg = (data as Map)['responseMessage'];
    if (response.statusCode == 200) {
       showInDialog(context, builder: (context) {
        return _onResetPassword(context);
      });
      print("Sucess");
    } else {
      
      print("Error");
      print(response.body);
      print(response.statusCode);
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
                    20.height,
                    Text("OTP sent to",
                        style: boldTextStyle(color: Colors.grey, size: 20)),
                    Text("you***@omaemirates.com",
                        style: boldTextStyle(color: Colors.grey, size: 20)),
                    Text("sucessfully",
                        style: boldTextStyle(color: Colors.grey, size: 20)),
                    30.height,
                    Pinput(
                      controller: pinController,
                      length: 4,
                      obscureText: true,
                      toolbarEnabled: false,
                      onSubmitted: (value) {
                        print(value);
                        verifyotp();
                      },
                      //inputFormatters: [Formatter()],
                    ),
                    5.height,
                    Text(otpstatus),
                    30.height,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Reset Password",
                          style: boldTextStyle(color: Colors.black, size: 20)),
                    ).paddingOnly(left: 16),
                    16.height,
                    AppTextField(
                      decoration: waInputDecoration(
                          hint: 'Enter your Password',
                          prefixIcon: Icons.lock_outline),
                      suffixIconColor: WAPrimaryColor,
                      textFieldType: TextFieldType.PASSWORD,
                      isPassword: true,
                      expands: false,
                      keyboardType: TextInputType.visiblePassword,
                      controller: newPasswordController,
                      focus: newPasswordFocus,
                    ).paddingOnly(left: 26, right: 26),
                    10.height,
                    AppTextField(
                      decoration: waInputDecoration(
                          hint: 'Confirm Password',
                          prefixIcon: Icons.lock_outline),
                      suffixIconColor: WAPrimaryColor,
                      textFieldType: TextFieldType.PASSWORD,
                      isPassword: true,
                      expands: false,
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmnewPasswordController,
                      focus: confirmnewPasswordFocus,
                    ).paddingOnly(left: 26, right: 26),
                    56.height,
                    GestureDetector(
                      onTap: () {
                        // verfiyEmail();
                        resetPassword();
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
                          "Reset Password",
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

_onResetPassword(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      waCommonCachedNetworkImage(
          'https://media.istockphoto.com/id/1457703344/vector/pop-icon-with-emphasized-check-mark-vector.jpg?s=612x612&w=0&k=20&c=x0cDKqIfDWV73obRlogUUoPlrRc-GUj5B9fUEoGC3Fw=',
          height: 200,
          width: 200,
          fit: BoxFit.fill),
      16.height,
      Text('Done!', style: secondaryTextStyle()),
      16.height,
      Text(
          'Your Password Updated Successfully.',
          style: boldTextStyle(size: 22),
          textAlign: TextAlign.center),
      8.height,
      Text(
          'You Can Now Login With Your New Password',
          style: boldTextStyle(size: 22),
          textAlign: TextAlign.center),

       

      // Text('Account no endings ***${controller.reciverAccountNumController.text.toString()}', style: secondaryTextStyle()),
      30.height,
      AppButton(
        color: WAPrimaryColor,
        width: 180,
        height: 50,
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        text: "Done",
        onTap: () {
          //WADashboardScreen(data: widget.data,).launch(context);
          //finish(context);
          //AGAppMianScreen().launch(context);
        },
        textStyle: boldTextStyle(color: Colors.white),
      ),
      16.height,
    ],
  );
}

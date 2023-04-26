import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gif_view/gif_view.dart';
import 'package:mobile_banking/screen/WALoginSliderImageScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/screen/WARegisterScreen.dart';
import 'package:mobile_banking/utils/WAColors.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';

import '../Controllers/CustomerLoginController.dart';
import '../Controllers/LogInController.dart';
import '../component/WAFingerprintComponent.dart';
import '../component/WAOperationComponent.dart';
import '../main.dart';
import '../model/Api Service/Auth Apis/CustomerLoginApi.dart';
import '../model/Api Service/Auth Apis/loginApi.dart';
import '../model/WalletAppModel.dart';
import '../model/cardDetailsModel.dart';
import 'WACreditCardScreen.dart';
import 'WAEditProfileScreen.dart';
import 'WALoginScreenFeatureScreen.dart';
import 'WAOtpEnterScreen.dart';
import 'WASendMoneyViaLoopScreen.dart';
import 'WAVoucherScreen.dart';
import 'package:http/http.dart' as http;

class AGAppCustomerLoginScreen extends StatefulWidget {
  static String tag = '/WALoginScreen';

  @override
  AGAppCustomerLoginScreenState createState() => AGAppCustomerLoginScreenState(/*data:data*/);
}

class AGAppCustomerLoginScreenState extends State<AGAppCustomerLoginScreen> {
  final emailController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  final newcontroller = Get.put(CustomerLoginController());
  bool showBiometrics = false;
  bool isAuthenticated = false;
  // var val = SessionManager().set("userr", "hello");

  bool status = true;

  _onChanged() async {
    bool user = await SessionManager().containsKey("userdata");
    if (user == false) {
      setState(() {
        status = true;
        // print("hello");
        // print(user.toString());
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  Future sendOtp() async {
    var userName = await SessionManager().get("userdata");
    // final optToVerify = controller.otp.text.toString();
    final response = await http.post(
      Uri.parse(
          'http://sandboxdev.omaemirates.com:9502/NanoCustomerService/v1/mobileOtp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "instId": "OMA",
        "userName": userName,
        "custId": "0000000000111"
      }),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return {print("Sucess")};
    } else {
      return {print("there is some error")};
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  isBiometricAvailable() async {
    // showBiometrics = await FingerPrintComponent().hasEnrolledBiometics();
    setState(() {});
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CustomerLoginController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Customer Login',
          style: boldTextStyle(color: Colors.black, size: 20),
        ),
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/mobile_banking/newbg.png'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // 50.height,
              // Text("Log In", style: boldTextStyle(size: 24, color: black)),
              Container(
                margin: EdgeInsets.all(16),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      margin: EdgeInsets.only(top: 55.0),
                      decoration: boxDecorationWithShadow(
                          borderRadius: BorderRadius.circular(30),
                          backgroundColor: Colors.transparent),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //ElevatedButton(onPressed: _remove, child: Text('Remove')),
                                GifView.asset(
                                  "images/mobile_banking/Record_2023_03_27_10_52_30_388.gif",
                                  height: 200,
                                  width: 500,
                                  frameRate: 30,
                                  progress:
                                      Text("Loading..."), // default is 15 FPS
                                ),
                                10.height,
                                // Align(
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     "Agent Login",
                                //     style: boldTextStyle(
                                //         color: Colors.blue, size: 20),
                                //   ),
                                // ),
                                FutureBuilder(
                                    future: _onChanged(),
                                    builder: (context, snapshot) {
                                      return Visibility(
                                          maintainSize: false,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          visible: status,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Text("User Name",
                                                    style: boldTextStyle(
                                                        size: 14)),
                                                8.height,
                                                AppTextField(
                                                  decoration: waInputDecoration(
                                                      hint:
                                                          'Enter your email here',
                                                      prefixIcon: Icons.person),
                                                  textFieldType:
                                                      TextFieldType.EMAIL,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  controller: _controller.email,
                                                  focus: emailFocusNode,
                                                  nextFocus: passWordFocusNode,
                                                ),
                                              ],
                                            ),
                                          ));
                                    }),

                                56.height,

                                Text("Enter your Password",
                                        style: boldTextStyle(size: 14))
                                    .center(),
                                8.height,
                                AppTextField(
                                  decoration: waInputDecoration(
                                      hint: 'Enter your Password here',
                                      prefixIcon: Icons.lock_outline),
                                  suffixIconColor: WAPrimaryColor,
                                  textFieldType: TextFieldType.PASSWORD,
                                  isPassword: true,
                                  expands: false,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _controller.password,
                                  focus: passWordFocusNode,
                                ),
                                /*.paddingOnly(right: 80),*/
                                // Align(
                                //   alignment: Alignment.topRight,

                                //   child: IconButton(onPressed: (){}, icon: Icon(Icons.fingerprint))),
                                16.height,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await sendOtp();
                                      WAOTpEnterScreen().launch(context);
                                    },
                                    child: Text("Forgot PIN?",
                                        style: primaryTextStyle()),
                                  ),
                                ),
                                16.height,
                                //LoginApiService(/*data: data,*/),
                                CustomerLoginApiService(),
                                20.height,
                                if (showBiometrics)
                                  ElevatedButton(
                                      onPressed: () async {
                                        isAuthenticated =
                                            await FingerPrintComponent()
                                                .authenticate();
                                        setState(() {});
                                      },
                                      child: Text('Fingerprint Login')),
                                if (isAuthenticated)
                                  Text("Helloworld",
                                      style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   height: 100,
                    //   width: 100,
                    //   decoration: boxDecorationRoundedWithShadow(30,
                    //       backgroundColor: context.cardColor),
                    //   child: Image.asset(
                    //     'images/mobile_banking/logo-removebg-preview1.png',
                    //     height: 80,
                    //     width: 80,
                    //     //color: appStore.isDarkModeOn ? white : black,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                  ],
                ),
              ),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:mobile_banking/dashboard/utility_tracker/model/utility_tracker_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Controllers/CustomerLoginController.dart';
import '../../../Controllers/LogInController.dart';
import '../../../component/WAFingerPrintDailog.dart';
import '../../../screen/AGAppCustomerOnboardingScreen.dart';
import '../../../screen/AGAppCustomerPortfolioScreen.dart';
import '../../../screen/WADashboardScreen.dart';
import '../../../screen/WAEditProfileScreen.dart';
import '../../../screen/AGAppAgentLoginScreen.dart';
import '../../../utils/WAColors.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../cardDetailsModel.dart';
import 'package:http/http.dart' as http;

import '../BioMetric Apis/fingerPrintApi.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomerLoginApiService extends StatefulWidget {
  @override
  State<CustomerLoginApiService> createState() => _CustomerLoginApiServiceState();
}

class _CustomerLoginApiServiceState extends State<CustomerLoginApiService> {
  final newController = Get.put(CustomerLoginController());

  Future<bool> login(String email, String password, BuildContext context,
      CustomerLoginController controller) async {
    var emailnew = email;
    var newvalue = await SessionManager().get("userdata");
    // ignore: unnecessary_null_comparison

    if (emailnew.isEmpty == true) {
      setState(() {
        emailnew = newvalue.toString();
        // print("hello");
        // print(user.toString());
      });
    }

    try {
      final response = await post(
        Uri.parse(
            'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "instId": "OMA",
          // "userName": email,
          "userName": emailnew,
          //"deviceType": "MOBILE",
          "password": password,
          //"role": "Customer",
          //"deviceId": "M2101K7BI"
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var tokenVal = (data as Map)['bearerToken'];
        await SessionManager().set("token", tokenVal);
        print(tokenVal);
        await SessionManager().set("userdata", emailnew.toString());
        var kycMsg = (data as Map)['kycExpiryAlertMsg'];
        print(kycMsg);

        bool isExpired = true;
        if (isExpired == true) {
          await SessionManager().set("emiratesExpires", true);
          print("${await SessionManager().get("emiratesExpires")}");
          //await _onAlertButtonsPressed(context);
        } else if (isExpired == false) {
          await SessionManager().set("emiratesExpires", false);
          await Get.snackbar(
            "Warning!",
            kycMsg,
            backgroundColor: Colors.redAccent,
            colorText: Color.fromARGB(255, 255, 255, 255),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        CustomerPortfolioScreen(/*data: data,*/).launch(context);

        // try {
        //   var token = await SessionManager().get("token");
        //   final response = await http.get(
        //     Uri.parse(
        //         'http://sandboxdev.omaemirates.com:9501/NanoCMS/v1/nanocms/getCardOrderInfo/OMA/OMA0000000000067'),
        //     headers: <String, String>{
        //       'Content-Type': 'application/json; charset=UTF-8',
        //       'Authorization': 'Bearer $token',
        //     },
        //   );

        //   if (response.statusCode == 200) {
        //     var data = CreditCardModel.fromJson(jsonDecode(response.body));

        //     //WAFingerPrintDialog(data: data).launch(context);
        //     //AGAppCustomerOnboardScreen().launch(context);
        //     CustomerPortfolioScreen(/*data: data,*/).launch(context);
        //     // return CreditCardModel.fromJson(jsonDecode(response.body));
        //   } else {
        //     print("cards details Api not working");
        //   }
        // } catch (e) {
        //   print("cards details Api not working");
        // }

        var bearerToken = data[0];
        print(bearerToken);
        return true;
      } else {
        //print(newvalue.toString());
        print(password.toString());
        print(response.statusCode);
        print(email);
        print(newvalue);
        print(password);
        print('There is some error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please Enter Correct Email/Password')));
        return false;

        //_incorrectPin(context,controller);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please try again later')));
      print(e.toString());
    }
    return false;
  }

  // Future<CreditCardModel> getCardDetails() async {
  //   try {
  //     var token = await SessionManager().get("token");
  //     final response = await http.get(
  //       Uri.parse(
  //           'http://sandboxdev.omaemirates.com:9501/NanoCMS/v1/nanocms/getCardOrderInfo/OMA/OMA0000000000067'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       var data = CreditCardModel.fromJson(jsonDecode(response.body));
  //       //var data2 = CreditCardModel.fromJson(data);
  //       WADashboardScreen(
  //               /*data: CreditCardModel.fromJson(jsonDecode(response.body))*/)
  //           .launch(context);
  //       return CreditCardModel.fromJson(jsonDecode(response.body));
  //     } else {
  //       throw Exception("There is some erre");
  //     }
  //   } catch (e) {
  //     throw Exception("There is some erre");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final newController = Get.put(CustomerLoginController());
    return AppButton(
            text: "Log In",
            color: Color.fromARGB(255, 8, 65, 112),
            textColor: Colors.white,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            width: MediaQuery.of(context).size.width,
            onTap: () async {
              // WAEditProfileScreen(
              //         isEditProfile: false)
              //     .launch(context);
              await login(
                  newController.email.text.toString(),
                  newController.password.text.toString(),
                  context,
                  CustomerLoginController());
            })
        .paddingOnly(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1);
  }
}

_onAlertButtonsPressed(context) {
  Alert(
      context: context,
      //type: AlertType.warning,
      type: AlertType.warning,
      title: 'Warning alert',
      desc: 'Testing Alerts this is the Animated one',
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            'FLAT',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0),
          ]),
          child: const Text(
            'GRADIENT',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]).show();
}
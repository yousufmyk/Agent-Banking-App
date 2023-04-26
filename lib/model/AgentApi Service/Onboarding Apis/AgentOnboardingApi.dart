import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Controllers/AgentOnboaridngController.dart';
import 'package:http/http.dart' as http;

import '../../../screen/AGAppMainScreen.dart';
import '../../../utils/WAColors.dart';
import '../../../utils/WAWidgets.dart';

class AgentOnboardingApi extends StatefulWidget {
  const AgentOnboardingApi({Key? key}) : super(key: key);

  @override
  State<AgentOnboardingApi> createState() => _AgentOnboardingApiState();
}

class _AgentOnboardingApiState extends State<AgentOnboardingApi> {
  final controller = Get.put(AgentOnboardingController());
  Future onboardAgent() async {
    final username = controller.agentUserName.text.toString();
    final password = controller.agentPassword.text.toString();
    final emailId = controller.agentEmail.text.toString();
    final mobileNum = controller.agentMobileNumber.text.toString();
    final firstName = controller.agentFirstName.text.toString();
    final lastName = controller.agentLastName.text.toString();
    final dob = controller.agentDOB.text.toString();
    final cifId = controller.agentCif.text.toString();

    final uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/agentOnBoarding');
    var map = new Map<String, dynamic>();
    map['userName'] = username;
    map['password'] = password;
    map['emailId'] = emailId;
    map['mobileCountryCode'] = '+971';
    map['mobileNumber'] = mobileNum;
    map['instId'] = 'OMA';
    map['customerType'] = 'type1';
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['role'] = 'Agent';
    map['deviceType'] = 'WEB';
    map['dob'] = dob;
    map['mcc'] = 'abcde';
    map['businessType'] = 'asdfg';
    map['tradeLicenseCode'] = 'xyz';
    map['agentId'] = '100';
    map['accountNumber'] = '9876543210123456';
    map['cifId'] = cifId;
    map['cityId'] = '1,2';

    var boody = jsonEncode(map);

    final response = await http.post(
      //uri,
      Uri.parse(
          'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/agentOnBoarding'),
      body: boody,
      // headers: <String, String>{
      //   'Content-Type': 'application/x-www-form-urlencoded',

      // },
    );
    // var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print("sucess");

      // showInDialog(context, builder: (context) {
      //   return _OnDepositDone(context, controller.agentUserName);
      // });
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text('Please complete All field')));
      print(response.statusCode);
      print(response.request.toString());
    }
  }

  Future<void> uploadImage() async {
    //final controller = Get.put(AgentOnboardingController());
    //var stream = http.ByteStream(image!.openRead());
    //stream.cast();

    //var length = await image!.length();
    final username = controller.agentUserName.text.toString();
    final password = controller.agentPassword.text.toString();
    final emailId = controller.agentEmail.text.toString();
    final mobileNum = controller.agentMobileNumber.text.toString();
    final firstName = controller.agentFirstName.text.toString();
    final lastName = controller.agentLastName.text.toString();
    final dob = controller.agentDOB.text.toString();
    final cifId = controller.agentCif.text.toString();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/agentOnBoarding');

    var request = http.MultipartRequest('POST', uri);

    //var multiport = http.MultipartFile('image', stream, length);

    //request.files.add(multiport);
    request.fields['userName'] = username;
    // request.fields['password'] = controller.agentPassword.text.toString();
    request.fields['password'] = password;
    request.fields['emailId'] = emailId;
    request.fields['mobileCountryCode'] = '+971';
    request.fields['mobileNumber'] = mobileNum;
    request.fields['instId'] = 'OMA';
    request.fields['customerType'] = 'type1';
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['role'] = 'Agent';
    request.fields['deviceType'] = 'WEB';
    request.fields['dob'] = dob;
    request.fields['mcc'] = 'abcde';
    request.fields['businessType'] = 'asdfg';
    request.fields['tradeLicenseCode'] = 'xyz';
    request.fields['agentId'] = '100';
    request.fields['accountNumber'] = '9876543210123456';
    request.fields['cifId'] = cifId;
    request.fields['cityId'] = '1';

    var response = await request.send();

    if (response.statusCode == 200) {
      // setState(() {
      //   showSpinner = false;
      // });
      //final data = jsonDecode(response.);
      final respStr = await response.stream.bytesToString();
      print('Sucess');
      print(controller.agentPassword.text.toString());
      print(request.toString());
      print(respStr);
      // print(response.);
    } else {
      // setState(() {
      //   showSpinner = false;
      // });
      print(response.toString());
      final respStr = await response.stream.bytesToString();
      //print(response.statusCode);
      print('failed');
      print(respStr);
    }
  }

  _OnDepositDone(BuildContext context, TextEditingController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        waCommonCachedNetworkImage(
            'https://media.istockphoto.com/id/1317078770/vector/checklist-or-clipboard-icon.jpg?s=612x612&w=0&k=20&c=te6Rqq4TSDw-i7-16rliqq7o63bsKMSL8ayawKGUPP4=',
            height: 200,
            width: 200,
            fit: BoxFit.fill),
        16.height,
        Text('Done!', style: secondaryTextStyle()),
        16.height,
        Text(
            'Agent: $controller Registred Successfully. Waiting For Admin Approval',
            style: boldTextStyle(size: 22),
            textAlign: TextAlign.center),
        8.height,

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
            AGAppMianScreen().launch(context);
          },
          textStyle: boldTextStyle(color: Colors.white),
        ),
        16.height,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppButton(
              text: "Register Account",
              color: WAPrimaryColor,
              textColor: Colors.white,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              onTap: () async {
                //await onboardAgent();
                await uploadImage();
                // await getpostStatment();
                // showInDialog(context, builder: (context) {
                //   // return WAMoneyTransferCompleteDialog(
                //   //   data: data,
                //   // );
                //   // return _EnterOtpScreen(
                //   //     context, otpController, otpFocus, data);
                //   return _OnDepositDone(context,controller.agentUserName);
                // });
              })
          .paddingOnly(
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1),
    );
  }
}

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import '../../../Controllers/AgentOnboaridngController.dart';

// class ValidateEmailApi extends StatefulWidget {
//   const ValidateEmailApi({Key? key}) : super(key: key);

//   @override
//   State<ValidateEmailApi> createState() => _ValidateEmailApiState();
// }

// class _ValidateEmailApiState extends State<ValidateEmailApi> {
//   final controller = Get.put(AgentOnboardingController());
//   var userNameStatus = Text("");
//   Future verfiyUserName() async {
//     //var length = await image!.length();
//     final username = controller.agentUserName.text.toString();

//     var uri = Uri.parse(
//         'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/checkexistedCustomerDetails');

//     var request = http.MultipartRequest('GET', uri);

//     request.fields['userName'] = username;
//     request.fields['InstId'] = 'OMA';

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       final respStr = await response.stream.bytesToString();
//       print('Sucess');

//       if (respStr == "true") {
//         var status = Text(
//           "User Name Not Available",
//           style: TextStyle(color: Colors.redAccent),
//         );
//         setState(() {
//           userNameStatus = status;
//         });
//       }
//       if (respStr == "false") {
//         var status = Text(
//           "User Name Available",
//           style: TextStyle(color: Colors.greenAccent),
//         );
//         setState(() {
//           userNameStatus = status;
//         });
//       }
//     } else {
//       print(response.toString());
//       final respStr = await response.stream.bytesToString();
//       //print(response.statusCode);
//       print('failed');
//       print(respStr);
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Tex
//   }
// }

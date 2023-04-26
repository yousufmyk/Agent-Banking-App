import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/component/WAMoneyTransferCompeteDialog.dart';
import 'package:mobile_banking/component/WARecentPayeesComponent.dart';
import 'package:mobile_banking/component/WASendViaComponent.dart';
import 'package:mobile_banking/model/WalletAppModel.dart';
import 'package:mobile_banking/utils/WAColors.dart';
import 'package:mobile_banking/utils/WADataGenerator.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';
import 'package:pinput/pinput.dart';
// import 'package:mobile_banking/utils/widgets/slider.dart';
import 'package:slider_button/slider_button.dart';

import '../Controllers/recipentsController.dart';
import '../main.dart';
import '../model/cardDetailsModel.dart';
import 'package:http/http.dart' as http;

class AGAppDepositScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppDepositScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  // static String tag = '/WASendMoneyViaLoopScreen';

  @override
  AGAppDepositScreenState createState() => AGAppDepositScreenState();
}

class AGAppDepositScreenState extends State<AGAppDepositScreen> {
//  AGAppDepositScreenState({
//     required this.data,
//   }) : assert(data != null);
//   final CreditCardModel data;

  final controller = Get.put(ReceiptsNameController());

  TextEditingController receiptNameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController cifController = TextEditingController();
  TextEditingController agnetIDController = TextEditingController();
  TextEditingController agnetCIFController = TextEditingController();
  TextEditingController agnetBalanceController = TextEditingController();
  TextEditingController beneficiarynameController = TextEditingController();
  TextEditingController agentbanknameController = TextEditingController();
  TextEditingController agentcomissionController = TextEditingController();
  TextEditingController customerAccountNumberController =
      TextEditingController();

  FocusNode receiptNameFocusNode = FocusNode();
  FocusNode accountFocusNode = FocusNode();
  FocusNode ibanFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  FocusNode agnetCIFFocusNode = FocusNode();
  FocusNode agnetBalanceFocusNode = FocusNode();
  FocusNode beneficiarynameFocusNode = FocusNode();
  FocusNode agentbanknameFocusNode = FocusNode();
  FocusNode agentcomissionFocusNode = FocusNode();
  FocusNode customeraccountNumberFocusNode = FocusNode();

  List<WACardModel> sendViaCardList = waSendViaCardList();
  WACardModel selectedCard = WACardModel();

  var oldPercent = '';
  var agentCIF = '';
  var agentID = '';
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    selectedCard = sendViaCardList[0];
    await Future.delayed(Duration(milliseconds: 500));
    var agentCustID = await SessionManager().get('agentCif');
    var agentId = await SessionManager().get("AgenTid");
    setState(() {
      agentCIF = agentCustID.toString();
      agentID = agentId.toString();
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future hitCashInTransaction() async {
    final token = await SessionManager().get("AgentToken");
    final agentiD = agentID.toString();
    final sourceCustId = agentCIF.toString();
    final desCustId = cifController.text.toString();
    final destAccount = customerAccountNumberController.text.toString();
    final amount = amountController.text.toString();

    final response = await http.post(
      Uri.parse(
          'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/transactionRequest'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        "instId": "OMA",
        "agentId": agentiD,
        "tranType": "CASH-IN",
        "sourceCustId": sourceCustId,
        "destCustId": desCustId,
        "destAccountNumber": destAccount,
        "amount": amount,
        "commission": "10"
      }),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print("Cash in sucess");
      print(response.body.toString());
      // showInDialog(context, builder: (context) {
      //             return WAKYCUploadDialog();
      //           });
     
      showInDialog(context, builder: (context) {
        return _EnterOtpScreen(context, cifController);
      });
    } else {
      print(response.body.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('there is some error in cashin')));
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !_isLoading
           ? Container(
          height: context.mediaQuerySize.height,
          width: context.mediaQuerySize.width,
          //padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/mobile_banking/wa_bg.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //16.height,

                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 162, 177, 189),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Agent CIF Number",
                              style: boldTextStyle(size: 18, color: black))
                          .paddingLeft(16),
                      10.height,
                      AppTextField(
                        readOnly: true,
                        autoFocus: false,
                        decoration: waInputDecoration(
                          hint: agentCIF.toString(),
                          bgColor: context.cardColor,
                          borderColor: Colors.grey,
                        ),
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: agnetCIFController,
                        focus: agnetCIFFocusNode,
                        //nextFocus: accountFocusNode,
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                      16.height,
                    ],
                  ),
                ),
                20.height,
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 162, 177, 189),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Customer CIF Number",
                              style: boldTextStyle(size: 18, color: black))
                          .paddingLeft(16),
                      10.height,
                      AppTextField(
                        autoFocus: false,
                        decoration: waInputDecoration(
                          hint: "Enter Customer CIF Number here",
                          bgColor: context.cardColor,
                          borderColor: Colors.grey,
                        ),
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: cifController,
                        focus: ibanFocusNode,
                        nextFocus: customeraccountNumberFocusNode,
                      ).paddingOnly(left: 16, right: 16, bottom: 10),
                      16.height,
                      Text("Customer Account Number",
                              style: boldTextStyle(size: 18, color: black))
                          .paddingLeft(16),
                      10.height,
                      AppTextField(
                        autoFocus: false,
                        decoration: waInputDecoration(
                          hint: "Enter Account Number here",
                          bgColor: context.cardColor,
                          borderColor: Colors.grey,
                        ),
                        textFieldType: TextFieldType.NAME,
                        keyboardType: TextInputType.name,
                        controller: customerAccountNumberController,
                        focus: customeraccountNumberFocusNode,
                        //nextFocus: beneficiarynameFocusNode,
                      ).paddingOnly(left: 16, right: 16, bottom: 10),
                      6.height,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              // border: Border.all(),
                              //color: Color.fromARGB(255, 205, 226, 84),
                              borderRadius: BorderRadius.circular(5)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text('Agent Comission: ',
                                        style: boldTextStyle(
                                            size: 15, color: black))
                                    .paddingLeft(16),
                                10.width,
                                Container(
                                  width: 50,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(),
                                      color: Color.fromARGB(255, 28, 164, 255)),
                                  child: Center(
                                      child: Text(
                                    " 10%",
                                    style: boldTextStyle(
                                        size: 15,
                                        color: Color.fromARGB(255, 12, 8, 231)),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text('Amount',
                              style: boldTextStyle(size: 18, color: black))
                          .paddingLeft(16),
                      AppTextField(
                        controller: amountController,
                        autoFocus: false,
                        textAlign: TextAlign.center,
                        textFieldType: TextFieldType.OTHER,
                        keyboardType: TextInputType.number,
                        textStyle: TextStyle(fontSize: 22, color: black),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5))),
                        ),
                      ).paddingOnly(left: 16, right: 16),
                      16.height,
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: 16,
                        children: List.generate(
                          amountList.length,
                          (index) {
                            return Container(
                              decoration: boxDecorationWithRoundedCorners(
                                  border: Border.all(),
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 255, 229)
                                          .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(18)),
                              padding: EdgeInsets.only(
                                  left: 22, right: 22, top: 8, bottom: 8),
                              child: Text('AED${amountList[index]}',
                                  style: secondaryTextStyle(
                                      color: appStore.isDarkModeOn
                                          ? black
                                          : WAPrimaryColor)),
                            ).onTap(
                              () {
                                amountController.text = amountList[index]!;
                                setState(() {
                                  var percent = (10 /
                                          100 *
                                          int.parse(amountController.text)) +
                                      int.parse(amountController.text);
                                  oldPercent = percent.toString();
                                });
                              },
                            );
                          },
                        ),
                      ).center(),
                      10.height,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              //color: Color.fromARGB(255, 205, 226, 84),
                              borderRadius: BorderRadius.circular(5)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                    'Total Amount to be collected from Customer: ' +
                                        "",
                                    style:
                                        boldTextStyle(size: 15, color: black))
                                .paddingLeft(16),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(),
                            color: Color.fromARGB(255, 28, 164, 255)),
                        child: Center(
                            child: Text(
                          "$oldPercent",
                          style: boldTextStyle(
                              size: 15, color: Color.fromARGB(255, 12, 8, 231)),
                        )),
                      ).center(),
                      16.height,
                      16.height,
                    ],
                  ),
                ),
                20.height,
                SliderButton(
                  buttonSize: 50,
                  backgroundColor: WAPrimaryColor,
                  dismissible: true,
                  action: () async {
                    ///Do something here
                    // showInDialog(context, builder: (context) {
                    //   return _EnterOtpScreen(context, ibanController,
                    //       amountController, otpController, otpFocusNode);
                    // });
                    setState(() {
                       _isLoading = true;
                     });
                     //CircularProgressIndicator();
                    await hitCashInTransaction();
                    setState(() {
                       _isLoading = false;
                     });
                  },
                  label: Text("Swipe for Payment", style: boldTextStyle()),
                  icon: Icon(Icons.arrow_forward, color: WAPrimaryColor),
                ).center(),
                16.height,
              ],
            ),
          ),
        ): Center(child: const CircularProgressIndicator(
backgroundColor: Colors.transparent,        )),
      ),
    );
  }
}

_EnterOtpScreen(BuildContext context, TextEditingController cifController) {
  TextEditingController otpController = TextEditingController();

  Future hitEnterOtp() async {
    final token = await SessionManager().get("AgentToken");
    final custID = cifController.text.toString();
    final otp = otpController.text.toString();

    final response = await http.post(
      Uri.parse('http://10.0.33.181:8089/NanoAgencyBanking/v1/app/validateOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        "instId": "OMA",
        "requestType": "CASH-IN",
        "custId": custID,
        "otp": otp
      }),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print("otp sucess");
      print(response.body.toString());
      // showInDialog(context, builder: (context) {
      //             return WAKYCUploadDialog();
      //           });
      // showInDialog(context, builder: (context) {
      //   return _EnterOtpScreen(context);
      // });
    } else {
      print(response.body.toString());
      print("otp faild");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('there is some error in cashin')));
      print(response.statusCode);
    }
  }

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        waCommonCachedNetworkImage(
            'https://media.istockphoto.com/id/1369381318/vector/otp-one-time-password-for-secure-transaction-on-digital-payment-transaction.jpg?s=612x612&w=0&k=20&c=6zClJ7mOzkKikt5r0PqiU6HLixos9yakSUyi7vKD7lg=',
            height: 200,
            width: 200,
            fit: BoxFit.fill),
        16.height,
        //Text('Done!', style: secondaryTextStyle()),
        16.height,
        Text('Enter Otp',
            style: boldTextStyle(size: 22), textAlign: TextAlign.center),
        8.height,
        // AppTextField(
        //   autoFocus: false,
        //   decoration: waInputDecoration(
        //     hint: "Enter Otp here",
        //     bgColor: context.cardColor,
        //     borderColor: Colors.grey,
        //   ),

        //   textFieldType: TextFieldType.NAME,
        //   keyboardType: TextInputType.number,
        //   controller: otpController,
        //   focus: otpFocusNode,
        //   //nextFocus: accountFocusNode,
        // ).paddingOnly(left: 16, right: 16, bottom: 16),
        Pinput(
          controller: otpController,
          length: 4,
          obscureText: false,
          toolbarEnabled: false,
          onSubmitted: (value) {
            print(value);

            //verifyotp();
          },
          //inputFormatters: [Formatter()],
        ),

        30.height,
        AppButton(
          color: WAPrimaryColor,
          width: 180,
          height: 50,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          text: "Done",
          onTap: () async {
            // showInDialog(context, builder: (context) {
            //   // return _OnDepositDone(context);
            // });
            await hitEnterOtp();
          },
          textStyle: boldTextStyle(color: Colors.white),
        ),
        16.height,
      ],
    ),
  );
}

// _OnDepositDone(BuildContext context, TextEditingController ibanController,
//     TextEditingController amountController) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       waCommonCachedNetworkImage(
//           'https://media.istockphoto.com/vectors/online-payment-service-banking-or-money-transfer-with-mobile-app-and-vector-id1152615463?k=20&m=1152615463&s=612x612&w=0&h=BoT8RNVKIw1YC_3yhXv-5wrVxXM9NmoaZJx_CKG_3zw=',
//           height: 200,
//           width: 200,
//           fit: BoxFit.fill),
//       16.height,
//       Text('Done!', style: secondaryTextStyle()),
//       16.height,
//       Text('Money Transfer Complete',
//           style: boldTextStyle(size: 22), textAlign: TextAlign.center),
//       8.height,
//       createRichText(list: [
//         TextSpan(
//             text: "You have deposit ${amountController.text.toString()} to ",
//             style: secondaryTextStyle()),
//         TextSpan(
//             text: " ${ibanController.text.toString()}", style: boldTextStyle()),
//       ], textAlign: TextAlign.center),
//       8.height,
//       30.height,
//       AppButton(
//         color: WAPrimaryColor,
//         width: 180,
//         height: 50,
//         shapeBorder:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         text: "Done",
//         onTap: () {
//           //WADashboardScreen(data: widget.data,).launch(context);
//           finish(context);
//         },
//         textStyle: boldTextStyle(color: Colors.white),
//       ),
//       16.height,
//     ],
//   );
// }

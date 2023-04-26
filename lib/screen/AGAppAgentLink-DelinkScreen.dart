import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
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
// import 'package:mobile_banking/utils/widgets/slider.dart';
import 'package:slider_button/slider_button.dart';

import '../Controllers/recipentsController.dart';
import '../main.dart';
import '../model/cardDetailsModel.dart';
import 'AGAppFinancialScreen.dart';

class AgentLinkAndDlinkScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AgentLinkAndDlinkScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  // static String tag = '/WASendMoneyViaLoopScreen';

  @override
  AgentLinkAndDlinkScreenState createState() =>
      AgentLinkAndDlinkScreenState(/*data: data*/);
}

class AgentLinkAndDlinkScreenState extends State<AgentLinkAndDlinkScreen> {
  // AgentLinkAndDlinkScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;

  final controller = Get.put(ReceiptsNameController());

  TextEditingController receiptNameController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController amounttController = TextEditingController();
  TextEditingController toIbanController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController customercifController = TextEditingController();
  TextEditingController benfbanknameController = TextEditingController();
  TextEditingController accountHoldernameController = TextEditingController();
  TextEditingController benfCifController = TextEditingController();
  TextEditingController agentCifController = TextEditingController();
  //TextEditingController otpController = TextEditingController();

  FocusNode receiptNameFocusNode = FocusNode();
  FocusNode accountFocusNode = FocusNode();
  FocusNode toIbanFocusNode = FocusNode();
  FocusNode customerCIFFocusNode = FocusNode();
  FocusNode benfbankFocusNode = FocusNode();
  FocusNode accountholderFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  FocusNode agnetcifFocusNode = FocusNode();

  List<WACardModel> sendViaCardList = waSendViaCardList();
  WACardModel selectedCard = WACardModel();

  var oldPercent = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  var hasaccount = true;

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    selectedCard = sendViaCardList[0];
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Yousuf',
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
          height: context.mediaQuerySize.height,
          width: context.mediaQuerySize.width,
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/mobile_banking/wa_bg.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Text('Agent Link/ D-link',
                        style: boldTextStyle(color: Colors.black, size: 20))
                    .center(),

                20.height,
                Text('Agent Details',
                        style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                16.height,

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("ID: ",
                                style: boldTextStyle(size: 15, color: black)),
                            Text("                              01"),
                          ],
                        ),
                        5.height,
                        Row(
                          children: [
                            Text("Name: ",
                                style: boldTextStyle(size: 15, color: black)),
                            Text("                       Alex"),
                          ],
                        ),
                        5.height,
                        Row(
                          children: [
                            Text("Agent Location: ",
                                style: boldTextStyle(size: 15, color: black)),
                            Text("     United Arab Emirates(UAE)  🇦🇪"),
                          ],
                        ),
                        5.height,
                        Row(
                          children: [
                            Text("Linked Date: ",
                                style: boldTextStyle(size: 15, color: black)),
                            Text("           25-3-2023"),
                          ],
                        ),
                        5.height,
                        Row(
                          children: [
                            Text("Status: ",
                                style: boldTextStyle(size: 15, color: black)),
                            Row(
                              children: [
                                Text("                    Active",
                                    style:
                                        boldTextStyle(size: 15, color: black)),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.greenAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                        5.height,
                        // Row(
                        //   children: [
                        //     Text("Remaining Amount: ",
                        //         style: boldTextStyle(size: 15, color: black)),
                        //     Text("  2244 AED"),
                        //   ],
                        // ),
                        5.height,
                        20.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Link and D-link the agent?",
                                    style:
                                        boldTextStyle(size: 15, color: black))
                                .paddingLeft(16),
                            Row(
                              children: [
                                Text("D-Link"),
                                Switch(
                                  // thumb color (round icon)
                                  activeColor: Colors.amber,
                                  activeTrackColor: Colors.cyan,
                                  inactiveThumbColor: Colors.blueGrey.shade600,
                                  inactiveTrackColor: Colors.grey.shade400,
                                  splashRadius: 50.0,
                                  // boolean variable value
                                  value: hasaccount,
                                  // changes the state of the switch

                                  onChanged: (value) =>
                                      setState(() => hasaccount = value),
                                ),
                                Text("Link")
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Text('Amount', style: boldTextStyle(size: 18, color: black))
                //     .paddingLeft(16),
                // AppTextField(
                //   controller: amounttController,
                //   autoFocus: false,
                //   textAlign: TextAlign.center,
                //   textFieldType: TextFieldType.OTHER,
                //   keyboardType: TextInputType.number,
                //   textStyle: TextStyle(fontSize: 22, color: black),
                //   decoration: InputDecoration(
                //     enabledBorder: UnderlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Colors.grey.withOpacity(0.5))),
                //     focusedBorder: UnderlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Colors.grey.withOpacity(0.5))),
                //   ),
                // ).paddingOnly(left: 16, right: 16),
                // 16.height,
                // Wrap(
                //   alignment: WrapAlignment.center,
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   runAlignment: WrapAlignment.center,
                //   spacing: 16,
                //   children: List.generate(
                //     amountList.length,
                //     (index) {
                //       return Container(
                //         decoration: boxDecorationWithRoundedCorners(
                //             backgroundColor: WAPrimaryColor.withOpacity(0.2),
                //             borderRadius: BorderRadius.circular(18)),
                //         padding: EdgeInsets.only(
                //             left: 22, right: 22, top: 8, bottom: 8),
                //         child: Text('AED${amountList[index]}',
                //             style: secondaryTextStyle(
                //                 color: appStore.isDarkModeOn
                //                     ? black
                //                     : WAPrimaryColor)),
                //       ).onTap(
                //         () {
                //           amounttController.text = amountList[index]!;
                //           setState(() {
                //             var percent =
                //                 (10 / 100 * int.parse(amounttController.text)) +
                //                     int.parse(amounttController.text);
                //             oldPercent = percent.toString();
                //           });
                //         },
                //       );
                //     },
                //   ),
                // ).center(),

                // 16.height,

                // Text("Beneficiary CIF",
                //         style: boldTextStyle(size: 18, color: black))
                //     .paddingLeft(16),
                // 16.height,
                // AppTextField(
                //   autoFocus: false,
                //   decoration: waInputDecoration(
                //       hint: "Enter Beneficiary's CIF here",
                //       bgColor: context.cardColor),
                //   textFieldType: TextFieldType.NAME,
                //   keyboardType: TextInputType.name,
                //   controller: benfCifController,
                //   focus: accountFocusNode,
                // ).paddingOnly(left: 16, right: 16),
                // //16.height,
                // 16.height,

                // Text("Beneficiary Bank Name",
                //         style: boldTextStyle(size: 18, color: black))
                //     .paddingLeft(16),
                // 16.height,
                // AppTextField(
                //   autoFocus: false,
                //   decoration: waInputDecoration(
                //       hint: "Enter Beneficiary's Bank Name here",
                //       bgColor: context.cardColor),
                //   textFieldType: TextFieldType.NAME,
                //   keyboardType: TextInputType.name,
                //   controller: benfbanknameController,
                //   focus: benfbankFocusNode,
                // ).paddingOnly(left: 16, right: 16),
                // 16.height,

                // Text("Account Holder Name",
                //         style: boldTextStyle(size: 18, color: black))
                //     .paddingLeft(16),
                // 16.height,
                // AppTextField(
                //   autoFocus: false,
                //   decoration: waInputDecoration(
                //       hint: "Enter Account Holder Name here",
                //       bgColor: context.cardColor),
                //   textFieldType: TextFieldType.NAME,
                //   keyboardType: TextInputType.name,
                //   controller: accountHoldernameController,
                //   focus: accountholderFocusNode,
                // ).paddingOnly(left: 16, right: 16),
                // 10.height,
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border: Border.all(),
                //         //color: Color.fromARGB(255, 205, 226, 84),
                //         borderRadius: BorderRadius.circular(5)),
                //     child: Align(
                //       alignment: Alignment.centerLeft,
                //       child: Text(
                //               'Total Amount to be collected from Customer: ' +
                //                   "",
                //               style: boldTextStyle(size: 15, color: black))
                //           .paddingLeft(16),
                //     ),
                //   ),
                // ),
                // Container(
                //   width: 70,
                //   height: 30,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       border: Border.all(),
                //       color: Color.fromARGB(255, 28, 164, 255)),
                //   child: Center(
                //       child: Text(
                //     "$oldPercent",
                //     style: boldTextStyle(
                //         size: 15, color: Color.fromARGB(255, 12, 8, 231)),
                //   )),
                // ).center(),
                // 16.height,
                // SliderButton(
                //   buttonSize: 50,
                //   backgroundColor: WAPrimaryColor,
                //   dismissible: true,
                //   action: () {
                //     ///Do something here
                //     showInDialog(context, builder: (context) {
                //       // return WAMoneyTransferCompleteDialog(
                //       //   data: data,
                //       // );
                //       return _EnterOtpScreen(context, benfCifController,
                //           otpController, amounttController, otpFocusNode, data);
                //     });
                //   },
                //   label: Text("Swipe for Transfer", style: boldTextStyle()),
                //   icon: Icon(Icons.arrow_forward, color: WAPrimaryColor),
                // ).center(),
                16.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_EnterOtpScreen(
    BuildContext context,
    TextEditingController benfCifController,
    TextEditingController amounttController,
    TextEditingController otpController,
    FocusNode otpFocusNode,
    data) {
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
        AppTextField(
          autoFocus: false,
          decoration: waInputDecoration(
            hint: "Enter Otp here",
            bgColor: context.cardColor,
            borderColor: Colors.grey,
          ),

          textFieldType: TextFieldType.NAME,
          keyboardType: TextInputType.number,
          controller: otpController,
          focus: otpFocusNode,
          //nextFocus: accountFocusNode,
        ).paddingOnly(left: 16, right: 16, bottom: 16),

        30.height,
        AppButton(
          color: WAPrimaryColor,
          width: 180,
          height: 50,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          text: "Proceed",
          onTap: () {
            //WADashboardScreen(data: widget.data,).launch(context);
            //finish(context);

            showInDialog(context, builder: (context) {
              return _OnDepositDone(
                  context, benfCifController, amounttController, data);
            });
          },
          textStyle: boldTextStyle(color: Colors.white),
        ),
        16.height,
      ],
    ),
  );
}

_OnDepositDone(BuildContext context, TextEditingController benfCifController,
    TextEditingController amounttController, data) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      waCommonCachedNetworkImage(
          'https://media.istockphoto.com/vectors/online-payment-service-banking-or-money-transfer-with-mobile-app-and-vector-id1152615463?k=20&m=1152615463&s=612x612&w=0&h=BoT8RNVKIw1YC_3yhXv-5wrVxXM9NmoaZJx_CKG_3zw=',
          height: 200,
          width: 200,
          fit: BoxFit.fill),
      16.height,
      Text('Done!', style: secondaryTextStyle()),
      16.height,
      Text('Money Transfer Complete',
          style: boldTextStyle(size: 22), textAlign: TextAlign.center),
      8.height,
      createRichText(list: [
        TextSpan(
            text: "You have Transfer ${amounttController.text.toString()} to ",
            style: secondaryTextStyle()),
        TextSpan(
            text: " ${benfCifController.text.toString()}",
            style: boldTextStyle()),
      ], textAlign: TextAlign.center),
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
          AGAppFinancialScreen(
            //data: data,
          ).launch(context);
        },
        textStyle: boldTextStyle(color: Colors.white),
      ),
      16.height,
    ],
  );
}

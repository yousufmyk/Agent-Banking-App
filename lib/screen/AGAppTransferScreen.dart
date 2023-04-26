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
// import 'package:mobile_banking/utils/widgets/slider.dart';
import 'package:slider_button/slider_button.dart';

import '../Controllers/recipentsController.dart';
import '../main.dart';
import '../model/cardDetailsModel.dart';
import 'AGAppAgentEditProfileScreen.dart';
import 'AGAppFinancialScreen.dart';
import 'AGAppKycUploadScreen.dart';
import 'AGAppMainScreen.dart';

class AGAppTransferScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppTransferScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  // static String tag = '/WASendMoneyViaLoopScreen';

  @override
  AGAppTransferScreenState createState() =>
      AGAppTransferScreenState(/*data: data*/);
}

class AGAppTransferScreenState extends State<AGAppTransferScreen> {
  // AGAppTransferScreenState({
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
        appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Column(
          children: [
            Text("Transfer",
                style: boldTextStyle(color: Colors.black, size: 20)),

            // Text("${agentname.toString()}")
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: CircleAvatar(
        //       child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        //     ),
        //   ),
        // ],

        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              // PopupMenuItem 1
              PopupMenuItem(
                value: 1,
                // row with 2 children
                child: Row(
                  children: [
                    Icon(Icons.document_scanner_outlined,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("KYC",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 2,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Log Out",style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.contact_page_outlined,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Profile",style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ],
            offset: Offset(0, 70),
            color: Colors.teal,
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog

              if (value == 1) {
                AGAppKYCuploadScreen().launch(context);
                //_showDialog(context);
                // if value 2 show dialog
              } else if (value == 2) {
                 SessionManager().destroy();
                  AGAppMianScreen(/*data: data,*/).launch(context);
                // _showDialog(context);
              } else if (value == 3) {
                AGAppAgentEditProfileScreen(/*data: data,*/).launch(context);
              }
            },
          ),
        ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Does Customer have account?",
                            style: boldTextStyle(size: 15, color: black))
                        .paddingLeft(16),
                    Row(
                      children: [
                        Text("No"),
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
                        Text("Yes")
                      ],
                    )
                  ],
                ),
                if(hasaccount == true)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Customer CIF",
                        style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(
                    hint: "Enter Customer CIF here",
                    bgColor: context.cardColor,
                    borderColor: Colors.grey,
                  ),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: customercifController,
                  focus: customerCIFFocusNode,
                  nextFocus: receiptNameFocusNode,
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                    ],
                  ),
                ),
                if(hasaccount == false) 
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Agent CIF",
                        style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(
                    hint: "Enter Agent CIF here",
                    bgColor: context.cardColor,
                    borderColor: Colors.grey,
                  ),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: agentCifController,
                  focus: agnetcifFocusNode,
                  //nextFocus: receiptNameFocusNode,
                ).paddingOnly(left: 16, right: 16, bottom: 16),
                    ],
                  ),
                ),
                
                //if(hasaccount == false)
                // Text("Agent CIF",
                //         style: boldTextStyle(size: 18, color: black))
                //     .paddingLeft(16),
                // 16.height,
                // AppTextField(
                //   autoFocus: false,
                //   decoration: waInputDecoration(
                //     hint: "Enter Customer CIF here",
                //     bgColor: context.cardColor,
                //     borderColor: Colors.grey,
                //   ),
                //   textFieldType: TextFieldType.NAME,
                //   keyboardType: TextInputType.name,
                //   controller: customercifController,
                //   focus: customerCIFFocusNode,
                //   nextFocus: receiptNameFocusNode,
                // ).paddingOnly(left: 16, right: 16, bottom: 16),
                

                16.height,

                Text('Amount', style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                AppTextField(
                  controller: amounttController,
                  autoFocus: false,
                  textAlign: TextAlign.center,
                  textFieldType: TextFieldType.OTHER,
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(fontSize: 22, color: black),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.5))),
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
                            backgroundColor: WAPrimaryColor.withOpacity(0.2),
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
                          amounttController.text = amountList[index]!;
                          setState(() {
                            var percent =
                                (10 / 100 * int.parse(amounttController.text)) +
                                    int.parse(amounttController.text);
                            oldPercent = percent.toString();
                          });
                        },
                      );
                    },
                  ),
                ).center(),

                16.height,

                Text("Beneficiary CIF",
                        style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(
                      hint: "Enter Beneficiary's CIF here",
                      bgColor: context.cardColor),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: benfCifController,
                  focus: accountFocusNode,
                ).paddingOnly(left: 16, right: 16),
                //16.height,
                16.height,

                Text("Beneficiary Bank Name",
                        style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(
                      hint: "Enter Beneficiary's Bank Name here",
                      bgColor: context.cardColor),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: benfbanknameController,
                  focus: benfbankFocusNode,
                ).paddingOnly(left: 16, right: 16),
                16.height,

                Text("Account Holder Name",
                        style: boldTextStyle(size: 18, color: black))
                    .paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(
                      hint: "Enter Account Holder Name here",
                      bgColor: context.cardColor),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: accountHoldernameController,
                  focus: accountholderFocusNode,
                ).paddingOnly(left: 16, right: 16),
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
                              style: boldTextStyle(size: 15, color: black))
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
                SliderButton(
                  buttonSize: 50,
                  backgroundColor: WAPrimaryColor,
                  dismissible: true,
                  action: () {
                    ///Do something here
                    showInDialog(context, builder: (context) {
                      // return WAMoneyTransferCompleteDialog(
                      //   data: data,
                      // );
                      return _EnterOtpScreen(context, benfCifController,
                          otpController, amounttController, otpFocusNode);
                    });
                  },
                  label: Text("Swipe for Transfer", style: boldTextStyle()),
                  icon: Icon(Icons.arrow_forward, color: WAPrimaryColor),
                ).center(),
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
    FocusNode otpFocusNode) {
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
                  context, benfCifController, amounttController);
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
    TextEditingController amounttController) {
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
           // data: data,
          ).launch(context);
        },
        textStyle: boldTextStyle(color: Colors.white),
      ),
      16.height,
    ],
  );
}

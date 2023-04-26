import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:mobile_banking/screen/AGAppWithdrawScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAColors.dart';
import '../utils/WAWidgets.dart';
import 'AGAppBillPayment.dart';
import 'AGAppCashinCashoutScreen.dart';
import 'AGAppCorporateOnboardingScreen.dart';
import 'AGAppCustomerTransScreen.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppFinancialScreen.dart';
import 'AGAppMobileRechargeScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';
import 'AGAppSliderAdvrtScreen.dart';
import 'AGAppTransferScreen.dart';
import 'package:slider_button/slider_button.dart';

class AGAppRentPayScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppRentPayScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<AGAppRentPayScreen> createState() =>
      _AGAppRentPayScreenState(/*data: data*/);
}

class _AGAppRentPayScreenState extends State<AGAppRentPayScreen> {

var rentamountcontroller = TextEditingController();
var propertynamecontroller = TextEditingController();
var customercifController = TextEditingController();
var agentCifController = TextEditingController();
FocusNode rentFocus = FocusNode();
FocusNode propertyFocus = FocusNode();
FocusNode customerCIFFocusNode = FocusNode();
FocusNode agnetcifFocusNode = FocusNode();
var hasaccount = true;
  // _AGAppRentPayScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  final Uri _urlForOutLook = Uri.parse('https://outlook.office365.com/mail/');
  Future<void> _launchUrlOutLook() async {
    if (!await launchUrl(_urlForOutLook)) {
      throw Exception('Could not launch $_urlForOutLook');
    }
  }

  final Uri _urlForGmail = Uri.parse('https://mail.google.com/mail/');
  Future<void> _launchUrlGmail() async {
    if (!await launchUrl(_urlForGmail)) {
      throw Exception('Could not launch $_urlForOutLook');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Basic Rent Details",
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
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.,
          children: [
           
            20.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 16.height,
              Text("Enter Rent Amount", style: boldTextStyle(size: 18, color: black))
                  .paddingLeft(16),
              10.height,
              AppTextField(
                autoFocus: false,
                decoration: waInputDecoration(
                  hint: "Enter Rent Amount here",
                  bgColor: context.cardColor,
                  borderColor: Colors.grey,
                ),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.name,
                controller: rentamountcontroller,
                focus: rentFocus,
                //nextFocus: ibanFocusNode,
              ).paddingOnly(left: 16, right: 16, bottom: 16),
                 16.height,
              Text("Property Name", style: boldTextStyle(size: 18, color: black))
                  .paddingLeft(16),
              10.height,
              AppTextField(
                autoFocus: false,
                decoration: waInputDecoration(
                  hint: "Enter Property Name here",
                  bgColor: context.cardColor,
                  borderColor: Colors.grey,
                ),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.name,
                controller: propertynamecontroller,
                focus: propertyFocus,
                //nextFocus: ibanFocusNode,
              ).paddingOnly(left: 16, right: 16, bottom: 16),
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
                 // nextFocus: receiptNameFocusNode,
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
                    // return _EnterOtpScreen(
                    //     context, otpController, otpFocus, data);
                    return _OnDepositDone(context);
                  });
                },
                label: Text("Swipe to Pay", style: boldTextStyle()),
                icon: Icon(Icons.arrow_forward, color: WAPrimaryColor),
              ).center(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
_OnDepositDone(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      waCommonCachedNetworkImage(
          'https://media.istockphoto.com/id/1361628889/vector/buying-a-property-isometric-vector.jpg?s=612x612&w=0&k=20&c=IlKKoOO-VDhh7zduSvzYRAcDqSRTnPi1uIj_30k69YI=',
          height: 200,
          width: 200,
          fit: BoxFit.fill),
      16.height,
      Text('Done!', style: secondaryTextStyle()),
      16.height,
      Text('Your Request For Rent Payment Proceeded Sucessfully',
          style: boldTextStyle(size: 22), textAlign: TextAlign.center),
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

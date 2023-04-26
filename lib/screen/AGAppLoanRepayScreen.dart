import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAColors.dart';
import '../utils/WAWidgets.dart';
import 'package:slider_button/slider_button.dart';
import 'AGAppFinancialScreen.dart';

class AGAppLoanRepayScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppLoanRepayScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<AGAppLoanRepayScreen> createState() => _AGAppLoanRepayScreenState(/*data: data*/);
}

class _AGAppLoanRepayScreenState extends State<AGAppLoanRepayScreen> {
  // _AGAppLoanRepayScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  List<String?> amountList = ["500", "2000", "5000"];
  TextEditingController amountController = TextEditingController();
  TextEditingController cifController = TextEditingController();
  TextEditingController agentComissionController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FocusNode cifFocus = FocusNode();
  FocusNode agentComissionFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
bool loanId = false;
  void onchange() {
    setState(() {
      loanId = true;
    });
  }

  var oldPercent = '';
  int dropdownValue = 3;
  var monthlyinstallment = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.teal,
      //   title: Column(
      //     children: [
      //       Text("Loan", style: boldTextStyle(color: Colors.black, size: 20)),

      //       // Text("${agentname.toString()}")
      //     ],
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 10),
      //       child: CircleAvatar(
      //         child: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
      //       ),
      //     ),
      //   ],
      //   leading: Container(
      //     margin: EdgeInsets.all(8),
      //     decoration: boxDecorationWithRoundedCorners(
      //       backgroundColor: context.cardColor,
      //       borderRadius: BorderRadius.circular(12),
      //       border: Border.all(color: Colors.grey.withOpacity(0.2)),
      //     ),
      //     child: Icon(Icons.arrow_back,
      //         color: appStore.isDarkModeOn ? white : black),
      //   ).onTap(() {
      //     finish(context);
      //   }),
      //   centerTitle: true,
      //   elevation: 0.0,
      //   brightness: Brightness.dark,
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text("Loan ID",
                      style: boldTextStyle(size: 18, color: black))
                  .paddingLeft(16),
              10.height,
              AppTextField(
                //readOnly: true,
                suffix: IconButton(onPressed: (){
                 onchange();
                }, icon: Icon(Icons.search)),
                autoFocus: false,
                decoration: waInputDecoration(
                  hint: "00775",
                  bgColor: context.cardColor,
                  borderColor: Colors.grey,
                ),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.name,
                controller: agentComissionController,
                focus: agentComissionFocus,
                //nextFocus: agentbanknameFocusNode,
              ).paddingOnly(left: 16, right: 16, bottom: 16),
              16.height,
              if(loanId == true)
              //Text("hello world"),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  child: 
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Total Loan Amount: ",
                      style: boldTextStyle(size: 15, color: black)),
                          Text("        5000 AED"),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Text("Rate Of Interest: ",
                      style: boldTextStyle(size: 15, color: black)),
                          Text("             12%"),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Text("Outstanding Amount: ",
                      style: boldTextStyle(size: 15, color: black)),
                          Text("    3161 AED"),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Text("Remaining Tenure: ",
                      style: boldTextStyle(size: 15, color: black)),
                          Text("         4/6"),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Text("Amount To Pay: ",
                      style: boldTextStyle(size: 15, color: black)),
                          Text("               917 AED"),
                        ],
                      ),
                      5.height,
                      Row(
                        children: [
                          Text("Remaining Amount: ",
                      style: boldTextStyle(size: 15, color: black)),
                          Text("       2244 AED"),
                        ],
                      ),
                      5.height,
              
                    ],
                  ),
                ),
              ),

              

              16.height,
              
              
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
                focus: cifFocus,
                //nextFocus: beneficiarynameFocusNode,
              ).paddingOnly(left: 16, right: 16, bottom: 16),
              10.height,
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
              //               'Total Amount to be collected from Customer: ' + "",
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
              // 15.height,
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         border: Border.all(),
              //         //color: Color.fromARGB(255, 205, 226, 84),
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text('Total Monthly Payment: ' + "",
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
              //     "$monthlyinstallment",
              //     style: boldTextStyle(
              //         size: 15, color: Color.fromARGB(255, 12, 8, 231)),
              //   )),
              // ).center(),
              20.height,
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
                    return _EnterOtpScreen(
                        context, otpController, otpFocus);
                  });
                },
                label: Text("Swipe to Request", style: boldTextStyle()),
                icon: Icon(Icons.arrow_forward, color: WAPrimaryColor),
              ).center(),
            ],
          ),
        ),
      ),
    );
  }
}

_EnterOtpScreen(BuildContext context, TextEditingController otpController,
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
              return _OnDepositDone(context);
            });
          },
          textStyle: boldTextStyle(color: Colors.white),
        ),
        16.height,
      ],
    ),
  );
}

_OnDepositDone(BuildContext context) {
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
      Text('Your Request For The Loan Submitted',
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

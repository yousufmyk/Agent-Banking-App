import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:slider_button/slider_button.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import '../utils/WAColors.dart';
import '../utils/WAWidgets.dart';
import 'AGAppFinancialScreen.dart';

class PrePaidScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const PrePaidScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<PrePaidScreen> createState() => _PrePaidScreenState(/*data: data*/);
}

class _PrePaidScreenState extends State<PrePaidScreen> {
  // _PrePaidScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  List<String?> amountList = ["322", "120", "600"];
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController customercifController = TextEditingController();
  TextEditingController agentCifController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController agentComissionController = TextEditingController();
  FocusNode numberFocus = FocusNode();
  FocusNode otpFocus = FocusNode();
  FocusNode customerCIFFocusNode = FocusNode();
  FocusNode agnetcifFocusNode = FocusNode();
  FocusNode agentComissionFocus = FocusNode();

  String dropdownValue = 'Etisalat';
  var hasaccount = true;
  var oldPercent = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              Text("Enter Number", style: boldTextStyle(size: 18, color: black))
                  .paddingLeft(16),
              10.height,
              AppTextField(
                autoFocus: false,
                decoration: waInputDecoration(
                  hint: "Enter Phone Number here",
                  bgColor: context.cardColor,
                  borderColor: Colors.grey,
                ),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.name,
                controller: numberController,
                focus: numberFocus,
                //nextFocus: ibanFocusNode,
              ).paddingOnly(left: 16, right: 16, bottom: 16),
              //16.height,
              Container(
                child: DropdownButton<String>(
                  // Step 3.
                  icon: Icon(Icons.arrow_drop_down_circle_outlined),
                  isExpanded: true,
                  disabledHint: Text("Select"),
                  //dropdownColor: Color.fromARGB(255, 99, 185, 255),

                  value: dropdownValue,
                  // Step 4.
                  items: <String>[
                    'Etisalat',
                    'DU',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  // Step 5.
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ).paddingAll(16),

              20.height,
              Text("Deals for you",
                      style: boldTextStyle(size: 18, color: black))
                  .paddingLeft(16),
              SingleChildScrollView(
                // c
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                       
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(2550, 63, 63, 63)),
                        child: Column(
                          children: [
                            Text(
                              "Mobile Data Offers",
                              style: secondaryTextStyle(size: 10, color: white),
                            ),
                            Text(
                              "150Gb At \nAed 350",
                              style: boldTextStyle(size: 15, color: white),
                            ),
                            20.height,
                            Text(
                              "120 AED",
                              style: boldTextStyle(size: 18, color: white),
                            )
                          ],
                        ),
                      ),
                      10.width,
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(2550, 63, 63, 63)),
                        child: Column(
                          children: [
                            Text(
                              "Mobile Data Offers",
                              style: secondaryTextStyle(size: 10, color: white),
                            ),
                            Text(
                              "300Gb At \nAed 350",
                              style: boldTextStyle(size: 15, color: white),
                            ),
                            20.height,
                            Text(
                              "322 AED",
                              style: boldTextStyle(size: 18, color: white),
                            )
                          ],
                        ),
                      ),
                     
                      10.width,
                      Container(
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(2550, 63, 63, 63)),
                        child: Column(
                          children: [
                            Text(
                              "Mobile Data Offers",
                              style: secondaryTextStyle(size: 10, color: white),
                            ),
                            Text(
                              "500Gb At \nAed 350",
                              style: boldTextStyle(size: 15, color: white),
                            ),
                            20.height,
                            Text(
                              "600 AED",
                              style: boldTextStyle(size: 18, color: white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              if (hasaccount == true)
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
                        nextFocus: agnetcifFocusNode,
                      ).paddingOnly(left: 16, right: 16, bottom: 16),
                    ],
                  ),
                ),
              if (hasaccount == false)
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
              16.height,
              Text("Agent Comission",
                      style: boldTextStyle(size: 18, color: black))
                  .paddingLeft(16),
              10.height,
              AppTextField(
                readOnly: true,
                autoFocus: false,
                decoration: waInputDecoration(
                  hint: "10%",
                  bgColor: context.cardColor,
                  borderColor: Colors.grey,
                ),
                textFieldType: TextFieldType.NAME,
                keyboardType: TextInputType.name,
                controller: agentComissionController,
                focus: agentComissionFocus,
                //nextFocus: agentbanknameFocusNode,
              ).paddingOnly(left: 16, right: 16, bottom: 16),
              Text('Amount', style: boldTextStyle(size: 18, color: black))
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
                          border: Border.all(),
                          backgroundColor:
                              Color.fromARGB(255, 0, 255, 229).withOpacity(0.2),
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
                          var percent =
                              (10 / 100 * int.parse(amountController.text)) +
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
                            'Total Amount to be collected from Customer: ' + "",
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
      Text('Your Request For Mobile Recharge Proceeded Sucessfully',
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

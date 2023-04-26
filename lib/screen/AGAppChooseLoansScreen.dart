import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../model/cardDetailsModel.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppLoanRepayScreen.dart';
import 'AGAppLoansScreen.dart';
import 'AGAppWithdrawScreen.dart';

class ChooseLoanScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const ChooseLoanScreen({
  //   Key? key,
  //   required this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  State<ChooseLoanScreen> createState() => _ChooseLoanScreenState(/*data:data*/);
}

class _ChooseLoanScreenState extends State<ChooseLoanScreen> {
  // _ChooseLoanScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
         backgroundColor: Colors.teal,
        title: Text(
          'Loans',
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
          //backgroundColor: Colors.white,
          //elevation: 0,
          bottom: TabBar(
              unselectedLabelColor: Color.fromARGB(255, 0, 255, 229),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromARGB(255, 0, 255, 229)),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color.fromARGB(255, 0, 255, 229), width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Loan Request"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color.fromARGB(255, 0, 255, 229), width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Loan Repayment"),
                    ),
                  ),
                ),
                
              ]),
        ),
        body: TabBarView(children: [
           AGAppLoanScreen(/*data: data,*/),
           AGAppLoanRepayScreen(/*data: data,*/)
      //     AGAppWithdrawScreen(
      //  /* data: data,*/
      // ),
         //AGAppPersonalOnboardScreen(),
          //AGAppCorporateOnboardScreen(),
         // Icon(Icons.games),
        ]),
      )));
    
  }
}
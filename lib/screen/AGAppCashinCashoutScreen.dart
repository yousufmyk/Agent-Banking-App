import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppWithdrawScreen.dart';

class AGAppCashInCashOutScreen extends StatefulWidget {
  const AGAppCashInCashOutScreen({Key? key}) : super(key: key);

  @override
  State<AGAppCashInCashOutScreen> createState() => _AGAppCashInCashOutScreenState();
}

class _AGAppCashInCashOutScreenState extends State<AGAppCashInCashOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
         backgroundColor: Colors.teal,
        title: Text(
          'Cash In & Cash Out',
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
                      child: Text("Cash In"),
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
                      child: Text("Cash Out"),
                    ),
                  ),
                ),
                
              ]),
        ),
        body: TabBarView(children: [
           AGAppDepositScreen(
        /*data: data,*/
      ),
          AGAppWithdrawScreen(
       /* data: data,*/
      ),
         //AGAppPersonalOnboardScreen(),
          //AGAppCorporateOnboardScreen(),
         // Icon(Icons.games),
        ]),
      )));
    
  }
}
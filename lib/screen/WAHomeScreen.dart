import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mobile_banking/component/pdfTestComponenet.dart';

import 'package:mobile_banking/model/Api%20Service/Auth%20Apis/loginApi.dart';
import 'package:mobile_banking/model/Api%20Service/Pdf%20Api/pdfApi.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/component/WACardComponent.dart';
import 'package:mobile_banking/component/WAOperationComponent.dart';
import 'package:mobile_banking/component/WATransactionComponent.dart';
import 'package:mobile_banking/model/WalletAppModel.dart';
import 'package:mobile_banking/screen/WAOperatorsScreen.dart';
import 'package:mobile_banking/utils/WADataGenerator.dart';
import 'package:http/http.dart' as http;
import 'package:showcaseview/showcaseview.dart';

import '../component/WACardComponent2.dart';

// import '../component/WAPdfViewcomponent.dart';
import '../component/WAShowCaseComponent.dart';
import '../component/WAStatisticsComponent.dart';
import '../main.dart';
import '../model/cardDetailsModel.dart';


import 'AGAppCustomerTransScreen.dart';
import 'AGAppCustomersChart.dart';
import 'AGAppDepositChat.dart';
import 'AGAppDepositScreen.dart';
import 'AGAppTransferScreen.dart';
import 'AGAppWithdraw.dart';
import 'AGAppWithdrawScreen.dart';
import 'WABillPayScreen.dart';
import 'WACouponScreen.dart';
import 'WACreditCardScreen.dart';
import 'WAMyProfileScreen.dart';
import 'WANotificationScreen.dart';
import 'WARewardsScreen.dart';
import 'WASendMoneyViaLoopScreen.dart';
import 'WAVoucherScreen.dart';
import 'package:dio/dio.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

class mainScreen extends StatefulWidget {
  // final CreditCardModel? data;
  // const mainScreen({
  //   Key? key,
  //   this.data,
  // })  : assert(data != null),
  //       super(key: key);
  @override
  State<mainScreen> createState() => _mainScreenState(/*data: data!*/);
}

class _mainScreenState extends State<mainScreen> {
  // _mainScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
        builder: Builder(builder: (context) => WAHomeScreen(/*data: data*/)));
  }
}

class WAHomeScreen extends StatefulWidget {
  static String tag = '/WAHomeScreen';
  // final CreditCardModel? data;

  // const WAHomeScreen({
  //   Key? key,
  //   this.data,
  // })  : assert(data != null),
  //       super(key: key);

  @override
  WAHomeScreenState createState() => WAHomeScreenState(/*data: data!*/);
}

class WAHomeScreenState extends State<WAHomeScreen> {
  // WAHomeScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  List<WACardModel> cardList = waCardList();
  List<WACardModel2> cardList2 = waCardList2();
  //List<WAOperationsModel> operationsList = waOperationList();
  List<WATransactionModel> transactionList = waTransactionList();

  // late List<WAOperationsModel> operationsList = <WAOperationsModel>[
  //   WAOperationsModel(
  //       color: Color(0xFF6C56F9),
  //       title: 'Customers',
  //       image: 'images/mobile_banking/HomeScreentransfer-removebg-preview.png',
  //       // widget: WASendMoneyViaLoopScreen(data: data),
  //       widget: AGAppCustomerTransScreen()),
  //   WAOperationsModel(
  //     color: Color(0xFFFF7426),
  //     title: 'Deposit',
  //     image: "images/mobile_banking/homescreendeposit2-removebg-preview.png",
  //     // widget: AGAppDepositScreen(
  //     //   data: data,
  //     // ),
  //   ),
  //   WAOperationsModel(
  //     color: Colors.greenAccent,
  //     title: 'Withdrawl',
  //     image:
  //         "images/mobile_banking/withdrawcashhomescreen-removebg-preview.png",
  //     // widget: AGAppWithdrawScreen(
  //     //   data: data,
  //     // ),
  //   ),
  //   WAOperationsModel(
  //     color: Colors.pinkAccent,
  //     title: 'Transfer',
  //     image: 'images/mobile_banking/transferhomescreen-removebg-preview.png',
  //     // widget: WACreditCardScreen(
  //     //   data: data,
  //     // ),
  //     //widget: AGAppTransferScreen(data: data,)
  //   ),
  //   WAOperationsModel(
  //     color: Color(0xFF6C56F9),
  //     title: 'Link Card',
  //     image:
  //         'images/mobile_banking/Screenshot_2023-03-20_120213-removebg-preview.png',
  //     // widget: WACreditCardScreen(
  //     //   data: data,
  //     // ),
  //   ),
  //   WAOperationsModel(
  //     color: Color(0xFF26C884),
  //     title: 'Bill Pay',
  //     image:
  //         'images/mobile_banking/Screenshot_2023-03-21_104855-removebg-preview (1).png',
  //     widget: WABillPayScreen(
  //       data: data,
  //     ),
  //   ),
  //   WAOperationsModel(
  //       color: Color(0xFFFF7426),
  //       title: 'Coupons',
  //       image:
  //           'images/mobile_banking/Screenshot_2023-03-21_105251-removebg-preview (1).png',
  //       widget: WACouoponScreen()),
  // ];

  // Future<void> printDoc() async {
  //   final doc = pw.Document();
  //   doc.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return pw.Text("Hello World");
  //       }));
  //   await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => doc.save());
  // }

  final GlobalKey globalKeyOne = GlobalKey();
  final GlobalKey globalKeyTwo = GlobalKey();
  final GlobalKey globalKeyThree = GlobalKey();
  final GlobalKey globalKeyFour = GlobalKey();
  PageController? pageController;
  int currentPosition = 1;

  @override
  void initState() {
    super.initState();
    init();
  }

  // Future<void> init() async {
  //   //
  // }
  init() async {
    pageController =
        PageController(initialPage: currentPosition, viewportFraction: 1);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  var chart = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: context.height(),
            width: context.width(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/mobile_banking/wa_bg.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    50.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // WAMyProfileScreen(data: data).launch(context);
                            ShowCaseWidget.of(context).startShowCase([
                              globalKeyOne,
                              globalKeyTwo,
                              globalKeyThree,
                              globalKeyFour
                            ]);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: context.cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            child: Icon(Icons.arrow_back,
                                color: appStore.isDarkModeOn ? white : black),
                          ).onTap(() {
                            finish(context);
                          }),
                        ),
                        Text("Agent Summary Dashboard",
                            style: boldTextStyle(size: 20, color: black)),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: boxDecorationWithRoundedCorners(
                            backgroundColor: context.cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          alignment: Alignment.center,
                          child: ShowCaseView(
                            title: 'Notifications',
                            description: 'All your notification appear here.',
                            globalKey: globalKeyOne,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      WANotificationScreen().launch(context);
                                    },
                                    child: Icon(Icons.add_alert,
                                        color: Colors.grey)),
                                Positioned(
                                  top: 3,
                                  right: 3,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF7426),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ).paddingOnly(left: 16, right: 16, bottom: 16),

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Wrap(
                    //         direction: Axis.horizontal,
                    //         spacing: 16,
                    //         children: cardList.map((cardItem) {
                    //           return ShowCaseView(
                    //             globalKey: globalKeyTwo,
                    //             description:
                    //                 "All of your Credit/Debit card appers here",
                    //             title: "Cards",
                    //             shapeBorder: CircleBorder(),
                    //             child: WACardComponent(
                    //                 cardModel: cardItem, data: widget.data!),
                    //           );
                    //         }).toList(),
                    //       ).paddingAll(16),
                    //       Wrap(
                    //         direction: Axis.horizontal,
                    //         spacing: 16,
                    //         children: cardList2.map((cardItem2) {
                    //           return WACardComponent2(
                    //               cardModel2: cardItem2, data: widget.data!);
                    //         }).toList(),
                    //       ).paddingAll(16),
                    //     ],
                    //   ),
                    // ),

                    //WAStatisticsComponent(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Operations',
                            style: boldTextStyle(size: 20, color: black)),
                        Icon(Icons.play_arrow, color: Colors.grey).onTap(() {
                          // WAOperatorsScreen(
                          //   data: data,
                          // ).launch(context);
                        }),
                      ],
                    ).paddingOnly(left: 16, right: 16),
                    // ShowCaseView(
                    //   globalKey: globalKeyThree,
                    //   title: "Our Services",
                    //   description:
                    //       "All of the application features appears here ",
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Wrap(
                    //       direction: Axis.horizontal,
                    //       spacing: 16,
                    //       children: operationsList.map((operationModel) {
                    //         return
                    //         // return WAOperationComponent(
                    //         //         itemModel: operationModel)
                    //         //     .onTap(() {
                    //         //   operationModel.widget != null
                    //         //       ? operationModel.widget.launch(context)
                    //         //       : toast(operationModel.title);
                    //         // });
                    //       }).toList(),
                    //     ).paddingAll(16),
                    //   ),
                    // ),
                    10.height,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() { chart = 1;});
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 224, 224, 224),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            'images/mobile_banking/HomeScreentransfer-removebg-preview.png'),
                                        color: Color(0xFF6C56F9),
                                      ),
                                    ),
                                  ),
                                  Text("Customers",
                                      style: boldTextStyle(size: 15, color: black))
                                ],
                              ),
                            ),
                          ),
                          15.width,
                          GestureDetector(
                            onTap: (){
                              setState(() { 
                                chart = 2;
                              });
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 224, 224, 224),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            "images/mobile_banking/homescreendeposit2-removebg-preview.png"),
                                        color: Color(0xFFFF7426),
                                      ),
                                    ),
                                  ),
                                  Text("Deposit",
                                      style: boldTextStyle(size: 15, color: black))
                                ],
                              ),
                            ),
                          ),
                          15.width,
                          Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {chart = 3; });
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 224, 224, 224),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            "images/mobile_banking/withdrawcashhomescreen-removebg-preview.png"),
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Text("Withdrawl",
                                    style: boldTextStyle(size: 15, color: black))
                              ],
                            ),
                          ),
                          15.width,
                          Container(
                            child: Column(
                              children: [
                                GestureDetector(
                                   onTap: (){
                                    setState(() {chart = 4; });
                                  },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 224, 224, 224),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            'images/mobile_banking/transferhomescreen-removebg-preview.png'),
                                        color: Color(0xFF6C56F9),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("Transfer",
                                    style: boldTextStyle(size: 15, color: black))
                              ],
                            ),
                          ),
                          15.width,
                          GestureDetector(
                             onTap: (){
                                    setState(() {chart = 5; });
                                  },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 224, 224, 224),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage(
                                            'images/mobile_banking/Screenshot_2023-03-21_104855-removebg-preview (1).png'),
                                        color: Color(0xFF26C884),
                                      ),
                                    ),
                                  ),
                                  Text("Bill Pay",
                                      style: boldTextStyle(size: 15, color: black))
                                ],
                              ),
                            ),
                          ),
                          // 15.width,
                          // Container(
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         height: 70,
                          //         width: 70,
                          //         decoration: BoxDecoration(
                          //             color: Color.fromARGB(255, 224, 224, 224),
                          //             borderRadius: BorderRadius.circular(7)),
                          //         child: Center(
                          //           child: Image(
                          //             image: AssetImage(
                          //                 'images/mobile_banking/HomeScreentransfer-removebg-preview.png'),
                          //             color: Color(0xFF6C56F9),
                          //           ),
                          //         ),
                          //       ),
                          //       Text("Customers",
                          //           style: boldTextStyle(size: 15, color: black))
                          //     ],
                          //   ),
                          // ),
                          15.width,
                        ],
                      ),
                    ),
                    10.height,
                    if(chart == 1)
                    CustomerChartPage(),
                    if(chart == 2)
                    DepositChartPage(),
                    if(chart == 3)
                    WithdrawChartPage(),
                    if(chart == 4)
                    CustomerChartPage(),
                    if(chart == 5)
                    WithdrawChartPage(),
                    46.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transactions',
                            style: boldTextStyle(size: 20, color: black)),
                        Icon(Icons.play_arrow, color: Colors.grey).onTap(() {}),
                      ],
                    ).paddingOnly(left: 16, right: 16),
                    //_EndButton(context),
                    16.height,
                    ShowCaseView(
                      globalKey: globalKeyFour,
                      title: "Transaction History",
                      description:
                          "All of your Transaction History appears here ",
                      child: Column(
                        children: transactionList.map((transactionItem) {
                          return WATransactionComponent(
                              transactionModel: transactionItem);
                        }).toList(),
                      ).paddingOnly(bottom: 16),
                    ),
                  ],
                ),
              ),
            )));
  }
}

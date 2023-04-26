import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../utils/WAWidgets.dart';
import 'AGAppCorporateOnboardingScreen.dart';
import 'AGAppFinancialScreen.dart';
import 'AGAppPesoranlOnboardingScreen.dart';

class AGAppExistingAgentOnboardingScreen extends StatefulWidget {
  const AGAppExistingAgentOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<AGAppExistingAgentOnboardingScreen> createState() =>
      _AGAppExistingAgentOnboardingScreenState();
}

class _AGAppExistingAgentOnboardingScreenState
    extends State<AGAppExistingAgentOnboardingScreen> {
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
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     title: Text(
    //       'Existing Agent',
    //       style: boldTextStyle(color: Colors.black, size: 20),
    //     ),
    //     leading: Container(
    //       margin: EdgeInsets.all(8),
    //       decoration: boxDecorationWithRoundedCorners(
    //         backgroundColor: context.cardColor,
    //         borderRadius: BorderRadius.circular(12),
    //         border: Border.all(color: Colors.grey.withOpacity(0.2)),
    //       ),
    //       child: Icon(Icons.arrow_back,
    //           color: appStore.isDarkModeOn ? white : black),
    //     ).onTap(() {
    //       finish(context);
    //     }),
    //     centerTitle: true,
    //     elevation: 0.0,
    //     brightness: Brightness.dark,
    //   ),
    //   body: SingleChildScrollView(
    //     child: Container(
    //       height: context.mediaQuerySize.height,
    //       width: context.mediaQuerySize.width,
    //       decoration: BoxDecoration(
    //           image: DecorationImage(
    //               image: AssetImage('images/mobile_banking/wa_bg.jpg'),
    //               fit: BoxFit.cover)),
    //       child: Center(
    //         child: Wrap(
    //           spacing: 30,
    //           runSpacing: 16,
    //           alignment: WrapAlignment.center,
    //           children: [
    //             GestureDetector(
    //               onTap: () {
    //                 AGAppFinancialScreen().launch(context);
    //               },
    //               child: Container(
    //                 child: Column(
    //                   children: [
    //                     CircleAvatar(
    //                       radius: 40,
    //                       backgroundColor: Colors.blueAccent,
    //                       // backgroundImage: AssetImage("images/mobile_banking/agentOnboarding-removebg-preview.png"),
    //                       backgroundImage: AssetImage(
    //                           "images/mobile_banking/financialtransaction-removebg-preview.png"),
    //                     ),
    //                     Text("Financial")
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             GestureDetector(
    //               onTap: () {
    //                 AGAppCorporateOnboardScreen().launch(context);
    //               },
    //               child: Container(
    //                 child: Column(
    //                   children: [
    //                     CircleAvatar(
    //                       radius: 40,
    //                       backgroundColor: Colors.blueAccent,
    //                       backgroundImage: AssetImage(
    //                           "images/mobile_banking/nonfinancial-removebg-preview.png"),
    //                     ),
    //                     Text("Non Financial")
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // return DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         backgroundColor: Colors.blueAccent,
    //         elevation: 0,
    //         bottom: TabBar(
    //             labelColor: Colors.blueAccent,
    //             unselectedLabelColor: Colors.white,
    //             indicatorSize: TabBarIndicatorSize.label,
    //             indicator: BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(10),
    //                     topRight: Radius.circular(10)),
    //                 color: Colors.white),
    //             tabs: [
    //               Tab(
    //                 child: Align(
    //                   alignment: Alignment.center,
    //                   child: Text(
    //                     "Financial",
    //                   ),
    //                 ),
    //               ),
    //               Tab(
    //                 child: Align(
    //                   alignment: Alignment.center,
    //                   child: Text("Non Financial"),
    //                 ),
    //               ),
    //             ]),
    //       ),
    //       body: TabBarView(children: [
    //         SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               Wrap(
    //                 children: [
    //                   AGAppFinancialScreen()
    //                 ],
    //               ),
                 
    //             ],
    //           ),
    //         ),
    //         Column(
    //           children: [
    //             Wrap(
    //               children: [
    //                 // AtmInternationalLimitComponent(),
    //                 // PosInternationalLimitComponent(),
    //                 // E_ComInternationalLimitComponent(),
    //                 // NetWorkInternationalLimitComponent()
    //               ],
    //             ),
                
    //           ],
    //         ),
    //       ]),
    //     ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        title: Text(
          'Existing Agent',
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
                      child: Text("Financial"),
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
                      child: Text("Non Financial"),
                    ),
                  ),
                ),
                
              ]),
        ),
        body: TabBarView(children: [
         // AGAppFinancialScreen(),
          //AGAppCorporateOnboardScreen(),
         // Icon(Icons.games),
        ]),
      ));
  }
}

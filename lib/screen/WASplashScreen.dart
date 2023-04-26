import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/screen/WAWalkThroughScreen.dart';
import 'package:mobile_banking/utils/WAColors.dart';

import '../model/cardDetailsModel.dart';
import 'AGAppMainScreen.dart';
import 'AGAppAgentLoginScreen.dart';

class WASplashScreen extends StatefulWidget {
 
  static String tag = '/WASplashScreen';

  @override
  WASplashScreenState createState() => WASplashScreenState(/*data:data*/);
}

class WASplashScreenState extends State<WASplashScreen> {
  
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(WAPrimaryColor,
        statusBarIconBrightness: Brightness.light);
    await Future.delayed(Duration(seconds: 3));
    if (mounted) finish(context);
    //WALoginScreen(/*data: data*/).launch(context);
    AGAppMianScreen().launch(context);
    // WAWalkThroughScreen(data: data,).launch(context);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: WAPrimaryColor,
    //     body: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image.asset(
    //           'images/mobile_banking/MicrosoftTeams-image (7).png',
    //           color: Colors.white,
    //           fit: BoxFit.cover,
    //           height: 100,
    //           width: 100,
    //         ).center(),
    //       ],
    //     ),
    //   ),
    return Image.asset("images/mobile_banking/fotor_2023-3-27_14_15_47.png",fit: BoxFit.cover,);
    
  }
}

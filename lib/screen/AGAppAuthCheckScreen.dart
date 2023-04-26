import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';



import '../component/WAFingerPrintDailog.dart';
import '../main.dart';
import '../utils/WAWidgets.dart';
import 'AGAppAgentOnBoardingScreen.dart';
import 'AGAppAgentLoginScreen.dart';

class AGAPPAuthCheckScreen extends StatefulWidget {
  const AGAPPAuthCheckScreen({Key? key}) : super(key: key);

  @override
  State<AGAPPAuthCheckScreen> createState() =>
      _AGAPPAuthCheckScreenState();
}

class _AGAPPAuthCheckScreenState extends State<AGAPPAuthCheckScreen> {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        
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
      body: SingleChildScrollView(
        child: Container(
          height: context.mediaQuerySize.height,
          width: context.mediaQuerySize.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/mobile_banking/newbg.png"),
                  fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                //color: Color.fromARGB(255, 255, 254, 246),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    150.height,
                    Image(image: AssetImage("images/mobile_banking/meta-logo.png"),width: 200,),
                    130.height,
                    GestureDetector(
                      onTap: (){
                        //WAFingerPrintDialog().launch(context);
                        WALoginScreen(/*data: data*/).launch(context);
                      },
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 8, 65, 112),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(child: Text("Log In",style: boldTextStyle(color: Colors.white, size: 15))),
                      ),
                    ),
                    10.height,
                    // GestureDetector(
                    //   onTap: (){
                    //     AGAppAgentOnboardingScreen().launch(context);
                    //   },
                    //   child: Container(
                    //     width: 250,
                    //     height: 50,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(25)
                    //     ),
                    //     child: Center(child: Text("Sign Up",style: boldTextStyle(color: Color.fromARGB(255, 8, 65, 112), size: 15))),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ).paddingAll(30),
        ),
      ),
    );
  }
}

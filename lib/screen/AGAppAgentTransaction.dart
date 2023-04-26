import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:social_share/social_share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../utils/WAColors.dart';
import '../utils/WAWidgets.dart';
import 'AGAppAgentEditProfileScreen.dart';
import 'AGAppKycUploadScreen.dart';
import 'AGAppMainScreen.dart';

class AGAppAgentTransScreen extends StatefulWidget {
  const AGAppAgentTransScreen({Key? key}) : super(key: key);

  @override

  State<AGAppAgentTransScreen> createState() =>
      _AGAppAgentTransScreenState();
}

class _AGAppAgentTransScreenState extends State<AGAppAgentTransScreen> {
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
        backgroundColor: Colors.teal,
        title: Column(
          children: [
            Text("Agent Transactions",
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
              // PopupMenuItem(
              //   value: 3,
              //   // row with two children
              //   child: Row(
              //     children: [
              //       Icon(Icons.contact_page_outlined,color: Colors.white,),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text("Profile",style: TextStyle(color: Colors.white))
              //     ],
              //   ),
              // ),
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
              } 
              // else if (value == 3) {
              //   AGAppAgentEditProfileScreen(data: data,).launch(context);
              // }
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
      body: SingleChildScrollView(
        child: Container(
          height: context.mediaQuerySize.height,
          width: context.mediaQuerySize.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/mobile_banking/wa_bg.jpg'),
                  fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                //color: Color.fromARGB(255, 255, 254, 246),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      60.height,
                      Container(
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.0, // Soften the shaodw
                              spreadRadius: 2.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("search"),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.greenAccent,
                                ))
                          ],
                        ),
                      ),
                      30.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Yesterday", style: boldTextStyle(size: 20)),
                          Text("د.1060")
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          showInDialog(context, builder: (context) {
                      return _OnclickCustomerOne(context);
                    });
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          "images/mobile_banking/transactionimg1-removebg-preview.png",
                                        ),
                                        width: 50,
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          Text("Rashid",
                                              style: boldTextStyle(
                                                  size: 15, color: black)).paddingOnly(right: 80),
                                          Row(
                                            children: [
                                              Text("24/3/2023"),
                                              Text("12:56 PM")
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("د.50",
                                          style: boldTextStyle(size: 15, color: black)),
                                      Text("Deposit",
                                          style: boldTextStyle(size: 15, color: greenColor)),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: 280,
                                child: Row(
                                  children: [
                                    Divider(thickness: 1).expand(),
                                    Divider(thickness: 1).expand(),
                                  ],
                                ),
                              ).center(),
                            ],
                          ),
                        ),
                      ),
                      5.height,
                
                      GestureDetector(
                        onTap: (){
                          showInDialog(context, builder: (context) {
                      return _OnclickCustomerTwo(context);
                    });
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                          "images/mobile_banking/transactionimg1-removebg-preview.png",
                                        ),
                                        width: 50,
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          Text("Maryam ",
                                              style: boldTextStyle(
                                                  size: 15, color: black)).paddingOnly(right: 70),
                                          Row(
                                            children: [
                                              Text("24/3/2023"),
                                              Text("01:47 PM")
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("1د.70",
                                          style: boldTextStyle(size: 15, color: black)),
                                          Text("Deposit",
                                          style: boldTextStyle(size: 15, color: greenColor))
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: 280,
                                child: Row(
                                  children: [
                                    Divider(thickness: 1).expand(),
                                    Divider(thickness: 1).expand(),
                                  ],
                                ),
                              ).center(),
                            ],
                          ),
                        ),
                      ),
                      5.height,
                
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Abdullah",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 65),
                                        Row(
                                          children: [
                                            Text("24/3/2023"),
                                            Text("02:10 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("د.250",
                                        style: boldTextStyle(size: 15, color: black)),
                                        Text("Deposit",
                                          style: boldTextStyle(size: 15, color: greenColor))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Yousef",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 75),
                                        Row(
                                          children: [
                                            Text("24/3/2023"),
                                            Text("03:15 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("7د.50",
                                        style: boldTextStyle(size: 15, color: black)),
                                    Text("WithDraw",
                                        style: boldTextStyle(size: 15, color: redColor))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("March, 23", style: boldTextStyle(size: 20)),
                          Text("د.900")
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Hamad",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 80),
                                        Row(
                                          children: [
                                            Text("23/3/2023"),
                                            Text("12:56 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("1د.00",
                                        style: boldTextStyle(size: 15, color: black)),
                                        Text("WithDraw",
                                        style: boldTextStyle(size: 15, color: redColor))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Ahmed",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 80),
                                        Row(
                                          children: [
                                            Text("23/3/2023"),
                                            Text("12:56 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("د.250",
                                        style: boldTextStyle(size: 15, color: black)),
                                        Text("Transfer",
                                        style: boldTextStyle(size: 15, color: Colors.blue))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                
                       Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Hussein",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 75),
                                        Row(
                                          children: [
                                            Text("23/3/2023"),
                                            Text("12:56 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("د.370",
                                        style: boldTextStyle(size: 15, color: black)),
                                         Text("Transfer",
                                        style: boldTextStyle(size: 15, color: Colors.blue))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                
                       Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Ali",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 110),
                                        Row(
                                          children: [
                                            Text("23/3/2023"),
                                            Text("12:56 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("د.120",
                                        style: boldTextStyle(size: 15, color: black)),
                                         Text("Transfer",
                                        style: boldTextStyle(size: 15, color: Colors.blue))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                
                       Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        "images/mobile_banking/transactionimg1-removebg-preview.png",
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text("Younis",
                                            style: boldTextStyle(
                                                size: 15, color: black)).paddingOnly(right: 80),
                                        Row(
                                          children: [
                                            Text("23/3/2023"),
                                            Text("12:56 PM")
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("9.50",
                                        style: boldTextStyle(size: 15, color: black)),
                                         Text("Transfer",
                                        style: boldTextStyle(size: 15, color: Colors.blue))
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: 280,
                              child: Row(
                                children: [
                                  Divider(thickness: 1).expand(),
                                  Divider(thickness: 1).expand(),
                                ],
                              ),
                            ).center(),
                          ],
                        ),
                      ),
                      5.height,
                
                
                                        
                    ],
                  ),
                ),
              )
            ],
          ).paddingAll(30),
        ),
      ),
    );
  }
}

_OnclickCustomerOne(BuildContext context) {
   return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        waCommonCachedNetworkImage(
            'https://media.istockphoto.com/id/1294919612/vector/success-approved-payment-check-mark-notification-on-paper-receipt-bill-invoice-vector-flat.jpg?s=612x612&w=0&k=20&c=3t-tH-gYQrTuAfHK2QU1EXyNgwn9eOW1Twp5phUPCoE=',
            height: 200,
            width: 200,
            fit: BoxFit.fill),
        
        16.height,
        Text('Sucess!', style: secondaryTextStyle()),
        16.height,
        Text('Name: Rashid', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Amount: 50', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Account Number: 51144953', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Commision: 10', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Time: 12:56 PM', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        
        // Text('Now you can use your card with your new PIN', style: secondaryTextStyle()),
        // 30.height,
        AppButton(
          color: WAPrimaryColor,
          width: 180,
          height: 50,
          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          text: "Done",
          onTap: () {
            //WADashboardScreen(data: data,).launch(context);
            finish(context);
          },
          textStyle: boldTextStyle(color: Colors.white),
        ),
        16.height,
      ],
    );
}

_OnclickCustomerTwo(BuildContext context) {
   return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        waCommonCachedNetworkImage(
            'https://media.istockphoto.com/id/1294919612/vector/success-approved-payment-check-mark-notification-on-paper-receipt-bill-invoice-vector-flat.jpg?s=612x612&w=0&k=20&c=3t-tH-gYQrTuAfHK2QU1EXyNgwn9eOW1Twp5phUPCoE=',
            height: 200,
            width: 200,
            fit: BoxFit.fill),
        
        16.height,
        Text('Sucess!', style: secondaryTextStyle()),
        16.height,
        Text('Name: Maryam', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Amount: 170', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Account Number: 31989620', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Commision: 50', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        Text('Time: 01:47 PM', style: boldTextStyle(size: 15), textAlign: TextAlign.center),
        8.height,
        
        // Text('Now you can use your card with your new PIN', style: secondaryTextStyle()),
        // 30.height,
        AppButton(
          color: WAPrimaryColor,
          width: 180,
          height: 50,
          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          text: "Done",
          onTap: () {
            //WADashboardScreen(data: data,).launch(context);
            finish(context);
          },
          textStyle: boldTextStyle(color: Colors.white),
        ),
        16.height,
      ],
    );
}

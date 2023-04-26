import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/WAColors.dart';
import '../utils/WAWidgets.dart';

class BalanceInq extends StatefulWidget {
  const BalanceInq({Key? key}) : super(key: key);

  @override
  State<BalanceInq> createState() => _BalanceInqState();
}

class _BalanceInqState extends State<BalanceInq> {
  @override
  Widget build(BuildContext context) {
    return  Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      waCommonCachedNetworkImage(
          'https://media.istockphoto.com/id/1389741211/vector/email-notification-concept-new-message-on-the-smartphone-screen-vector-illustration-in-retro.jpg?s=612x612&w=0&k=20&c=0lc6FWQtL3b3j52zWCguV1i3w1NCpFecxPrWx4e0C8g=',
          height: 200,
          width: 200,
          fit: BoxFit.fill),
      16.height,
      Text('Done!', style: secondaryTextStyle()),
      16.height,
      Text('Balance Details Has Been Send To Registered',
          style: boldTextStyle(size: 22), textAlign: TextAlign.center),
      8.height,
      Text('Mobile Number 0508***760',
          style: boldTextStyle(size: 22), textAlign: TextAlign.center),
      8.height,
      // createRichText(list: [
      //   TextSpan(
      //       text: "You have deposit to ",
      //       style: secondaryTextStyle()),
      //   TextSpan(
      //       text: " ", style: boldTextStyle()),
      // ], textAlign: TextAlign.center),
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
          finish(context);
        },
        textStyle: boldTextStyle(color: Colors.white),
      ),
      16.height,
    ],
  );
  }
}
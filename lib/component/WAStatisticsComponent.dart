import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';

class WAStatisticsComponent extends StatefulWidget {
  static String tag = '/WAStatisticsComponent';

  @override
  WAStatisticsComponentState createState() => WAStatisticsComponentState();
}

class WAStatisticsComponentState extends State<WAStatisticsComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Agent Commision", style: boldTextStyle(size: 15, color: black)),
        Row(
          children: [
            waStatisticsWidget(
                    title: "Received",
                    amount: "د.إ5555",
                    image: 'images/mobile_banking/wa_up_right.png',
                    color: Color(0xFF6C56F9))
                .expand(),
            16.width,
            waStatisticsWidget(
                    title: "Spent",
                    amount: "د.إ2124",
                    image: 'images/mobile_banking/wa_down_left.png',
                    color: Color(0xFFFF7426))
                .expand(),
          ],
        ).paddingOnly(left: 16, right: 16),
      ],
    );
  }
}

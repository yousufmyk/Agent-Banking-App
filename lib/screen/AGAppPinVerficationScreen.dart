import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';


class AGAppPinChangeScreen extends StatefulWidget {
  const AGAppPinChangeScreen({Key? key}) : super(key: key);

  @override
  State<AGAppPinChangeScreen> createState() => _AGAppPinChangeScreenState();
}

class _AGAppPinChangeScreenState extends State<AGAppPinChangeScreen> {
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pinput(
      controller: pinController,
      length: 10,
      toolbarEnabled: false,
      //inputFormatters: [Formatter()],
    )
      ],
    );
  }
}
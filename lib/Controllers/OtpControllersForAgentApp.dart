import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AgentAppOtpController extends GetxController {
  final username = TextEditingController();

  RxBool isChecked = false.obs;

  @override
  void dispose() {
    username.dispose();

    super.dispose();
  }
}

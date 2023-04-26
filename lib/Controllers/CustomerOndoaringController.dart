import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomerOnboardingController extends GetxController{

final cxUserName = TextEditingController();
final cxFirstName = TextEditingController();
final cxLastName = TextEditingController();
final cxAgentId = TextEditingController();
final cxCifNum = TextEditingController();
final cxBranchName = TextEditingController();
final cxEmail = TextEditingController();
final cxPhoneNumber = TextEditingController();
final cxPassword = TextEditingController();
 final cxDob = TextEditingController();
// final cxDob = TextEditingController();
// final cxDob = TextEditingController();
// final cxDob = TextEditingController();
// final cxDob = TextEditingController();
// final cxDob = TextEditingController();
// final agentPassword = TextEditingController();
// final agentConfirmPassword = TextEditingController();
// final agentUserName = TextEditingController();
// final agentMobileNumber = TextEditingController();
// var agentFirstName = TextEditingController();
// final agentLastName = TextEditingController();
// final agentDOB = TextEditingController();
// final agentCif = TextEditingController();

RxBool isChecked = false.obs;


@override
  void dispose() {
    cxUserName.dispose();
    cxFirstName.dispose();
    cxLastName.dispose();
    cxAgentId.dispose();
    cxCifNum.dispose();
    cxBranchName.dispose();
    cxEmail.dispose();
    cxPhoneNumber.dispose();
    cxPassword.dispose();
    cxDob.dispose();
    
    super.dispose();
  }



}
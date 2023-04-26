import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AgentOnboardingController extends GetxController{

final agentEmail = TextEditingController();
final agentPassword = TextEditingController();
final agentConfirmPassword = TextEditingController();
final agentUserName = TextEditingController();
final agentMobileNumber = TextEditingController();
var agentFirstName = TextEditingController();
final agentLastName = TextEditingController();
final agentDOB = TextEditingController();
final agentCif = TextEditingController();

RxBool isChecked = false.obs;


@override
  void dispose() {
    agentEmail.dispose();
    agentPassword.dispose();
    agentUserName.dispose();
    agentMobileNumber.dispose();
    agentFirstName.dispose();
    agentLastName.dispose();
    agentDOB.dispose();
    agentCif.dispose();
    agentConfirmPassword.dispose();
   
    
    super.dispose();
  }



}
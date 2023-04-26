import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {

  final username = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final emailController = TextEditingController();
  final   numberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final pinController = TextEditingController();
  final   securityQuestionOneController = TextEditingController();
  final   securityQuestionTwoController = TextEditingController();
  final   securityQuestionThreeController = TextEditingController();
  final   companynameController = TextEditingController();
  final   companysizeController = TextEditingController();
  final   businesstypeController = TextEditingController();
  final   cifController = TextEditingController();
  final   bankbranchController = TextEditingController();
  final   agentIdController = TextEditingController();
  final   confirmPinController = TextEditingController();
  //final   businesstypeController = TextEditingController();

RxBool isChecked = false.obs;





@override
  void dispose() {
    companynameController.dispose();
    companysizeController.dispose();
    businesstypeController.dispose();
    cifController.dispose();
    bankbranchController.dispose();
    username.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateOfBirthController.dispose();
    pinController.dispose();
    securityQuestionOneController.dispose();
    securityQuestionTwoController.dispose();
    securityQuestionThreeController.dispose();

    
   
    //sercuritlyQuestionAnswer.dispose();
    super.dispose();
  }





}
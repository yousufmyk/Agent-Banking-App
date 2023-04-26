import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/screen/AGAppAgentLoginScreen.dart';
import 'package:mobile_banking/utils/WAColors.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';

import '../Controllers/AgentOnboaridngController.dart';
import '../Controllers/RegistrationController.dart';
import '../component/AGAppCountryStateCityPickerComponenet.dart';
import '../component/WAProfilePicPickComponent.dart';
import '../component/WAUploadKYCdailog.dart';
import '../main.dart';
import '../model/AgentApi Service/Validation Apis/AgentEmailValidateApi.dart';

import '../model/Api Service/Auth Apis/registrationApi.dart';
import '../model/cardDetailsModel.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'AGAppCorporateOnboardingScreen.dart';
import 'package:http/http.dart' as http;

class AGAppPersonalOnboardScreen extends StatefulWidget {
  static String tag = '/AGAppPersonalOnboardScreen';

  @override
  AGAppPersonalOnboardScreenState createState() =>
      AGAppPersonalOnboardScreenState();
}

class AGAppPersonalOnboardScreenState
    extends State<AGAppPersonalOnboardScreen> {
  //final controller = Get.put(RegistrationController());
  final controller = Get.put(AgentOnboardingController());

  FocusNode userNameFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode numberFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  FocusNode confirmPassWordFocusNode = FocusNode();
  FocusNode dateOfBirthFocusNode = FocusNode();
  FocusNode mpinFocusNode = FocusNode();
  FocusNode securityQuestionOneFocusNode = FocusNode();
  FocusNode securityQuestionTwoFocusNode = FocusNode();
  FocusNode securityQuestionThreeFocusNode = FocusNode();
  FocusNode confirmPinFocusNode = FocusNode();
  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  var personalDetailsMendotary = Text("");

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _usernameformKey = GlobalKey<FormState>();
  final _confirmPassWordformKey = GlobalKey<FormState>();
  List<XFile>? _imageFileList;
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  List<Widget> bodyElements = [];

  void addBodyElement() {
    bodyElements.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: CountrySateCityPickerComponent(),
    ));
  }

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _picker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      //await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile> pickedFileList = await _picker.pickMultiImage(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _imageFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    } else {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: quality,
          );
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      });
    }
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : null;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : null;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : null;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  var country = 0;

  final _formKeyTwo = GlobalKey<FormState>();

  //VerfiyUserName Api
  var userNameStatus = Text("");
  verfiyUserName() async {
    //var length = await image!.length();
    final username = controller.agentUserName.text.toString();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/checkexistedCustomerDetails');

    var request = http.MultipartRequest('GET', uri);

    request.fields['userName'] = username;
    request.fields['InstId'] = 'OMA';

    var response = await request.send();

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      print('Sucess');

      if (respStr == "true") {
        var status = Text(
          "User Name Not Available",
          style: TextStyle(color: Colors.redAccent),
        );
        setState(() {
          userNameStatus = status;
        });
      }
      if (respStr == "false") {
        var status = Text(
          "User Name Available",
          style: TextStyle(color: Colors.greenAccent),
        );
        setState(() {
          userNameStatus = status;
        });
      }
    } else {
      print(response.toString());
      final respStr = await response.stream.bytesToString();
      //print(response.statusCode);
      print('failed');
      print(respStr);
    }
  }

  //verify email Api

  var emailStatus = Text("");
  verfiyEmail() async {
    //var length = await image!.length();
    final email = controller.agentEmail.text.toString();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/checkexistedCustomerDetails');

    var request = http.MultipartRequest('GET', uri);

    request.fields['EmailId'] = email;
    request.fields['InstId'] = 'OMA';

    var response = await request.send();

    if (response.statusCode == 200) {
      final emailrespStr = await response.stream.bytesToString();
      print('Sucess');

      if (emailrespStr == "true") {
        var status = Text(
          "Email Not Available",
          style: TextStyle(color: Colors.redAccent),
        );
        setState(() {
          emailStatus = status;
        });
      }
      if (emailrespStr == "false") {
        var status = Text(
          "Email Available",
          style: TextStyle(color: Colors.greenAccent),
        );
        setState(() {
          emailStatus = status;
        });
      }
    } else {
      print(response.toString());
      final emailrespStr = await response.stream.bytesToString();
      //print(response.statusCode);
      print('failed');
      print(emailrespStr);
    }
  }

// phone Number Api

  var numStatus = Text("");
  verfiyNum() async {
    //var length = await image!.length();
    final num = controller.agentMobileNumber.text.toString();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/checkexistedCustomerDetails');

    var request = http.MultipartRequest('GET', uri);

    request.fields['mobileNumber'] = num;
    request.fields['InstId'] = 'OMA';

    var response = await request.send();

    if (response.statusCode == 200) {
      final numrespStr = await response.stream.bytesToString();
      print('Sucess');

      if (numrespStr == "true") {
        var status = Text(
          "Mobile Number Not Available",
          style: TextStyle(color: Colors.redAccent),
        );
        setState(() {
          numStatus = status;
        });
      }
      if (numrespStr == "false") {
        var status = Text(
          "Mobile Number Available",
          style: TextStyle(color: Colors.greenAccent),
        );
        setState(() {
          numStatus = status;
        });
      }
    } else {
      print(response.toString());
      final numrespStr = await response.stream.bytesToString();
      //print(response.statusCode);
      print('failed');
      print(numrespStr);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  var enabledLast = true;

  @override
  Widget build(BuildContext context) {
    //final _controller = Get.put(RegistrationController());
    final controller = Get.put(AgentOnboardingController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          25.height,
          PickProfilePictureComponenet(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stepper(
                    type: stepperType,
                    physics: ScrollPhysics(),
                    currentStep: _currentStep,
                    onStepTapped: (step) => tapped(step),
                    onStepContinue: lastContinue,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: Row(
                          children: [
                            new Text('Personal Details',
                                style: boldTextStyle(size: 18, color: black)),
                            personalDetailsMendotary
                          ],
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            25.height,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("User Name",
                                    style: boldTextStyle(size: 14)),
                                8.height,
                                Form(
                                  key: _usernameformKey,
                                  child: AppTextField(
                                    decoration: waInputDecoration(
                                        hint: 'Enter your user name here',
                                        prefixIcon:
                                            Icons.person_outline_outlined),
                                    textFieldType: TextFieldType.NAME,
                                    keyboardType: TextInputType.name,
                                    controller: controller.agentUserName,
                                    suffix: TextButton(
                                        onPressed: () async {
                                          await verfiyUserName();
                                        },
                                        child: Text("Verify")),
                                    focus: userNameFocusNode,
                                    nextFocus: emailFocusNode,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'User Name is Mandatory!';
                                      }
                                      if (value.length < 3) {
                                        return 'Minimum 3 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                userNameStatus,
                                //ElevatedButton(onPressed: (){}, child: Text("Validate"))
                                //ValidateEmailApi()
                              ],
                            ),
                            // ElevatedButton(
                            //     onPressed: () {

                            //     }, child: Text("Validate")),
                            16.height,
                            Text("First Name", style: boldTextStyle(size: 14)),
                            8.height,

                            Form(
                              key: _formKey,
                              child: AppTextField(
                                decoration: waInputDecoration(
                                    hint: 'Enter your first name here',
                                    prefixIcon: Icons.person_outline_outlined),
                                textFieldType: TextFieldType.NAME,
                                keyboardType: TextInputType.name,
                                controller: controller.agentFirstName,
                                focus: firstNameFocusNode,
                                nextFocus: emailFocusNode,
                                isValidationRequired: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'First Name is Mandatory!';
                                  }
                                  if (value.length < 3) {
                                    return 'Minimum 3 characters';
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value.isEmpty || value.length < 3) {
                                    setState(() {
                                      enabledLast = false;
                                    });
                                  } else {
                                    setState(() {
                                      enabledLast = true;
                                    });
                                  }
                                },
                              ),
                            ), //errorThisFieldRequired: "Please enter some text",

                            16.height,
                            Text("Last Name", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your last name here',
                                  prefixIcon: Icons.person_outline_outlined),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: controller.agentLastName,
                              focus: lastNameFocusNode,
                              nextFocus: emailFocusNode,
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 0
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Contact Details',
                            style: boldTextStyle(size: 18, color: black)),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            16.height,
                            Text("Email", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your email here',
                                  prefixIcon: Icons.email_outlined),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              suffix: TextButton(
                                  onPressed: () async {
                                    await verfiyEmail();
                                  },
                                  child: Text("Verify")),
                              controller: controller.agentEmail,
                              focus: emailFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                            emailStatus,
                            16.height,
                            Text("Phone Number",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: '050XXXXXXX',
                                  prefixIcon: Icons.numbers_outlined),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              suffix: TextButton(
                                  onPressed: () async {
                                    await verfiyNum();
                                  },
                                  child: Text("Verify")),
                              controller: controller.agentMobileNumber,
                              focus: numberFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                            numStatus,
                            16.height,
                            Text("Password", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your password here',
                                  prefixIcon: Icons.lock_outline),
                              suffixIconColor: WAPrimaryColor,
                              textFieldType: TextFieldType.PASSWORD,
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: controller.agentPassword,
                              focus: passWordFocusNode,
                              nextFocus: confirmPassWordFocusNode,
                            ),
                            16.height,
                            Text("Confirm Password",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            Form(
                              key: _confirmPassWordformKey,
                              child: AppTextField(
                                decoration: waInputDecoration(
                                    hint: 'Confirm password',
                                    prefixIcon: Icons.lock_outline),
                                suffixIconColor: WAPrimaryColor,
                                textFieldType: TextFieldType.PASSWORD,
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                controller: controller.agentConfirmPassword,
                                focus: confirmPassWordFocusNode,
                                validator: (value) {
                                  if (value !=
                                      controller.agentPassword.text.toString()) {
                                    return 'Password Did Not Match';
                                  }
                                  if (value!.isEmpty) {
                                    return null;
                                  }
                            
                                  return null;
                                },
                              ),
                            ),
                            16.height,
                            Text("Date of birth",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'DD-MM-YYYY',
                                  prefixIcon: Icons.date_range_outlined),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.number,
                              controller: controller.agentDOB,
                              focus: dateOfBirthFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Pin & Agent Location',
                            style: boldTextStyle(size: 18, color: black)),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              16.height,
                              Text("Pin", style: boldTextStyle(size: 14)),
                              8.height,
                              AppTextField(
                                decoration: waInputDecoration(
                                    hint: 'Enter your Pin here',
                                    prefixIcon: Icons.password_outlined),
                                suffixIconColor: WAPrimaryColor,
                                textFieldType: TextFieldType.PASSWORD,
                                isPassword: true,
                                keyboardType: TextInputType.number,
                                //controller: _controller.pinController,
                                focus: mpinFocusNode,
                                //nextFocus: passWordFocusNode,
                              ),
                              16.height,
                              Text("Confirm Pin",
                                  style: boldTextStyle(size: 14)),
                              8.height,
                              AppTextField(
                                decoration: waInputDecoration(
                                    hint: 'Confirm your Pin here',
                                    prefixIcon: Icons.password_outlined),
                                suffixIconColor: WAPrimaryColor,
                                textFieldType: TextFieldType.PASSWORD,
                                isPassword: true,
                                keyboardType: TextInputType.number,
                                // controller: _controller.confirmPinController,
                                focus: confirmPinFocusNode,
                                //nextFocus: passWordFocusNode,
                              ),
                              16.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select Location",
                                      style: boldTextStyle(size: 14)),
                                  FloatingActionButton.extended(
                                    icon: Icon(Icons.add),
                                    label: Text('Add'),
                                    onPressed: () {
                                      //num++;
                                      setState(() {
                                        addBodyElement();
                                      });
                                    },
                                  ),
                                ],
                              ),
                              16.height,
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView(
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Column(
                                          children: bodyElements,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                  //RegistrationApi(),
                  Container(
                    child: AppButton(
                            text: "Continue",
                            color: WAPrimaryColor,
                            textColor: Colors.white,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            width: MediaQuery.of(context).size.width,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {}
                              // await getpostStatment();
                              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              // content: Text('Your account has been sucessfully created')));
                              //AGAppCorporateOnboardScreen().launch(context);
                            })
                        .paddingOnly(
                            left: MediaQuery.of(context).size.width * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1),
                  ),
                  30.height,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: primaryTextStyle(color: Colors.grey)),
                      4.width,
                      Text('Log In here',
                          style: boldTextStyle(
                              color: appStore.isDarkModeOn ? white : black)),
                    ],
                  ).onTap(() {
                    finish(context);
                  }).center(),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  lastContinue() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    if (_formKey.currentState!.validate() ) {}
    if (_usernameformKey.currentState!.validate()) {}
    if(_confirmPassWordformKey.currentState!.validate()){}
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class AspectRatioVideo extends StatefulWidget {
  const AspectRatioVideo(this.controller, {Key? key}) : super(key: key);

  final VideoPlayerController? controller;

  @override
  AspectRatioVideoState createState() => AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController? get controller => widget.controller;
  bool initialized = false;

  void _onVideoControllerUpdate() {
    if (!mounted) {
      return;
    }
    if (initialized != controller!.value.isInitialized) {
      initialized = controller!.value.isInitialized;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    controller!.addListener(_onVideoControllerUpdate);
  }

  @override
  void dispose() {
    controller!.removeListener(_onVideoControllerUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),
        ),
      );
    } else {
      return Container();
    }
  }
}

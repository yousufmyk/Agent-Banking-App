import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/screen/AGAppAgentLoginScreen.dart';
import 'package:mobile_banking/utils/WAColors.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';

import '../Controllers/CustomerOndoaringController.dart';
import '../Controllers/RegistrationController.dart';
import '../component/WAIdCardComponent.dart';
import '../component/WAProfilePicPickComponent.dart';
import '../component/WAUploadKYCComponent.dart';
import '../component/WAUploadKYCdailog.dart';
import '../main.dart';
import '../model/Api Service/Auth Apis/registrationApi.dart';
import '../model/cardDetailsModel.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'AGAppMainScreen.dart';
import 'package:http/http.dart' as http;

class AGAppCustomerOnboardScreen extends StatefulWidget {
  static String tag = '/AGAppCustomerOnboardScreen';

  @override
  AGAppCustomerOnboardScreenState createState() =>
      AGAppCustomerOnboardScreenState();
}

class AGAppCustomerOnboardScreenState
    extends State<AGAppCustomerOnboardScreen> {
  //final controller = Get.put(RegistrationController());
  final controller = Get.put(CustomerOnboardingController());

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
  FocusNode companynameFocusNode = FocusNode();
  FocusNode businesstypeFocusNode = FocusNode();
  FocusNode cifFocusNode = FocusNode();
  FocusNode branchnameFocusNode = FocusNode();
  FocusNode agentIdFocusNode = FocusNode();

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _Profilepicker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  List<XFile>? _imageFileList;
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (isVideo) {
      final XFile? file = await _Profilepicker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      //await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile> pickedFileList =
              await _Profilepicker.pickMultiImage(
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
          final XFile? pickedFile = await _Profilepicker.pickImage(
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

//EMAIL Verify Api
  var emailStatus = Text("");
  verfiyEmail() async {
    //var length = await image!.length();
    final email = controller.cxEmail.text.toString();

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

  //VerfiyUserName Api
  var userNameStatus = Text("");
  verfiyUserName() async {
    //var length = await image!.length();
    final username = controller.cxUserName.text.toString();

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

  // phone Number Api

  var numStatus = Text("");
  verfiyNum() async {
    //var length = await image!.length();
    final num = controller.cxPhoneNumber.text.toString();

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

  //image uploading functions

  File? image;
  File? imageTwo;

  final _picker = ImagePicker();
  //bool showSpinner = false;

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
      print(image);
    } else {
      print('No image selected');
    }
  }

  Future getImageTwo() async {
    final pickedFileTwo =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFileTwo != null) {
      imageTwo = File(pickedFileTwo.path);
      setState(() {});
    } else {
      print('there is no image');
    }
  }

  Future<void> onBoardCustomer() async {
    final username = controller.cxUserName.text.toString();
    final password = controller.cxPassword.text.toString();
    final firstName = controller.cxFirstName.text.toString();
    final lastName = controller.cxLastName.text.toString();
    final emailId = controller.cxEmail.text.toString();
    final mobileNum = controller.cxPhoneNumber.text.toString();
    final dob = controller.cxDob.text.toString();

    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/customerOnBoarding');

    var request = http.MultipartRequest('POST', uri);

    var multiport = http.MultipartFile('file', stream, length);
    var streamTwo = http.ByteStream(imageTwo!.openRead());

    streamTwo.cast();

    var lengthTwo = await imageTwo!.length();

    var multiportTwo = http.MultipartFile('file', streamTwo, lengthTwo);

    request.files.add(await http.MultipartFile.fromPath("file", image!.path));
    request.files
        .add(await http.MultipartFile.fromPath("file", imageTwo!.path));
    request.fields['userName'] = username;
    request.fields['password'] = password;
    request.fields['emailId'] = emailId;
    request.fields['mobileCountryCode'] = '+971';
    request.fields['mobileNumber'] = mobileNum;
    request.fields['instId'] = 'OMA';
    request.fields['customerType'] = 'type1';
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['role'] = 'Agent';
    request.fields['deviceType'] = 'WEB';
    request.fields['dob'] = dob;
    request.fields['mcc'] = 'abcde';
    request.fields['businessType'] = 'asdfg';
    request.fields['tradeLicenseCode'] = 'xyz';
    request.fields['agentId'] = '100';
    request.fields['accountNumber'] = '9876543210123456';
    request.fields['cityId'] = '1,2';
    request.fields['kycType'] = 'E-KYC';

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Sucess by Multiport');
      print(request.files);
      //print(_agnetController.agentPassword.text.toString());
    } else {
      print(response.statusCode.toString());
      print('failed by multi port');
    }
  }

  List<String> listitems = [];
  String selectval = "Select";
  String selectvalTwo = "Select";
  String selectvalThree = "Select";
  getSecurityQuestions() async {
    // var token =
    //     'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ7XCJpbnN0SWRcIjpcIk9NQVwiLFwidXNlck5hbWVcIjpcInlvdXN1ZnRlc3QxXCIsXCJwYXNzd29yZFwiOlwiYWFmNGM2MWRkY2M1ZThhMmRhYmVkZTBmM2I0ODJjZDlhZWE5NDM0ZFwiLFwicGluXCI6bnVsbCxcInJvbGVcIjpcIkFHRU5UXCIsXCJkZXZpY2VUeXBlXCI6XCJXRUJcIixcImFwcGxpY2F0aW9uQWNjZXNzXCI6bnVsbCxcImV4cGlyYXRpb25UaW1lXCI6NDMyMDAsXCJtb2JpbGVDb3VudHJ5Q29kZVwiOlwiKzk3MVwiLFwibW9iaWxlTnVtYmVyXCI6XCIwNTA3NzAyMTQ5XCIsXCJlbWFpbElkXCI6XCJ5b3VzdWZAb21hZW1pcmF0ZXMuY29tXCIsXCJjdXN0SWRcIjpcIjAwMDAwMDAwMDA5OTNcIixcIndhbGxldElkXCI6bnVsbCxcImFjY291bnROdW1iZXJcIjpudWxsLFwiY2FyZFJlZmVyZW5jZU51bWJlclwiOm51bGx9IiwiZXhwIjoxNjgwODk2NTI2LCJpYXQiOjE2ODA4NTMzMjZ9.rqKFsyKhkvk0kZnkcUX_lAsKwS1L9y7CvRp62JIIo0hZBQNZw21x7PEByIOsVBtE5gVny9uG2TreONwyLp540g';
    final response = await http.get(
      Uri.parse(
          'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/getSecurityQuestionDetails'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var decodeData = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (decodeData['responseType'].toString() == "S") {
        int? length = decodeData['responseValue']['list'].length;
        for (var i = 0; i < length!; i++) {
          listitems.add(decodeData['responseValue']['list'][i]['question']);
        }
        print(listitems);
        return listitems;
      } else {
        print("error in security questions api");
      }
    }
  }

  @override
  void initState() {
    getSecurityQuestions();
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

  @override
  Widget build(BuildContext context) {
    //final _controller = Get.put(RegistrationController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Customer On Boarding',
          style: boldTextStyle(color: Colors.black, size: 20),
        ),
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
      body: Column(
        children: <Widget>[
          50.height,
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
                    onStepContinue: continued,
                    onStepCancel: cancel,
                    steps: <Step>[
                      Step(
                        title: new Text('Personal Details',
                            style: boldTextStyle(size: 18, color: black)),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            25.height,
                            Text("User Name", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your user name here',
                                  prefixIcon: Icons.person_outline_outlined),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: controller.cxUserName,
                              focus: userNameFocusNode,
                              nextFocus: emailFocusNode,
                              suffix: TextButton(
                                  onPressed: () async {
                                    await verfiyUserName();
                                  },
                                  child: Text("Verify")),
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
                            userNameStatus,
                            16.height,
                            Text("First Name", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your first name here',
                                  prefixIcon: Icons.person_outline_outlined),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: controller.cxFirstName,
                              focus: firstNameFocusNode,
                              nextFocus: emailFocusNode,
                            ),
                            16.height,
                            Text("Last Name", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your last name here',
                                  prefixIcon: Icons.person_outline_outlined),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: controller.cxLastName,
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
                        title: new Text('Upload KYC Docs',
                            style: boldTextStyle(size: 18, color: black)),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Container(
                                          child: image == null
                                              ? IdCardWidget(
                                                  imagePath:
                                                      'images/mobile_banking/card_back.png',
                                                  title: "Front",
                                                  iconSize: 1,
                                                  hasIcon: false,
                                                )
                                              : Container(
                                                  child: Center(
                                                    child: Image.file(
                                                      File(image!.path)
                                                          .absolute,
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                    ),
                                    10.height,
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getImageTwo();
                                      },
                                      child: Container(
                                          child: imageTwo == null
                                              ? IdCardWidget(
                                                  imagePath:
                                                      "images/mobile_banking/card_front.png",
                                                  title: "Back",
                                                  iconSize: 1,
                                                  hasIcon: false,
                                                )
                                              : Container(
                                                  child: Center(
                                                    child: Image.file(
                                                      File(imageTwo!.path)
                                                          .absolute,
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 1
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Agent Details',
                            style: boldTextStyle(size: 18, color: black)),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            16.height,
                            Text("Agent ID", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your Agent ID here',
                                  prefixIcon: Icons.person),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.cxAgentId,
                              focus: agentIdFocusNode,
                              nextFocus: cifFocusNode,
                            ),
                            16.height,
                            Text("CIF Number", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your CIF Number here',
                                  prefixIcon: Icons.numbers_rounded),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.cxCifNum,
                              focus: cifFocusNode,
                              nextFocus: branchnameFocusNode,
                            ),
                            16.height,
                            Text("Branch Name", style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your Branch Name here',
                                  prefixIcon: Icons.corporate_fare_rounded),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.cxBranchName,
                              focus: branchnameFocusNode,
                              // nextFocus: passWordFocusNode,
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 2
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
                              controller: controller.cxEmail,
                              focus: emailFocusNode,
                              nextFocus: passWordFocusNode,
                              suffix: TextButton(
                                  onPressed: () async {
                                    await verfiyEmail();
                                  },
                                  child: Text("Verify")),
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
                              controller: controller.cxPhoneNumber,
                              focus: numberFocusNode,
                              nextFocus: passWordFocusNode,
                              suffix: TextButton(
                                  onPressed: () async {
                                    await verfiyNum();
                                  },
                                  child: Text("Verify")),
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
                              controller: controller.cxPassword,
                              focus: passWordFocusNode,
                              nextFocus: confirmPassWordFocusNode,
                            ),
                            16.height,
                            Text("Confirm Password",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Re-type password',
                                  prefixIcon: Icons.lock_outline),
                              suffixIconColor: WAPrimaryColor,
                              textFieldType: TextFieldType.PASSWORD,
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              //controller: _controller.passwordController,
                              focus: confirmPassWordFocusNode,
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
                              controller: controller.cxDob,
                              focus: dateOfBirthFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 3
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                      Step(
                        title: new Text('Pin & Security Questions',
                            style: boldTextStyle(size: 18, color: black)),
                        content: Column(
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
                              nextFocus: passWordFocusNode,
                            ),
                            16.height,
                            Text("Security Question 1",
                                style: boldTextStyle(size: 14)),
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration: waInputDecoration(
                                  hint: "Select Security Question"),
                              items: listitems.map((itemone) {
                                return DropdownMenuItem(
                                    value: itemone,
                                    child: Text(itemone,
                                        style: boldTextStyle(size: 14)));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectval = value.toString();
                                  //listitems.remove(selectval);
                                });
                              },
                            ),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your answer here',
                                  prefixIcon: Icons.question_mark_outlined),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.name,
                              // controller:
                              //     _controller.securityQuestionOneController,
                              focus: securityQuestionOneFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                            16.height,
                            Text("Security Question 2",
                                style: boldTextStyle(size: 14)),
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration: waInputDecoration(
                                  hint: "Select Security Question"),
                              items: listitems.map((itemone) {
                                return DropdownMenuItem(
                                    value: itemone,
                                    child: Text(itemone,
                                        style: boldTextStyle(size: 14)));
                              }).toList(),
                              onChanged: (valueTwo) {
                                setState(() {
                                  selectvalTwo = valueTwo.toString();
                                  //listitems.remove(selectval);
                                });
                              },
                            ),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your answer here',
                                  prefixIcon: Icons.question_mark_outlined),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.name,
                              // controller:
                              //     _controller.securityQuestionTwoController,
                              focus: securityQuestionTwoFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                            16.height,
                            Text("Security Question 3",
                                style: boldTextStyle(size: 14)),
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration: waInputDecoration(
                                  hint: "Select Security Question"),
                              items: listitems.map((itemone) {
                                return DropdownMenuItem(
                                    value: itemone,
                                    child: Text(itemone,
                                        style: boldTextStyle(size: 14)));
                              }).toList(),
                              onChanged: (valueThree) {
                                setState(() {
                                  selectvalThree = valueThree.toString();
                                  //listitems.remove(selectval);
                                });
                              },
                            ),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your answer here',
                                  prefixIcon: Icons.question_mark_outlined),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.name,
                              // controller:
                              //     _controller.securityQuestionThreeController,
                              focus: securityQuestionThreeFocusNode,
                              nextFocus: passWordFocusNode,
                            ),
                            30.height,
                          ],
                        ),
                        isActive: _currentStep >= 0,
                        state: _currentStep >= 4
                            ? StepState.complete
                            : StepState.disabled,
                      ),
                    ],
                  ),
                  //RegistrationApi(),
                  Container(
                    child: AppButton(
                            text: "Register Account",
                            color: WAPrimaryColor,
                            textColor: Colors.white,
                            shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            width: MediaQuery.of(context).size.width,
                            onTap: () async {
                              // await getpostStatment();
                              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              // content: Text('Your account has been sucessfully created')));
                              // showInDialog(context, builder: (context) {
                              //   // return WAMoneyTransferCompleteDialog(
                              //   //   data: data,
                              //   // );
                              //   // return _EnterOtpScreen(
                              //   //     context, otpController, otpFocus, data);
                              //   return _OnDepositDone(context);
                              // });
                              await onBoardCustomer();
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
    _currentStep < 4 ? setState(() => _currentStep += 1) : null;
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

_OnDepositDone(
  BuildContext context,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      waCommonCachedNetworkImage(
          'https://media.istockphoto.com/id/1317078770/vector/checklist-or-clipboard-icon.jpg?s=612x612&w=0&k=20&c=te6Rqq4TSDw-i7-16rliqq7o63bsKMSL8ayawKGUPP4=',
          height: 200,
          width: 200,
          fit: BoxFit.fill),
      16.height,
      Text('Done!', style: secondaryTextStyle()),
      16.height,
      Text(
          'Customer: Yousuf Registred Successfully. Waiting For Admin Approval',
          style: boldTextStyle(size: 22),
          textAlign: TextAlign.center),
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
          //finish(context);
          AGAppMianScreen().launch(context);
        },
        textStyle: boldTextStyle(color: Colors.white),
      ),
      16.height,
    ],
  );
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/screen/AGAppAgentLoginScreen.dart';
import 'package:mobile_banking/utils/WAColors.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';

import '../Controllers/AgentOnboaridngController.dart';
import '../Controllers/RegistrationController.dart';
import '../component/WAIdCardComponent.dart';
import '../component/WAProfilePicPickComponent.dart';
import '../component/WAUploadKYCComponent.dart';
import '../component/WAUploadKYCdailog.dart';
import '../main.dart';
import '../model/AgentApi Service/Onboarding Apis/AgentOnboardingApi.dart';
import '../model/Api Service/Auth Apis/registrationApi.dart';
import '../model/cardDetailsModel.dart';
import 'package:async/async.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'AGAppFinancialScreen.dart';
import 'AGAppMainScreen.dart';
import 'package:http/http.dart' as http;

class AGAppCorporateOnboardScreen extends StatefulWidget {
  static String tag = '/AGAppCorporateOnboardScreen';

  @override
  AGAppCorporateOnboardScreenState createState() =>
      AGAppCorporateOnboardScreenState();
}

class AGAppCorporateOnboardScreenState
    extends State<AGAppCorporateOnboardScreen> {
  final controller = Get.put(RegistrationController());
  final _agnetController = Get.put(AgentOnboardingController());

  final _bankDetailsformKey = GlobalKey<FormState>();

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

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;

  final ImagePicker _profilepicker = ImagePicker();
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
      final XFile? file = await _profilepicker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      //await _playVideo(file);
    } else if (isMultiImage) {
      await _displayPickImageDialog(context!,
          (double? maxWidth, double? maxHeight, int? quality) async {
        try {
          final List<XFile> pickedFileList =
              await _profilepicker.pickMultiImage(
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
          final XFile? pickedFile = await _profilepicker.pickImage(
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

  Future<void> uploadImage() async {
    final username = _agnetController.agentUserName.text.toString();
    final password = _agnetController.agentPassword.text.toString();
    final emailId = _agnetController.agentEmail.text.toString();
    final mobileNum = _agnetController.agentMobileNumber.text.toString();
    final firstName = _agnetController.agentFirstName.text.toString();
    final lastName = _agnetController.agentLastName.text.toString();
    final dob = _agnetController.agentDOB.text.toString();
    final cifId = _agnetController.agentCif.text.toString();
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse(
        'http://10.0.33.181:8089/NanoAgencyBanking/v1/app/agentOnBoarding');

    var request = http.MultipartRequest('POST', uri);

    var multiport = http.MultipartFile('file', stream, length);
    var streamTwo = http.ByteStream(imageTwo!.openRead());

    streamTwo.cast();

    var lengthTwo = await imageTwo!.length();

    var multiportTwo = http.MultipartFile('file', streamTwo, lengthTwo);

    //request.files.add(multiport);
    // request.files.add(multiportTwo);
    // final k1 = await http.MultipartFile.fromPath('file', multiport.toString());
    // final k2 = await http.MultipartFile.fromPath('file', multiportTwo.toString());
    // request.files.add(k1);
    // request.files.add(k2);
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
    request.fields['cifId'] = cifId;
    request.fields['cityId'] = '1,2';
    request.fields['kycType'] = 'E-KYC';
// request.fields['file'] = k1;
// request.fields['file'] = multiportTwo.toString();
    var response = await request.send();

    if (response.statusCode == 200) {
      // setState(() {
      //   showSpinner = false;
      // });
      print('Sucess by Multiport');
      print(request.files);
      print(_agnetController.agentPassword.text.toString());
    } else {
      // setState(() {
      //   showSpinner = false;
      // });
      print(response.statusCode.toString());
      print('failed by multi port');
    }
  }

// Security Questions Api

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
    final _controller = Get.put(RegistrationController());
    final controller = Get.put(AgentOnboardingController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //50.height,
      
            25.height,
            //PickProfilePictureComponenet(),
            Column(
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
                      title: new Text('Corporate & Bank Details',
                          style: boldTextStyle(size: 18, color: black)),
                      content: Form(
                        key: _bankDetailsformKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            16.height,
                            Text("Company Name",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your Company Name here',
                                  prefixIcon: Icons.corporate_fare_rounded),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: _controller.companynameController,
                              focus: companynameFocusNode,
                              nextFocus: businesstypeFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Mandatory!';
                                }
                                return null;
                              },
                            ),
                            16.height,
                            Text("Business Type",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your Business Type here',
                                  prefixIcon: Icons.business_center_rounded),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: _controller.businesstypeController,
                              focus: businesstypeFocusNode,
                              nextFocus: cifFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Mandatory!';
                                }
                                return null;
                              },
                            ),
                            16.height,
                            Text("CIF Number",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your CIF Number here',
                                  prefixIcon: Icons.numbers_rounded),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.agentCif,
                              focus: cifFocusNode,
                              nextFocus: branchnameFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Mandatory!';
                                }
                                return null;
                              },
                            ),
                            16.height,
                            Text("Branch Name",
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                  hint: 'Enter your Branch Name here',
                                  prefixIcon: Icons.corporate_fare_rounded),
                              textFieldType: TextFieldType.EMAIL,
                              keyboardType: TextInputType.emailAddress,
                              controller: _controller.bankbranchController,
                              focus: branchnameFocusNode,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Mandatory!';
                                }
                                return null;
                              },
                              // nextFocus: passWordFocusNode,
                            ),
                          ],
                        ),
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
                      title: new Text('Security Questions',
                          style: boldTextStyle(size: 18, color: black)),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          16.height,
                          // Container(
                          //   //margin: EdgeInsets.only(top: 80),
                          //   alignment: Alignment.topCenter,
                          //   child: DropdownButton(
                          //     value: selectval,
                          //     onChanged: (value) {
                          //       setState(() {
                          //         selectval = value.toString();
                          //         //listitems.remove(selectval);
                          //       });
                          //     },
                          //     items: listitems.map((itemone) {
                          //       return DropdownMenuItem(
                          //           value: itemone,
                          //           child: Text(itemone,
                          //               style: boldTextStyle(size: 14)));
                          //     }).toList(),
                          //   ),
                          // ).paddingOnly(right: 16),
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
                            controller:
                                _controller.securityQuestionOneController,
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
                            controller:
                                _controller.securityQuestionTwoController,
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
                            controller:
                                _controller.securityQuestionThreeController,
                            focus: securityQuestionThreeFocusNode,
                            nextFocus: passWordFocusNode,
                          ),
                          30.height,
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
                //RegistrationApi(),
                //AgentOnboardingApi(),
                ElevatedButton(
                    onPressed: () async {
                      await uploadImage();
                    },
                    child: Text("Send Request")),
      
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
            SizedBox(height: 16),
          ],
        ),
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
    if (_bankDetailsformKey.currentState!.validate()) {}
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

_OnDepositDone(BuildContext context, TextEditingController controller) {
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
          'Agent: $controller Registred Successfully. Waiting For Admin Approval',
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

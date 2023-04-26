import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/utils/WAColors.dart';
import 'package:mobile_banking/utils/WADataGenerator.dart';
import 'package:mobile_banking/utils/WAWidgets.dart';

import '../component/AGAppEditProfileDailog.dart';
import '../component/WAAccoutProfileUpdatedailogComponent.dart';

import '../component/WAPickProfilePic.dart';
import '../main.dart';
import '../model/cardDetailsModel.dart';
import 'WAAddCreditionalScreen.dart';


class AGAppAgentEditProfileScreen extends StatefulWidget {
  // final CreditCardModel data;
  // const AGAppAgentEditProfileScreen({

  //   Key? key,
  //   required this.data,
  //   this.isEditProfile
    
  // })  : assert(data != null),
  //       super(key: key);
  static String tag = '/WAEditProfileScreen';
  //final isEditProfile;

  // WAEditProfileScreen({this.isEditProfile});

  @override
  AGAppAgentEditProfileScreenState createState() => AGAppAgentEditProfileScreenState(/*data: data*/);
}

class AGAppAgentEditProfileScreenState extends State<AGAppAgentEditProfileScreen> {
  // AGAppAgentEditProfileScreenState({
  //   required this.data,
  // }) : assert(data != null);
  // final CreditCardModel data;
  var fullNameController = TextEditingController();
  var contactNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController agnetIdController = TextEditingController();
  TextEditingController cifNumController = TextEditingController();
  //TextEditingController phoneNumController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode firstnameFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumFocusNode = FocusNode();
  FocusNode agnetIdFocusNode = FocusNode();
  FocusNode cifNumFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
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
        body: Container(
          height: context.height(),
          width: context.width(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/mobile_banking/wa_bg.jpg'),
                  fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                padding:
                    EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                width: context.width(),
                height: context.height(),
                decoration: boxDecorationWithShadow(
                    backgroundColor: context.cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Information',
                          style: boldTextStyle(size: 18)),
                      16.height,
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User Name', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your User Name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: userNameController,
                              focus: userNameFocusNode,
                            ),
                            16.height,
                            Text('First Name', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your First Name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: firstnameController,
                              focus: firstnameFocusNode,
                            ),
                            16.height,
                            Text('Last Name', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your Last Name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: lastnameController,
                              focus: lastnameFocusNode,
                            ),
                            16.height,
                            Text('Email', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your Email here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: emailController,
                              focus: emailFocusNode,
                            ),
                            16.height,
                            Text('Phone Number', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your Phone Number here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: phoneNumController,
                              focus: phoneNumFocusNode,
                            ),
                            16.height,
                            Text('Agent ID', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your Agent ID here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: agnetIdController,
                              focus: fullNameFocusNode,
                            ),
                            16.height,
                            Text('CIF Number', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your CIF Number here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: cifNumController,
                              focus: cifNumFocusNode,
                            ),
                            
                            16.height,
                            Text('Contact Number',
                                style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your contact number here',
                              ),
                              textFieldType: TextFieldType.PHONE,
                              keyboardType: TextInputType.phone,
                              controller: contactNumberController,
                              focus: contactNumberFocusNode,
                            ),
                            16.height,
                            Text('Date of birth',
                                style: boldTextStyle(size: 14)),
                            8.height,
                            Row(
                              children: [
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: waInputDecoration(hint: "Date"),
                                  items: List.generate(31, (index) {
                                    return DropdownMenuItem(
                                        child: Text('${index + 1}',
                                            style: secondaryTextStyle()),
                                        value: index + 1);
                                  }),
                                  onChanged: (value) {},
                                ).expand(),
                                16.width,
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: waInputDecoration(hint: "Month"),
                                  items: waMonthList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!,
                                          style: secondaryTextStyle()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    //
                                  },
                                ).expand(),
                                16.width,
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: waInputDecoration(hint: "Year"),
                                  items: waYearList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!,
                                          style: secondaryTextStyle()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    //
                                  },
                                ).expand(),
                              ],
                            ),
                            16.height,
                            Text('Gender', style: boldTextStyle()),
                            8.height,
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration:
                                  waInputDecoration(hint: "Select your gender"),
                              items: <String>['Female', 'Male']
                                  .map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                      Text(value, style: secondaryTextStyle()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                //
                              },
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      AppButton(
                        color: WAPrimaryColor,
                        width: context.width(),
                        child: Text('Done',
                            style: boldTextStyle(color: Colors.white)),
                        onTap: () {
                          
                          
                          showInDialog(context, builder: (context) {
                      return AGAppEditProfileDialog(/*data: data,*/);
                    });
                        },
                      ).cornerRadiusWithClipRRect(30).paddingOnly(
                          left: context.width() * 0.1,
                          right: context.width() * 0.1),
                    ],
                  ),
                ),
              ),
              PickProfilePicWidget(),
            ],
          ).paddingTop(60),
        ),
      ),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/Toast.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  bool buttonLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            width: _screenWidth,
            height: _screenHeight,
            color: AppThemeColor.backGroundColor,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('images/inAppIcon.png'),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Your ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppThemeColor.darkBlueColor,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppThemeColor.pureWhiteColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: userNameController,
                                  decoration: const InputDecoration(
                                      hintText: 'username'),
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'User name is missing',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppThemeColor.pureWhiteColor,
                                ),
                                child: TextFormField(
                                  controller: codeController,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      const InputDecoration(hintText: '+61'),
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'Country code!',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppThemeColor.pureWhiteColor,
                                ),
                                child: TextFormField(
                                  controller: numberController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      hintText: '413525565'),
                                  validator: (value) => value!.length > 1
                                      ? null
                                      : 'Phone number is missing',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: AppThemeColor.pureBlackColor,
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppThemeColor.pureWhiteColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.lock,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
                                      hintText: 'Password'),
                                  validator: (value) => value!.length > 7
                                      ? null
                                      : 'Password length must be 8 digits',
                                ),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                color: AppThemeColor.darkBlueColor,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => _signUpCalled(),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppThemeColor.darkBlueColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Signup',
                                style: TextStyle(
                                  color: AppThemeColor.pureWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Already have an Account?',
                              style: TextStyle(
                                color: AppThemeColor.pureBlackColor,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(),
                  ],
                ),
              ),
            )),
        buttonLoading
            ? AppConstents().loaderView(
                message: 'Please wait!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
              )
            : const SizedBox(),
      ],
    );
  }

  Future<void> _signUpCalled() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        buttonLoading = true;
      });
      String phoneNumber = '${codeController.text}${numberController.text}';
      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          print('verification is done');
          // Sign the user in (or link) with the auto-generated credential
          // await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            setState(() {
              buttonLoading = false;
            });
            ShowToast().showNormalToast(msg: 'invalid OTP!');
            print('The provided phone number is not valid.');
          }

          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          print('code sent is done');
          setState(() {
            buttonLoading = false;
          });
          RouterClass().otpScreeRoute(
            context: context,
            phoneNumber: phoneNumber,
            createAccount: true,
            userName: userNameController.text,
            password: passwordController.text,
            verificationId: verificationId,
          );
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }
}

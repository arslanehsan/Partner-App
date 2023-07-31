import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Firebase/FirebaseDatabaseHelper.dart';
import 'package:partner/Utils/AppConstents.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/Toast.dart';
import 'package:partner/Utils/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool remindMe = false;
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
                    Center(child: Image.asset('images/inAppIcon.png')),
                    const Center(
                      child: Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: 41,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                  maxLength: 4,
                                  controller: _codeController,
                                  decoration: const InputDecoration(
                                    hintText: '+61',
                                    counterText: '',
                                  ),
                                  keyboardType: TextInputType.phone,
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
                                  controller: _phoneNumberController,
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
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                      hintText: 'Password'),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => RouterClass()
                                  .forgetPasswordScreeRoute(context: context),
                              child: Container(
                                color: Colors.transparent,
                                child: const Text(
                                  'Forget Password?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppThemeColor.pureBlackColor,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                RadioMenuButton(
                                  groupValue: remindMe,
                                  value: true,
                                  style: ButtonStyle(
                                    iconSize: MaterialStateProperty.all(20),
                                  ),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        remindMe = value;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      color: AppThemeColor.pureBlackColor,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () => _signInCalled(),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppThemeColor.darkBlueColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'LOGIN',
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
                            onTap: () => RouterClass()
                                .createNewAccountScreeRoute(context: context),
                            child: const Text(
                              'Create a New Account?',
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

  Future<void> _signInCalled() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        buttonLoading = true;
      });
      String phoneNumber =
          '${_codeController.text}${_phoneNumberController.text}';

      await FirebaseDatabaseHelper()
          .getUsersByPhoneNumber(phoneNumber: phoneNumber)
          .then((phoneAuthUser) async {
        if (phoneAuthUser != null) {
          if (phoneAuthUser.password == _passwordController.text) {
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
                  print('The provided phone number is not valid.');
                  setState(() {
                    buttonLoading = false;
                  });
                }

                // Handle other errors
              },
              codeSent: (String verificationId, int? resendToken) async {
                setState(() {
                  buttonLoading = false;
                });
                print('code sent is done');
                RouterClass().otpScreeRoute(
                  context: context,
                  phoneNumber: phoneNumber,
                  password: _passwordController.text,
                  createAccount: false,
                  userName: '',
                  verificationId: verificationId,
                );
              },
              timeout: const Duration(seconds: 60),
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          } else {
            ShowToast().showNormalToast(msg: 'Invalid Password');
            setState(() {
              buttonLoading = false;
            });
          }
        } else {
          ShowToast().showNormalToast(msg: 'User doesn\'t exists');
          setState(() {
            buttonLoading = false;
          });
        }
      });
    }
  }
}

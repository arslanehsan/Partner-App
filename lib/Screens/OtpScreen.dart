import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:partner/Firebase/FirebaseDatabaseHelper.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Toast.dart';

import '../Objects/UserObject.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Router.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String password;
  final String verificationId;
  final String userName;
  final bool createAccount;
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.password,
    required this.userName,
    required this.createAccount,
    required this.verificationId,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;
  bool otpComplete = false;
  String? pinValue;
  bool buttonLoading = false;
  bool createAccountButtonLoading = false;
  bool loginButtonLoading = false;

  final CollectionReference<Map<String, dynamic>> usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/inAppIcon.png'),
                const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter the ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        'OTP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    OTPTextField(
                      length: 6,
                      width: _screenWidth,
                      fieldWidth: _screenWidth / 8.3,
                      style: const TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.box,
                      onCompleted: (pin) {
                        print("Completed: " + pin);
                        setState(() {
                          otpComplete = true;
                          pinValue = pin;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 35,
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
                            'Verify OTP',
                            style: TextStyle(
                              color: AppThemeColor.pureWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(),
              ],
            )),
        buttonLoading
            ? AppConstents().loaderView(
                message: 'Verifying Otp!',
                image: 'images/loading.png',
                width: _screenWidth,
                height: 110,
              )
            : createAccountButtonLoading
                ? AppConstents().loaderView(
                    message: 'Creating Account!',
                    image: 'images/loading.png',
                    width: _screenWidth,
                    height: 110,
                  )
                : loginButtonLoading
                    ? AppConstents().loaderView(
                        message: 'Loging in!',
                        image: 'images/loading.png',
                        width: _screenWidth,
                        height: 110,
                      )
                    : const SizedBox()
      ],
    );
  }

  //Called when user create new account.
  Future<void> _signUpCalled() async {
    // if (pinValue != null) {
    // Create a PhoneAuthCredential with the code

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: pinValue!);
    setState(() {
      buttonLoading = true;
    });
    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      if (value.user != null) {
        if (widget.createAccount) {
          UserObject userData = UserObject(
            uid: value.user!.uid,
            userName: widget.userName,
            password: widget.password,
            phoneNumber: widget.phoneNumber,
          );
          setState(() {
            buttonLoading = false;
            createAccountButtonLoading = true;
          });
          addNewUserToFirebase(user: userData);
        } else {
          loginUserToFirebase();
          setState(() {
            buttonLoading = false;
            loginButtonLoading = true;
          });
        }
      } else {
        setState(() {
          buttonLoading = false;
        });
        ShowToast().showNormalToast(msg: 'Something is wrong!');
      }
    }).onError((error, stackTrace) {
      print(error);
      setState(() {
        buttonLoading = false;
      });
    });
    // }
  }

//Called when user create new account.
  Future<void> addNewUserToFirebase({required UserObject user}) async {
    try {
      DatabaseReference dbf = FirebaseDatabase.instance.ref();
      await dbf
          .child('Users')
          .child(user.uid)
          .set(
            user.toJson(),
          )
          .then((value) {
        setState(() {
          createAccountButtonLoading = false;
          RouterClass().dashBoardScreeRoute(context: context);
        });

        // Navigator.pop(context);
      });
      // await usersCollectionReference.add(data);
      print('Data added to Firestore successfully');
    } catch (error) {
      setState(() {
        createAccountButtonLoading = false;
      });
      ShowToast().showNormalToast(msg: 'Something Wrong!');
      print('Error adding data to Firestore: $error');
    }
  }

  //Called when user only login.
  Future<void> loginUserToFirebase() async {
    try {
      setState(() {
        loginButtonLoading = true;
      });
      await FirebaseDatabaseHelper().getUsers().then((currentUser) {
        if (currentUser != null) {
          if (currentUser.password == widget.password) {
            setState(() {
              loginButtonLoading = false;
              RouterClass().dashBoardScreeRoute(context: context);
            });
          } else {
            setState(() {
              loginButtonLoading = false;
            });
            ShowToast().showNormalToast(msg: 'Password is incorrect');
            RouterClass().loginScreeRoute(context: context);
          }
        }
      });
      print('Data added to Firestore successfully');
    } catch (error) {
      setState(() {
        loginButtonLoading = false;
      });
      print('Error adding data to Firestore: $error');
    }
  }
}

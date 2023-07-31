import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/dimensions.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
        width: _screenWidth,
        height: _screenHeight,
        color: AppThemeColor.backGroundColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/inAppIcon.png'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forget',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: 30,
                  ),
                ),
                Text(
                  'Password',
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
                          decoration: const InputDecoration(hintText: '+61'),
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
                          decoration:
                              const InputDecoration(hintText: '413525565'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: InkWell(
                    // onTap: () => RouterClass().otpScreeRoute(context: context),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppThemeColor.darkBlueColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Send OTP',
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
        ));
  }
}

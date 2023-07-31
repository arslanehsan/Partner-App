import 'package:flutter/material.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

class AfterQuestionsScreen extends StatefulWidget {
  const AfterQuestionsScreen({super.key});

  @override
  State<AfterQuestionsScreen> createState() => _AfterQuestionsScreenState();
}

class _AfterQuestionsScreenState extends State<AfterQuestionsScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        children: [
          AppConstents().topBarViewWithBack(context: context),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Image.asset('images/robot.png'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'AI Calculating Your Result',
                style: TextStyle(
                  color: AppThemeColor.darkBlueColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Container(
                      width: _screenWidth / 2.5,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppThemeColor.darkBlueColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Proceed to result',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: _screenWidth / 2.5,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppThemeColor.pureWhiteColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 0.4,
                          color: AppThemeColor.grayColor,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

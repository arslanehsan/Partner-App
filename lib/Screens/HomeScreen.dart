import 'package:flutter/material.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          AppConstents().topBarView(context: context),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Column(
                    children: [
                      Text(
                        'Partner Connected',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'User Name',
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Column(
                    children: [
                      Text(
                        'No of Quiz Finished',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColor.pureWhiteColor,
              borderRadius: BorderRadius.circular(7),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Generate Statements',
                    style: TextStyle(
                      color: AppThemeColor.pureBlackColor,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppThemeColor.darkBlueColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: InkWell(
              onTap: () => RouterClass().connectScreenRoute(context: context),
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppThemeColor.grayColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Connect With Partner',
                  style: TextStyle(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: InkWell(
              onTap: () =>
                  RouterClass().choseCategoryScreenRoute(context: context),
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppThemeColor.darkBlueColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

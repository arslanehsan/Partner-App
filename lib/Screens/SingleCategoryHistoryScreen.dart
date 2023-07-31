import 'package:flutter/material.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

class SingleCategoryHistoryScreen extends StatefulWidget {
  const SingleCategoryHistoryScreen({super.key});

  @override
  State<SingleCategoryHistoryScreen> createState() =>
      _SingleCategoryHistoryScreenState();
}

class _SingleCategoryHistoryScreenState
    extends State<SingleCategoryHistoryScreen> {
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

  bool first = true;

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
            height: 10,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: first
                            ? AppThemeColor.darkBlueColor
                            : AppThemeColor.pureWhiteColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Correct Answers',
                        style: TextStyle(
                          color: first
                              ? AppThemeColor.pureWhiteColor
                              : AppThemeColor.dullFontColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: !first
                              ? AppThemeColor.darkBlueColor
                              : AppThemeColor.pureWhiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          border: Border.all(
                            color: AppThemeColor.dullFontColor,
                            width: 1,
                          )),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Mistake Answers',
                        style: TextStyle(
                          color: !first
                              ? AppThemeColor.pureWhiteColor
                              : AppThemeColor.dullFontColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/singleCatImage.png',
                height: 100,
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration:
                  const BoxDecoration(color: AppThemeColor.pureWhiteColor),
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (contextOfList, index) {
                  return _singleNotification(
                    question:
                        '${index + 1}. What is the favourite color of user1 ?',
                    answer:
                        'Lorem ipsum dolor sit amet, consectetuer\nadipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleNotification(
      {required String question, required String answer}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              color: AppThemeColor.darkBlueColor,
            ),
          ),
          Text(
            answer,
            style: const TextStyle(
              color: AppThemeColor.pureBlackColor,
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            thickness: 2,
            color: AppThemeColor.pureBlackColor,
          )
        ],
      ),
    );
  }
}

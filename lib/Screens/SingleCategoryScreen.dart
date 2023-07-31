import 'package:flutter/material.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

class SingleCategoryScreen extends StatefulWidget {
  final String selectedCategory;
  const SingleCategoryScreen({super.key, required this.selectedCategory});

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  int totalQuestions = 10;
  int currentQuestion = 1;

  String? selectedCategory;
  @override
  void initState() {
    selectedCategory = widget.selectedCategory;
    super.initState();
  }

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
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: _screenWidth / 2.4,
                decoration: BoxDecoration(
                  color: AppThemeColor.pureWhiteColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  children: [
                    Image.asset(
                      'images/connectedIcon.png',
                      width: 22,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Connected',
                      style: TextStyle(
                        color: AppThemeColor.darkBlueColor,
                        fontWeight: FontWeight.w400,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: _screenWidth / 2.4,
                decoration: BoxDecoration(
                  color: AppThemeColor.pureWhiteColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: Row(
                  children: [
                    Image.asset(
                      'images/categoriesIcon.png',
                      width: 22,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    DropdownButton<String>(
                      padding: const EdgeInsets.all(0),
                      value: selectedCategory,
                      items: AppConstents().categoriesList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value.replaceAll('\n', ' ')),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    )

                    // Text(
                    //   widget.selectedCategory,
                    //   style: const TextStyle(
                    //     color: AppThemeColor.darkBlueColor,
                    //     fontWeight: FontWeight.w400,
                    //     fontSize: Dimensions.fontSizeDefault,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColor.darkBlueColor,
              borderRadius: BorderRadius.circular(7),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppThemeColor.pureWhiteColor,
                      size: 18,
                    ),
                    Text(
                      ' 00:00',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppThemeColor.pureWhiteColor,
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ],
                ),
                Text(
                  '< $currentQuestion/$totalQuestions',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppThemeColor.pureWhiteColor,
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColor.pureWhiteColor,
              borderRadius: BorderRadius.circular(7),
            ),
            width: _screenWidth,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: const Text(
              'What is the favourite color of user 1?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppThemeColor.darkBlueColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppThemeColor.pureWhiteColor,
              ),
              child: TextFormField(
                maxLines: 7,
                decoration:
                    InputDecoration(hintText: 'Write down your Answer Here.'),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (currentQuestion != 1) {
                      currentQuestion--;
                    }
                  });
                },
                child: Container(
                  width: _screenWidth / 2.5,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColor.darkBlueColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: AppThemeColor.pureWhiteColor,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (currentQuestion != totalQuestions) {
                      currentQuestion++;
                    }
                  });
                },
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
                    'Next',
                    style: TextStyle(
                      color: AppThemeColor.pureBlackColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () =>
                    RouterClass().afterQuestionsScreenRoute(context: context),
                child: Container(
                  width: _screenWidth / 2.5,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppThemeColor.darkBlueColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Submit',
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
                    'Quit',
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
    );
  }
}

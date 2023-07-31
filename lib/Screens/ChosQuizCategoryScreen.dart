import 'package:flutter/material.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';
import '../Utils/Router.dart';

class ChosQuizCategoryScreen extends StatefulWidget {
  const ChosQuizCategoryScreen({super.key});

  @override
  State<ChosQuizCategoryScreen> createState() => _ChosQuizCategoryScreenState();
}

class _ChosQuizCategoryScreenState extends State<ChosQuizCategoryScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  String selectedCategory = 'Cat\n1';

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
          const Text(
            'Chose your category',
            style: TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                color: AppThemeColor.pureWhiteColor,
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
              child: Row(
                children: [
                  Image.asset(
                    'images/categoriesIcon.png',
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: AppThemeColor.darkBlueColor,
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          _categoriesView(),
        ],
      ),
    );
  }

  Widget _categoriesView() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: AppConstents()
          .categoriesList
          .map(
            (singleCategory) => GestureDetector(
              onTap: () => RouterClass().singleCategoryScreenRoute(
                  context: context, selectedCategory: selectedCategory),
              child: Container(
                width: _screenWidth / 4,
                height: _screenWidth / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(selectedCategory == singleCategory
                        ? 'images/blueCategoryBackground.png'
                        : 'images/grayCategoryBackground.png'),
                  ),
                ),
                child: Center(
                  child: Text(
                    singleCategory,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppThemeColor.pureBlackColor,
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

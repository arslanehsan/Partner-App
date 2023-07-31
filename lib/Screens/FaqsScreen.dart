import 'package:flutter/material.dart';
import 'package:partner/Utils/AppConstents.dart';

import '../Utils/Colors.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
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
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (contextOfList, index) {
                return _singleQuestion(question: 'Question No ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleQuestion({required String question}) {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(7),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                color: AppThemeColor.darkBlueColor,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppThemeColor.darkBlueColor,
          ),
        ],
      ),
    );
  }
}

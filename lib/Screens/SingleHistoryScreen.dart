import 'package:flutter/material.dart';
import 'package:partner/Utils/AppConstents.dart';
import 'package:partner/Utils/Router.dart';

import '../Utils/Colors.dart';

class SingleHistoryScreen extends StatefulWidget {
  const SingleHistoryScreen({super.key});

  @override
  State<SingleHistoryScreen> createState() => _SingleHistoryScreenState();
}

class _SingleHistoryScreenState extends State<SingleHistoryScreen> {
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('images/singleHistoryView.png'),
                Column(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => RouterClass()
                            .singleCategoryHistoryScreenRoute(context: context),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

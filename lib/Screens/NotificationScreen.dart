import 'package:flutter/material.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
              itemCount: 3,
              itemBuilder: (contextOfList, index) {
                return _singleNotification(
                    question: 'Notification No ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleNotification({required String question}) {
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
          Image.asset(
            'images/notificationIcon.png',
            width: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              question,
              style: const TextStyle(
                color: AppThemeColor.pureBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBarView() {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppThemeColor.darkBlueColor,
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        const Icon(
          Icons.notifications_active_outlined,
          color: AppThemeColor.dullFontColor,
        ),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.menu,
          color: AppThemeColor.dullFontColor,
        ),
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/Utils/Router.dart';

import 'dimensions.dart';

class AppConstents {
  static const String appName = 'Partner';
  static const String appVersion = '1.0.0';

  List<String> categoriesList = [
    'Cat\n1',
    'Cat\n2',
    'Cat\n3',
    'Cat\n4',
    'Cat\n5',
  ];

  Widget loaderView({
    required String message,
    required String image,
    required double height,
    required double width,
  }) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            message,
            style: TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontSize: Dimensions.fontSizeExtraLarge,
              fontWeight: FontWeight.w400,
            ),
          ),
          Image.asset(
            image,
            width: 40,
          ),
        ],
      ),
    );
  }

  Widget topBarView({required BuildContext context}) {
    return Row(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        InkWell(
          onTap: () => RouterClass().notificationsScreenRoute(context: context),
          child: const Icon(
            Icons.notifications_active_outlined,
            color: AppThemeColor.dullFontColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        popMenu(context: context),
      ],
    );
  }

  Widget topBarViewWithBack({required BuildContext context}) {
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
        InkWell(
          onTap: () => RouterClass().notificationsScreenRoute(context: context),
          child: const Icon(
            Icons.notifications_active_outlined,
            color: AppThemeColor.dullFontColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        popMenu(context: context),
      ],
    );
  }

  Widget popMenu({required BuildContext context}) {
    return PopupMenuButton<String>(
      initialValue: '',
      // Callback that sets the selected popup menu item.
      onSelected: (item) {
        if (item == 'Profile') {
          RouterClass().editProfileRoute(context: context);
        } else if (item == 'FAQ\'s') {
          RouterClass().faqsScreenRoute(context: context);
        } else if (item == 'help Center') {
          RouterClass().helpCenterScreenRoute(context: context);
        } else if (item == 'Logout') {
          FirebaseAuth.instance.signOut().then(
                (value) => RouterClass().loginScreeRoute(context: context),
              );
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        _singleMenuItem(
          iconData: Icons.person,
          title: 'Profile',
        ),
        _singleMenuItem(
          iconData: Icons.help_outline,
          title: 'FAQ\'s',
        ),
        _singleMenuItem(
          iconData: Icons.person_pin_outlined,
          title: 'help Center',
        ),
        _singleMenuItem(
          iconData: Icons.logout,
          title: 'Logout',
        ),
      ],
    );
  }

  PopupMenuEntry<String> _singleMenuItem({
    required IconData iconData,
    required String title,
  }) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 7,
          ),
          Text(title),
        ],
      ),
    );
  }
}

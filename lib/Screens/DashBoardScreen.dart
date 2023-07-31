import 'package:flutter/material.dart';
import 'package:partner/Screens/AccountScreen.dart';
import 'package:partner/Screens/HistoryScreen.dart';
import 'package:partner/Screens/HomeScreen.dart';
import 'package:partner/Utils/Colors.dart';

import '../Firebase/FirebaseDatabaseHelper.dart';
import '../Objects/UserObject.dart';
import 'ConnectScreen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  String selectedTab = 'Home';

  UserObject? userData;

  Future<void> getUserData() async {
    await FirebaseDatabaseHelper().getUsers().then((user) {
      if (user != null) {
        setState(() {
          userData = user;
        });
      }
    });
  }

  Future<void> getFullUserData() async {
    await FirebaseDatabaseHelper().getFullUsers().then((user) {
      if (user != null) {
        setState(() {
          userData = UserObject(
              uid: user.uid!,
              userName: user.userName!,
              password: '',
              phoneNumber: user.phoneNumber!);
        });
      } else {
        getUserData();
      }
    });
  }

  @override
  void initState() {
    getFullUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyView(),
    );
  }

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        children: [
          Expanded(
            child: selectedTab == 'Home'
                ? const HomeScreen()
                : selectedTab == 'Connect'
                    ? const ConnectScreen()
                    : selectedTab == 'History'
                        ? const HistoryScreen()
                        : selectedTab == 'Account'
                            ? const AccountScreen()
                            : const SizedBox(),
          ),
          _bottomBarView(),
        ],
      ),
    );
  }

  Widget _bottomBarView() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _singleBottomButton(iconData: Icons.home_filled, title: 'Home'),
          const VerticalDivider(
            width: 1,
            color: AppThemeColor.pureBlackColor,
            indent: 10,
            endIndent: 10,
          ),
          _singleBottomButton(iconData: Icons.favorite, title: 'Connect'),
          const VerticalDivider(
            width: 1,
            color: AppThemeColor.pureBlackColor,
            indent: 10,
            endIndent: 10,
          ),
          _singleBottomButton(iconData: Icons.history, title: 'History'),
          const VerticalDivider(
            width: 1,
            color: AppThemeColor.pureBlackColor,
            indent: 10,
            endIndent: 10,
          ),
          _singleBottomButton(iconData: Icons.person, title: 'Account'),
        ],
      ),
    );
  }

  Widget _singleBottomButton(
      {required IconData iconData, required String title}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTab = title;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 22,
              color: selectedTab == title
                  ? AppThemeColor.darkBlueColor
                  : AppThemeColor.dullFontColor,
            ),
            Text(
              title,
              style: TextStyle(
                  color: selectedTab == title
                      ? AppThemeColor.darkBlueColor
                      : AppThemeColor.dullFontColor),
            )
          ],
        ),
      ),
    );
  }
}

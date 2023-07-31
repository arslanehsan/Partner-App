import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/AppConstents.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Firebase/FirebaseDatabaseHelper.dart';
import '../Objects/UserObject.dart';
import '../Utils/Colors.dart';
import '../Utils/Router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({
    super.key,
  });

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image.asset(
                        'images/profile.png',
                        width: _screenWidth / 3,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppThemeColor.pureBlackColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: AppThemeColor.pureWhiteColor,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    userData != null ? userData!.userName : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                  Text(
                    userData != null ? userData!.phoneNumber : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: AppThemeColor.dullFontColor,
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async => await RouterClass()
                            .editProfileRoute(context: context)
                            .then((value) {
                          getFullUserData();
                        }),
                        child: _singleTabView(
                          iconData: Icons.person,
                          title: 'Edit Profile',
                        ),
                      ),
                      GestureDetector(
                        child: _singleTabView(
                          iconData: Icons.payments,
                          title: 'Payment',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => RouterClass()
                            .helpCenterScreenRoute(context: context),
                        child: _singleTabView(
                          iconData: Icons.person_pin_outlined,
                          title: 'help Center',
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            RouterClass().faqsScreenRoute(context: context),
                        child: _singleTabView(
                          iconData: Icons.help_outline,
                          title: 'FAQ\'s',
                        ),
                      ),
                      GestureDetector(
                        onTap: () => RouterClass()
                            .inviteFriendScreenRoute(context: context),
                        child: _singleTabView(
                          iconData: Icons.person_pin_outlined,
                          title: 'Invite Friends',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then(
                                (value) => RouterClass()
                                    .loginScreeRoute(context: context),
                              );
                        },
                        child: _singleTabView(
                          iconData: Icons.logout,
                          title: 'Logout',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleTabView({
    required IconData iconData,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                size: 22,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: AppThemeColor.pureBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              )
            ],
          ),
          const Icon(
            Icons.keyboard_arrow_right_rounded,
            color: AppThemeColor.pureBlackColor,
            size: 28,
          )
        ],
      ),
    );
  }
}

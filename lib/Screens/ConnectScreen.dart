import 'package:flutter/material.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Firebase/FirebaseDatabaseHelper.dart';
import '../Objects/UserObject.dart';
import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  UserObject? searchUser;

  Widget _bodyView() {
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppConstents().topBarView(context: context),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Enter the Phone Number',
            style: TextStyle(
              color: AppThemeColor.pureBlackColor,
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  child: TextFormField(
                    controller: _codeController,
                    decoration: const InputDecoration(hintText: '+61'),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(hintText: '413525565'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => getUserSearch(),
            child: Container(
              width: _screenWidth,
              decoration: BoxDecoration(
                color: AppThemeColor.darkBlueColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 9),
              alignment: Alignment.center,
              child: const Text(
                'Search for partner',
                style: TextStyle(
                  color: AppThemeColor.pureWhiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          if (searchUser != null)
            _singleTabView(
                user: searchUser!.uid.isNotEmpty, userData: searchUser!),
          // _singleTabView(user: true),
        ],
      ),
    );
  }

  Widget _singleTabView({required bool user, required UserObject userData}) {
    return Container(
      width: _screenWidth,
      decoration: BoxDecoration(
        color: AppThemeColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          Image.asset(
            'images/profile.png',
            width: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.userName,
                  style: const TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  userData.phoneNumber,
                  style: const TextStyle(
                    color: AppThemeColor.dullFontColor,
                    fontSize: Dimensions.fontSizeSmall,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          user
              ? Container(
                  decoration: BoxDecoration(
                    color: AppThemeColor.darkBlueColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: const Text(
                    'Send invitation',
                    style: TextStyle(
                      color: AppThemeColor.pureWhiteColor,
                      fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemeColor.purpleColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: const Text(
                        'Send invitation',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppThemeColor.darkBlueColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: const Text(
                        'invite friend to app',
                        style: TextStyle(
                          color: AppThemeColor.pureWhiteColor,
                          fontSize: Dimensions.fontSizeExtraSmall,
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Future<void> getUserSearch() async {
    String phoneNumber =
        '${_codeController.text}${_phoneNumberController.text}';

    await FirebaseDatabaseHelper()
        .getUsersByPhoneNumber(phoneNumber: phoneNumber)
        .then((userData) {
      if (userData != null) {
        setState(() {
          searchUser = userData;
        });
      } else {
        setState(() {
          searchUser = UserObject(
              uid: '',
              userName: 'User Name',
              password: '',
              phoneNumber: phoneNumber);
        });
      }
    });
  }
}

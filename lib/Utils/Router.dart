import 'package:flutter/material.dart';
import 'package:partner/Screens/AfterQuestionsScreen.dart';
import 'package:partner/Screens/ChosQuizCategoryScreen.dart';
import 'package:partner/Screens/ConnectScreen.dart';
import 'package:partner/Screens/CreateNewAccount.dart';
import 'package:partner/Screens/DashBoardScreen.dart';
import 'package:partner/Screens/EditProfileScreen.dart';
import 'package:partner/Screens/FaqsScreen.dart';
import 'package:partner/Screens/ForgetPasswordScreen.dart';
import 'package:partner/Screens/HelpCenterScreen.dart';
import 'package:partner/Screens/InvieteFriendScreen.dart';
import 'package:partner/Screens/LoginScreen.dart';
import 'package:partner/Screens/NotificationScreen.dart';
import 'package:partner/Screens/OtpScreen.dart';
import 'package:partner/Screens/SingleCategoryHistoryScreen.dart';
import 'package:partner/Screens/SingleHistoryScreen.dart';

import '../Screens/SingleCategoryScreen.dart';

class RouterClass {
  loginScreeRoute({required BuildContext context}) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false);

  createNewAccountScreeRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateNewAccount(),
        ),
      );
  forgetPasswordScreeRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        ),
      );
  otpScreeRoute({
    required BuildContext context,
    required String phoneNumber,
    required String userName,
    required String password,
    required bool createAccount,
    required String verificationId,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            phoneNumber: phoneNumber,
            password: password,
            createAccount: createAccount,
            userName: userName,
            verificationId: verificationId,
          ),
        ),
      );

  dashBoardScreeRoute({required BuildContext context}) =>
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashBoardScreen(),
          ),
          (route) => false);

  singleHistoryScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SingleHistoryScreen(),
        ),
      );

  singleCategoryHistoryScreenRoute({required BuildContext context}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SingleCategoryHistoryScreen(),
        ),
      );

  notificationsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ),
      );

  afterQuestionsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AfterQuestionsScreen(),
        ),
      );

  editProfileRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        ),
      );

  connectScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ConnectScreen(),
        ),
      );

  faqsScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FaqsScreen(),
        ),
      );

  helpCenterScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HelpCenterScreen(),
        ),
      );

  inviteFriendScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InviteFriendScreen(),
        ),
      );

  choseCategoryScreenRoute({required BuildContext context}) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChosQuizCategoryScreen(),
        ),
      );

  singleCategoryScreenRoute(
          {required BuildContext context, required String selectedCategory}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleCategoryScreen(
            selectedCategory: selectedCategory,
          ),
        ),
      );
}

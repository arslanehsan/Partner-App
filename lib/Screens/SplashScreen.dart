import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/Router.dart';

import '../Utils/Colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override
  void initState() {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      firebaseUser != null
          ? RouterClass().dashBoardScreeRoute(context: context)
          : RouterClass().loginScreeRoute(context: context);
    });
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
      width: _screenWidth,
      height: _screenHeight,
      decoration: const BoxDecoration(
        color: AppThemeColor.darkBlueColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'images/splashBackground.png',
            fit: BoxFit.cover,
          ),
          Image.asset('images/inAppIcon.png'),
        ],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partner/Screens/SplashScreen.dart';
import 'package:partner/Utils/Colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Partner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppThemeColor.darkBlueColor,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

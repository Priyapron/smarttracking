import 'package:flutter/material.dart';
import 'package:smarttracking/HealthDataPage.dart';
import 'package:smarttracking/mainmenu.dart';
import 'package:smarttracking/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      //home: HealthDataPage(),
      routes: {
        '/mainmenu': (context) => MainMenu(),
      },
    );
  }
}

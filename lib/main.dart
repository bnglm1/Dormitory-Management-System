import 'package:basic_started/screens/attendance_sheet.dart';
import 'package:basic_started/screens/home.dart';
import 'package:basic_started/beginning/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:basic_started/beginning/get_started.dart';
import 'screens/menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "First App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

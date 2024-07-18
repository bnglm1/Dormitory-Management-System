import 'package:basic_started/beginning/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1200), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => GetStarted(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.yellow, Colors.blue])),
          child: Center(
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 120.0,
              duration: Duration(milliseconds: 1200),
            ),
          )),
    );
  }
}

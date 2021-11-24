import 'dart:async';

import 'package:archub/constant.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).popAndPushNamed(kLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff8C191C),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset('assets/icons/logo.png'),
          ),
        ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/screens/home_page.dart';
import 'package:weather/ui_helper.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/4308/4308620.png"),
                  fit: BoxFit.cover),
            ),
          ),
          mHidght(),
          Center(
              child: Text(
            "wather App",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task1/views/Home/home.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  FirebaseAuth auth = FirebaseAuth.instance;
  login() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    login();
    Timer(
        const Duration(seconds: 4),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Image.asset(
              "assets/Icons/BG.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/Icons/icon1.png',
              width: 500,
              height: 500,
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rssfeed/screens/homepage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () { 
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        Image.asset("assets/logo.png"),
      ),
    );
  }
}
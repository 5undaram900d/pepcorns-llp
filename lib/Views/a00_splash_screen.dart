
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pepcorns_app/Views/Auth/a01_login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen(),),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red, Colors.white, Colors.green
            ],
          ),
        ),
        child: const Center(child: Text('Starting..', style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),),
      ),
    );
  }
}
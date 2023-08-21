// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../Services/LoginServices.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashServices launchScreen= SplashServices();
   bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    launchScreen.islogin(context);

  }

  Future <void> checkLoginStatus()async{
    Future.delayed(const Duration(seconds: 3));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.deepOrange[300],
          body: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('Assets/images/splash screen.png'),
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(child: CircularProgressIndicator())
                ],
              ),
            ),
          )),
    );
  }
}


// ignore_for_file: file_names

import 'dart:async';

import 'package:clear_creek_catering/Views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Auth/Signin_screen.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) {
      Timer(const Duration(seconds: 3), () {
        Get.to(() => const SignInScreen());
      });
    } else {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomeScreen())));
    }
  }
}
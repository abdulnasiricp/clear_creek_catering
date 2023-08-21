import 'package:clear_creek_catering/Auth/Signin_screen.dart';
import 'package:clear_creek_catering/Utils/Helper_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Get.offAll(() => const SignInScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Utils.appbarColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user?.email ?? 'Login as a Guest'),
            const Text('Home Screen'),
          ],
        ),
      ),
    );
  }
}

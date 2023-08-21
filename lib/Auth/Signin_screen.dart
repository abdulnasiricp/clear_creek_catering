// ignore_for_file: file_names sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names, file_names, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:clear_creek_catering/Views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Helper_class.dart';
import '../Utils/My_button.dart';
import 'Forgot_screen.dart';
import 'Signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final User=FirebaseAuth.instance.currentUser;
  final formKey = GlobalKey<FormState>();
  var isloading = false;

  void SigInUser() async {
    try {
      isloading = true;
      if (formKey.currentState!.validate()) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then(
              (Uid) => Utils().toastmassage('User Login Succesfully'),
            )
            .then((value) => Get.offAll(() => const HomeScreen()));
            setState(() {
              isloading=false;
            });

        emailController.clear();
        passwordController.clear();
      }
    } on FirebaseAuthException catch (e) {
      Utils().toastmassage('$e');
      setState(() {
        isloading=false;
      });
    }
  }

  void GuestSignIn() async {
    try {
      isloading = true;
      final data={
            'UserName':User?.displayName,
            'Email': User?.email,
          'CreatedAt':DateTime.now(),
          'userId':User?.uid

          };

      await FirebaseAuth.instance
          .signInAnonymously()
          .then(
            (value) => Utils().toastmassage('User Login as a Guest'),
          ).then((value) =>FirebaseFirestore.instance.collection("Users").doc(User?.uid).set(data))
          .then((value) => Get.offAll(() => const HomeScreen()));
          

      
    } on FirebaseAuthException catch (e) {
      Utils().toastmassage('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Utils.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign In'),
        centerTitle: true,
        backgroundColor: Utils.appbarColor,
        foregroundColor: Utils.appbarForgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                      height: 200,
                      child: Image.asset('Assets/images/splash screen.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'please enter valid email';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your password';
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    controller: passwordController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: const Icon(Icons.visibility),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Get.to(() => const ForgotScreen());
                        },
                        child: const Text('Forgot Password'),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      child: MyButton(
                          title: isloading ?  const CircularProgressIndicator():const Text('Sign In'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SigInUser();
                            }
                          },
                          
                          )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      // width: double.infinity,
                      child: MyButton(
                          title: const Text('SigIn is a Guest'),
                          onPressed: () {
                            GuestSignIn();
                          })),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account"),
                        TextButton(
                            onPressed: () {
                              Get.to(() => const SignUpScreen());
                            },
                            child: const Text('Sign Up')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

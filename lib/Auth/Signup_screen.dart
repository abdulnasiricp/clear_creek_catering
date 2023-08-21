// ignore_for_file: file_names, sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_print, avoid_unnecessary_containers, unused_local_variable

import 'package:clear_creek_catering/Views/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Helper_class.dart';
import '../Utils/My_button.dart';
import 'Signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  void CreateUser() async {
    try {
      if (formKey.currentState!.validate()) {
        final data = {
          'UserName': userNameController.text.trim(),
          'Email': emailController.text.trim(),
          'CreatedAt': DateTime.now(),
          'userId': user?.uid,
        };
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user?.uid)
            .set(data);

        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.toString(),
                password: passwordController.text.toString())
            .then((value) {
          Utils().toastmassage('New User created');
        }).then((value) {
          Get.offAll(() => const HomeScreen());
        });
      }
    } on FirebaseAuthException catch (e) {
      Utils().toastmassage('$e Error');
    }
  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign Up'),
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
                        return 'Please enter your User Name';
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.name,
                    controller: userNameController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                        hintText: 'User Name',
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
                        return 'Please enter your Password';
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
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: double.infinity,
                      child: MyButton(
                          title: const Text('Sign Up'),
                          onPressed: () {
                            CreateUser();
                          })),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account"),
                        TextButton(
                            onPressed: () {
                              Get.to(() => const SignInScreen());
                            },
                            child: const Text('Sign In')),
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

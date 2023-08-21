// ignore_for_file: file_names sized_box_for_whitespace, non_constant_identifier_names, avoid_types_as_parameter_names, file_names, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:clear_creek_catering/Auth/Signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/Helper_class.dart';
import '../Utils/My_button.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isloading = false;

  void ForgotEmail() async {
    try {
      isloading = true;
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
              email: emailController.text.trim(),
              )
          .then(
            (value) => Utils().toastmassage('Please check your Email '),
          )
          .then((value) => Get.to(() => const SignInScreen()));

      emailController.clear();
    }
      
    }on FirebaseAuthException catch (e) {
      Utils().toastmassage('$e');
      
    }
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
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
                  Container(
                      width: double.infinity,
                      child: MyButton(
                          title: const Text('Forgot Password'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ForgotEmail();
                            }
                          })),
                  const SizedBox(
                    height: 20,
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

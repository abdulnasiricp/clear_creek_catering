// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget title;
  final VoidCallback onPressed;
  const MyButton( {super.key, required this.title, required this.onPressed,});
  // const MyButton({super.key});

  @override
  Widget build(BuildContext context) {


    
    return ElevatedButton(

      
      onPressed: onPressed,
      style: ButtonStyle(
        
        foregroundColor: MaterialStateProperty.all(Colors.black),
          backgroundColor: MaterialStateProperty.all(Colors.deepOrange[300])),

      child: title,
      
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static Color? appbarColor = Colors.deepOrange[300];
  static Color? appbarForgroundColor = Colors.black;
  static Color? buttonColor = Colors.deepOrange[300];
  static Color? bgColor = Colors.orange[300];

  static TextStyle? headingtextStyle = const TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
  static TextStyle? normaltextStyle = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black);

      void toastmassage(String massage) {
    Fluttertoast.showToast(
        msg: massage,
        backgroundColor: Colors.green[400],
        fontSize: 16,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR);
  }
}

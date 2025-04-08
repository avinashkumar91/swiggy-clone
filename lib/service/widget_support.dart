import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle HeadlineTextFeildStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle SimpleTextFeildStyle() {
    return TextStyle(color: Colors.black, fontSize: 18);
  }

  static TextStyle whiteTextFeildStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle boldTextFeildStyle() {
    return TextStyle(
      color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold
    );
  }

  static TextStyle priceTextFeildStyle() {
    return TextStyle(
      color: Color.fromARGB(174, 0, 0, 0),fontSize: 24.0,fontWeight: FontWeight.bold
    );
  }

  static TextStyle boldwhiteTextFeildStyle() {
    return TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle signUpTextFeildStyle() {
    return TextStyle(
      color: Color.fromARGB(174, 0, 0, 0),fontSize: 20.0,fontWeight: FontWeight.bold
    );
  }
}
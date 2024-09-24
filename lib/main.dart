import 'package:flutter/material.dart';
import 'LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Register App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set the initial route to LoginPage
    );
  }
}

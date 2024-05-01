import 'package:flutter/material.dart';
import 'package:trust/screens/login_home.dart';
import 'utilities/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trust',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginHomePage(),
      routes: Routes.routes,
    );
  }
}

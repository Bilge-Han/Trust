import 'package:flutter/material.dart';

Widget header(String title, context) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    backgroundColor: Colors.black38.withOpacity(0.25),
    shadowColor: Colors.greenAccent.withAlpha(150),
  );
}

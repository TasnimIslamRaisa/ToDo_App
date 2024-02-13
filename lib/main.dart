import 'package:flutter/material.dart';
import 'package:to_do_app/screen/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App ',
      //theme: ThemeData.light(),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

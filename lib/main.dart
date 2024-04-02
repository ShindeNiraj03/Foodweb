import 'package:flutter/material.dart';
import 'index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(), // Set IndexPage as the home page
    );
  }
}

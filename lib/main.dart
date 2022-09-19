import 'package:flutter/material.dart';
import 'package:pathfinder/pages/launch_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathfinder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LaunchPage(),
    );
  }
}

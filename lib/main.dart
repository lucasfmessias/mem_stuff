import 'package:flutter/material.dart';
import 'package:mem_stuff/pages/home_page.dart';

import 'core/app_const.dart';
import 'core/app_theme.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

void main() {
  runApp(MyApp());
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: kAppTheme,
      home: HomePage(),
    );
  }
}

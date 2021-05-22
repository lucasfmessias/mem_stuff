import 'package:flutter/material.dart';
import 'package:mem_stuff/pages/home_page.dart';
import 'package:mem_stuff/services/service_locator.dart';

import 'core/app_const.dart';
import 'core/app_theme.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kAppTitle,
      theme: kAppTheme,
      home: HomePage(),
    );
  }
}

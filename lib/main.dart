import 'package:flutter/material.dart';
import 'package:flutter_first_project/HomeScreen.dart';
import 'package:flutter_first_project/PlayerInfoScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_first_project/AppTheme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/':(context) => HomeScreen(),
        '/playerinfo':(context) => PlayerInfoScreen()
      }
    );
  }
}


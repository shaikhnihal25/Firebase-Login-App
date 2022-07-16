import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:test_app/screens/loginScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //---------Initialize the Firebase----------//
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Text App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen());
  }
}

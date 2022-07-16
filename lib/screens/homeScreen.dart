import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test_app/screens/loginScreen.dart';
import 'package:test_app/services/user.dart';
import 'package:test_app/utils/iColors.dart';

class HomeScreen extends StatefulWidget {
  String? uid;
  HomeScreen({Key? key, this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.background,
      body: Center(
          child: Text(
        "Your user id is : " + widget.uid.toString(),
        style: TextStyle(color: IColors.offWhite),
      )),

      //---------Logout Button--------------//
      floatingActionButton: GestureDetector(
        onTap: () async {
          FirebaseAuth auth = FirebaseAuth.instance;
          await auth.signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => LoginScreen())));
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: IColors.icon,
          child: Center(
            child: Icon(Icons.logout),
          ),
        ),
      ),
    );
  }
}

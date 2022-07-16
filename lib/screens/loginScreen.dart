import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:test_app/screens/homeScreen.dart';

import 'package:test_app/utils/iColors.dart';
import 'package:test_app/widgets/inputTile.dart';

import 'signupScreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //------Controllers--------//
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? uid;

  @override
  Widget build(BuildContext context) {
    //------Device height and width------//
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //-----------Main----------//
    return Scaffold(
      backgroundColor: IColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //----------Logo or Title----------//
            Padding(
              padding: EdgeInsets.only(top: height / 8, left: width / 20),
              child: Text(
                "Hey,",
                style: TextStyle(
                    color: IColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 80, left: width / 20),
              child: Text(
                "Welcome Back",
                style: TextStyle(
                    color: IColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            //-----------Email------------//
            InputTile(
                top: 10,
                secured: false,
                controller: email,
                title: "Email",
                placeholder: "example@email.com",
                icon: Icon(
                  Icons.email,
                  color: IColors.icon,
                )),
            //-----------Password--------------//
            InputTile(
                top: 30,
                secured: true,
                controller: password,
                title: "Password",
                placeholder: "............",
                icon: Icon(
                  Icons.lock,
                  color: IColors.icon,
                )),
            //----------forgot password--------------//
            Padding(
              padding: EdgeInsets.only(top: height / 80, left: width / 15),
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(msg: "not availiable");
                },
                child: Text(
                  "forgot password?",
                  style: TextStyle(color: IColors.icon, fontSize: 12),
                ),
              ),
            ),
            //-------Button-----------//
            Padding(
              padding: EdgeInsets.only(top: height / 15, left: width / 20),
              child: GestureDetector(
                onTap: () {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    //-------if any text fields are empty this error will show up-----//
                    Fluttertoast.showToast(
                        backgroundColor: IColors.input,
                        msg: "Email and Password cannot be empty");
                  } else {
                    //---------if all text fields are submitted correctly then signin method will run-----//
                    signIn(email.text, password.text);
                  }
                },
                child: Container(
                  height: height / 18,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                      color: IColors.offWhite,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: IColors.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            //----------------------//

            //---------------Login With Google Button---------//
            Padding(
              padding: EdgeInsets.only(top: height / 15, left: width / 20),
              child: GestureDetector(
                onTap: () {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    Fluttertoast.showToast(
                        backgroundColor: IColors.input,
                        msg:
                            "Not added yet, Please login with your email and password");
                  }
                },
                child: Container(
                  height: height / 18,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "Google",
                      style: TextStyle(
                          color: IColors.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            //----------------------//

            //---------------Login With Facebook Button---------//
            Padding(
              padding: EdgeInsets.only(top: height / 30, left: width / 20),
              child: GestureDetector(
                onTap: () {
                  if (email.text.isEmpty || password.text.isEmpty) {
                    Fluttertoast.showToast(
                        backgroundColor: IColors.input,
                        msg:
                            "Not added yet, Please login with your email and password");
                  }
                },
                child: Container(
                  height: height / 18,
                  width: width / 1.1,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      "facebook",
                      style: TextStyle(
                          color: IColors.background,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            //----------Other Options------------//
            Padding(
              padding: EdgeInsets.only(top: height / 30, left: width / 3.2),
              child: Row(
                children: [
                  Text(
                    "don't have an account?",
                    style: TextStyle(fontSize: 12, color: IColors.icon),
                  ),
                  SizedBox(
                    width: width / 60,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignUpScreen())));
                    },
                    child: Text(
                      "sign up",
                      style: TextStyle(
                          fontSize: 12,
                          color: IColors.offWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //------------Firebase SignIn Method-----------//
  Future signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      Fluttertoast.showToast(msg: "Welcome $email");
      uid = auth.currentUser!.uid;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => HomeScreen(
                    uid: uid,
                  ))));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }
  //----------------------------------//
}

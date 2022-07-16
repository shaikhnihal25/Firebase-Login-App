import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:test_app/utils/iColors.dart';
import 'package:test_app/widgets/inputTile.dart';

import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //-----------Controllers-----------//
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //---------Device height and width-----------//
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //---------Main-------//
    return Scaffold(
      backgroundColor: IColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //----------Logo or Title----------//
            Padding(
              padding: EdgeInsets.only(top: height / 10, left: width / 20),
              child: Text(
                "Welcome,",
                style: TextStyle(
                    color: IColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 80, left: width / 20),
              child: Text(
                "Join us to continue",
                style: TextStyle(
                    color: IColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            //-------Full Name------//
            InputTile(
                top: 10,
                controller: name,
                secured: false,
                type: TextInputType.name,
                title: "Full Name",
                placeholder: "Elon musk",
                icon: Icon(
                  Icons.person,
                  color: IColors.icon,
                )),
            //---------Email---------//
            InputTile(
                top: 30,
                secured: false,
                controller: email,
                type: TextInputType.emailAddress,
                title: "Email",
                placeholder: "example@email.com",
                icon: Icon(
                  Icons.email,
                  color: IColors.icon,
                )),
            //---------Phone--------//
            InputTile(
                top: 30,
                secured: false,
                controller: phone,
                type: TextInputType.phone,
                title: "Phone",
                placeholder: "+91 000 111 2223",
                icon: Icon(
                  Icons.phone,
                  color: IColors.icon,
                )),
            //---------Password----------//
            InputTile(
                top: 30,
                secured: true,
                controller: password,
                type: TextInputType.visiblePassword,
                title: "Password",
                placeholder: "Create password",
                icon: Icon(
                  Icons.lock,
                  color: IColors.icon,
                )),

            //-------Button-----------//
            Padding(
              padding: EdgeInsets.only(top: height / 15, left: width / 20),
              child: GestureDetector(
                onTap: () async {
                  if (email.text.isEmpty ||
                      password.text.isEmpty ||
                      name.text.isEmpty ||
                      phone.text.isEmpty) {
                    //-------if any textfield are not filled before submitting , this error wiil show up------//
                    Fluttertoast.showToast(
                        backgroundColor: IColors.input,
                        msg: "All fields are required");
                  } else {
                    //-------if all fields are perfectly filled and submitted, signup method will be run & your details will be send to the firebase database------//
                    signUp(email.text, password.text, name.text, phone.text);
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
                      "SIGN UP",
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
              padding: EdgeInsets.only(top: height / 12, left: width / 3.2),
              child: Row(
                children: [
                  Text(
                    "already have an account?",
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
                              builder: ((context) => LoginScreen())));
                    },
                    child: Text(
                      "sign in",
                      style: TextStyle(
                          fontSize: 12,
                          color: IColors.offWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            //--------------------------------------//
          ],
        ),
      ),
    );
  }

//-------------Firebase SignUp Method-----------------//
  Future signUp(
      String email, String password, String username, String phone) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      CollectionReference users =
          FirebaseFirestore.instance.collection("Users");
      users.add({
        "username": username,
        "phone": phone,
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => LoginScreen())));

      Fluttertoast.showToast(msg: "Welcome $email");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    }
  }

  //-------------------------------------------//
}

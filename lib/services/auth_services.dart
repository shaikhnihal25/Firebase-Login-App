import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future getUID() async {
    return await FirebaseAuth.instance.currentUser;
  }
}

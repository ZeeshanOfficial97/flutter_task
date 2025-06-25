import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    UserCredential userCredential = await _auth.signInAnonymously();
    return userCredential.user;
  }
}
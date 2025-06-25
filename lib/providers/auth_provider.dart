import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  Future<void> signInAnonymously() async {
    UserCredential userCredential = await _auth.signInAnonymously();
    _user = userCredential.user;
  }
}
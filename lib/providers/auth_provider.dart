import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;
  User? _user;

  AuthProvider(this.repository);

  Future<void> signInAnonymously() async {
    _user = await repository.signInAnonymously();
  }
}
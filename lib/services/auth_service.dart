import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier implements Listenable{
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

AuthService(){
  _auth_check();

}

_auth_check(){
  _auth.authStateChanges().listen((User? user){
    usuario = (user== null) ? null : user;
    isLoading = false;
    notifyListeners();
  });
}

}



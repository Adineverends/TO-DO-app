import 'package:firebaseauth/AddTodo.dart';
import 'package:firebaseauth/service/Auth_Service.dart';
import 'package:firebaseauth/signin.dart';
import 'package:firebaseauth/signup.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //***************
  await Firebase.initializeApp();
  runApp(_MyApp());
}

class _MyApp extends StatefulWidget {
  @override
  __MyAppState createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {

  AuthClass authClass = AuthClass();
  Widget currentPage = signUpPage();

  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  checkLogin() async {
    String? tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null)
      setState(() {
        currentPage = HomePage();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}



import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_first/auth/login.dart';
import 'package:flutter_firebase_first/auth/panier.dart';
import 'package:flutter_firebase_first/auth/signup.dart';
import 'package:flutter_firebase_first/categories/addcard.dart';

import 'package:flutter_firebase_first/firebase_options.dart';
import 'package:flutter_firebase_first/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins-Black"),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Home()
          : Login(),
      routes: {
        "signup": (context) => Signup(),
        "login": (context) => Login(),
        "home": (context) => Home(),
        "addcard": (context) => AddCard(),
        "panier": (context) => CartPage(
              cartItems: [],
            ),
      },
    );
  }
}

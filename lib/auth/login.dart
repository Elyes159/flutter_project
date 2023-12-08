import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_first/components/custombutton.dart';
import 'package:flutter_firebase_first/components/customlogo.dart';
import 'package:flutter_firebase_first/components/textformfield.dart';
import 'package:flutter_firebase_first/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => Home()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Customlogo(),
                SizedBox(height: 20),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to continue using the app",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                ),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your password",
                  mycontroller: password,
                ),
                InkWell(
                  onTap: () async {
                    if (email.text == "") {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('email not found'),
                            content: Text('please insert an exesting email'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Ferme la boîte de dialogue
                                },
                                child: Text('Fermer'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Reset password'),
                          content: Text(
                              'if your email exist , we sended a reset password link'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                              },
                              child: Text('Fermer'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      "Forgot password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.grey[900]),
                    ),
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: CustomButton(
                      title: "login",
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          if (credential.user!.emailVerified) {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration.zero,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Home()));
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Email not verified"),
                                  content: Text(
                                      "Please verify your email to login."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Ferme la boîte de dialogue
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                    )),
                //SizedBox(height: 10),
                Center(
                  child: Text(
                    "Or login with",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                //SizedBox(height: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/facebook.png"),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: MaterialButton(
                        onPressed: () {
                          signInWithGoogle();
                        },
                        child: Image.asset("images/google.png"),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/apple.png"),
                      ),
                    ),
                  ],
                ),
                //SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Do you have an account? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

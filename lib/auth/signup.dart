import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_first/components/custombutton.dart';
import 'package:flutter_firebase_first/components/customlogo.dart';
import 'package:flutter_firebase_first/components/textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  File? _imageFile;

  Future<String?> uploadImage() async {
    try {
      if (_imageFile != null) {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

        await ref.putFile(_imageFile!);

        String imageUrl = await ref.getDownloadURL();
        return imageUrl;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Customlogo(),
                SizedBox(height: 20),
                Text(
                  "Register",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your personal Information",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 10),
                Text(
                  "Username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Username",
                  mycontroller: username,
                ),
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "Poppins-Black",
                  ),
                ),
                SizedBox(height: 15),
                CustomTextForm(
                  hinttext: "Enter Your Password",
                  mycontroller: password,
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: _chooseImage,
                  child: Center(
                    child: _imageFile == null
                        ? Text(
                            'Select Profile Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : Image.file(
                            _imageFile!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: CustomButton(
                    title: "Signup",
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        String? imageUrl = await uploadImage();

                        if (imageUrl != null) {
                          await FirebaseAuth.instance.currentUser!
                              .updateProfile(
                            displayName: username.text,
                            photoURL: imageUrl,
                          );
                        }
                        Navigator.of(context).pushReplacementNamed("login");
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("login");
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Have An Account ? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

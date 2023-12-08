import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_first/components/custombutton.dart';
import 'package:flutter_firebase_first/components/textformfieldadd.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController name = TextEditingController();
  File? _imageFile; // Variable pour stocker l'image sélectionnée

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  CollectionReference categorie =
      FirebaseFirestore.instance.collection('categories');

  // Fonction pour télécharger l'image sélectionnée dans Firebase Storage
  Future<String?> uploadImage(File image) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images') // Crée un dossier nommé 'images'
          .child(
              'image_name.jpg'); // Donne un nom unique à ton image, par exemple ici 'image_name.jpg'

      // Télécharge l'image dans Firebase Storage
      await ref.putFile(image);

      // Récupère l'URL de téléchargement de l'image
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> addCat() async {
    String? imageUrl;

    // Vérifie si une image a été sélectionnée
    if (_imageFile != null) {
      // Si une image a été sélectionnée, télécharge-la dans Firebase Storage
      imageUrl = await uploadImage(_imageFile!);
    }

    // Ajoute les données dans Firestore, y compris l'URL de l'image si elle existe
    return categorie
        .add({
          "name": name.text,
          "image": imageUrl, // Ajoute l'URL de l'image dans la base de données
        })
        .then(
          (value) => print("Category Added"),
        )
        .catchError((error) => print("Failed to add category: $error"));
  }

  // Fonction pour choisir une image depuis la galerie
  Future<void> _chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(
            pickedImage.path); // Stocke l'image sélectionnée dans _imageFile
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add category",
          style: GoogleFonts.poppins(color: Colors.green),
        ),
      ),
      body: Form(
        key: formstate,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: CustomTextFormadd(
                hinttext: "Enter name",
                mycontroller: name,
                validator: (val) {
                  if (val == "") {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Not Valid'),
                          content: Text("can't be empty"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed:
                  _chooseImage, // Appelle la fonction pour choisir une image
              child: Text('Choose Image'),
            ),
            _imageFile != null
                ? Container(
                    padding: EdgeInsets.all(50),
                    height: 50,
                    width: 50,
                    child:
                        Image.file(_imageFile!)) // Affiche l'image sélectionnée
                : Container(),
            CustomButton(
              title: "Add",
              onPressed: () {
                addCat();
                Navigator.of(context).pushReplacementNamed("home");
              },
            )
          ],
        ),
      ),
    );
  }
}

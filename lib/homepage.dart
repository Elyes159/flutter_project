import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_first/auth/login.dart';
import 'package:flutter_firebase_first/auth/panier.dart';
import 'package:flutter_firebase_first/components/textformfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController object = TextEditingController();
  List<Product> cartItems = [];
  List data = [
    {
      'name': 'Hoodie',
      'image': 'images/hoodie.png',
      'price': "price : 3500DT",
      'taille': 'Available Size :M,L'
    },
    {
      'name': 'Cap',
      'image': 'images/cap.png',
      'price': "price : 100DT",
      'taille': 'Available Size :XL,XXL'
    },
    {
      'name': 'Polo',
      'image': 'images/polo.png',
      'price': "price : 150DT",
      'taille': 'Available Size :XS,S,M'
    },
    {
      'name': 'Jacket',
      'image': 'images/jacket.png',
      'price': "price : 4000DT",
      'taille': 'Available Size :M,L,XL'
    },
    {
      'name': 'Kids Jacket',
      'image': 'images/jacketbb.png',
      'price': "price : 500DT",
      'taille': 'Available Age : 7,8',
    },
    {
      'name': 'Shirt',
      'image': 'images/chemise.png',
      'price': "price : 130DT",
      'taille': 'Available Size :S,M,XL'
    },
    {
      'name': 'Golf',
      'image': 'images/golf.png',
      'price': "price : 6000DT",
      'taille': 'Available Size :XL'
    },
    {
      'name': 'Checked Shirt',
      'image': 'images/chemisec.png',
      'price': "price : 300DT",
      'taille': 'Available Size :XL,XXL'
    },
  ];
  bool isloading = false;
  /* getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  } */
  @override
  void setState(VoidCallback fn) {
    isloading = false;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("panier");
        },
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ), */
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        title: Text('Our Store',
            style: GoogleFonts.poppins(
                color: Colors.orange, fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              if (FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.providerData
                      .any((userInfo) => userInfo.providerId == 'google.com')) {
                // Utilisateur connecté via Google, déconnexion de Google
                await googleSignIn.disconnect();
              }

              // Déconnexion de Firebase Auth
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed("login");
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.orange,
            ),
          )
        ],
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : /* GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 200),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          child: data[index]['image'] == null ||
                                  data[index]['image'] == ""
                              ? Image.asset("images/logo.png")
                              : Image.network(
                                  "${data[index]['image']}",
                                ),
                        ),
                        Text(
                          data[index]['name'],
                          style: GoogleFonts.poppins(),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),  */

          ListView(
              children: [
                CustomTextForm(hinttext: "Rechercher", mycontroller: object),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Explore a world of endless possibilities with our mobile e-commerce app.",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                GridView.builder(
                  shrinkWrap:
                      true, // Pour permettre au GridView de s'adapter à sa taille
                  physics:
                      NeverScrollableScrollPhysics(), // Empêche le défilement du GridView dans un parent à défilement
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              height: 55 - 4.7,
                              child: Image.asset(
                                "${data[index]['image']}",
                              ),
                            ),
                            Text(
                              data[index]['name'],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${data[index]['price']}\n${data[index]['taille']}",
                              style:
                                  GoogleFonts.poppins(color: Colors.grey[800]),
                            ),
                            MaterialButton(
                              onPressed: () {
                                setState(() {
                                  cartItems.add(Product(
                                    name: data[index]['name'],
                                    image: data[index]['image'],
                                    price: data[index]['price'],
                                    size: data[index]['taille'],
                                  ));
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CartPage(cartItems: cartItems),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.shopping_bag,
                                size: 30,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class Product {
  final String name;
  final String image;
  final String price;
  final String size;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      required this.size});
}

import 'package:flutter/material.dart';
import 'package:flutter_firebase_first/homepage.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartItems;

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(cartItems[index].image),
            title: Text(cartItems[index].name),
            subtitle:
                Text('${cartItems[index].price}\n${cartItems[index].size}'),
          );
        },
      ),
    );
  }
}

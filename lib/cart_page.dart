import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final Map<String, int> cart;

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body:
          cart.isEmpty
              ? Center(
                child: Text(
                  "Keranjang kosong!",
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  String item = cart.keys.elementAt(index);
                  int quantity = cart[item]!;
                  return ListTile(
                    title: Text(item, style: TextStyle(fontSize: 18)),
                    trailing: Text(
                      "x$quantity",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
    );
  }
}

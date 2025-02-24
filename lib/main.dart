import 'package:flutter/material.dart';
import 'cart_page.dart';

void main() {
  runApp(FoodOrderApp());
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.yellow[100],
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Arial',
            color: Colors.brown,
            fontSize: 18,
          ),
          bodyMedium: TextStyle(fontFamily: 'Arial', color: Colors.brown),
        ),
      ),
      home: FoodOrderScreen(),
    );
  }
}

class FoodOrderScreen extends StatefulWidget {
  const FoodOrderScreen({super.key});

  @override
  _FoodOrderScreenState createState() => _FoodOrderScreenState();
}

class _FoodOrderScreenState extends State<FoodOrderScreen> {
  final Map<String, int> _cart = {};
  final List<Map<String, String>> _menu = [
    {"name": "Pizza", "image": "assets/pizza.jpg"},
    {"name": "Soto", "image": "assets/soto.jpg"},
    {"name": "Mie Gomak", "image": "assets/miegomak.jpg"},
    {"name": "Ayam Napinadar", "image": "assets/ayam.jpg"},
    {"name": "Saksang", "image": "assets/saksang.jpg"},
  ];

  void _addToCart(String item) {
    setState(() {
      _cart[item] = (_cart[item] ?? 0) + 1;
    });
  }

  void _removeFromCart(String item) {
    setState(() {
      if (_cart.containsKey(item) && _cart[item]! > 0) {
        _cart[item] = _cart[item]! - 1;
        if (_cart[item] == 0) {
          _cart.remove(item);
        }
      }
    });
  }

  void _updateQuantity(String item, String value) {
    setState(() {
      int? newValue = int.tryParse(value);
      if (newValue != null && newValue >= 0) {
        _cart[item] = newValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Menu", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cart: _cart)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _menu.length,
        itemBuilder: (context, index) {
          String item = _menu[index]['name']!;
          String image = _menu[index]['image']!;
          return Card(
            color: Colors.yellow[50],
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Image.asset(image, width: 120, height: 120, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 18, color: Colors.brown),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.red),
                      onPressed: () => _removeFromCart(item),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                          text: _cart[item]?.toString() ?? "0",
                        ),
                        onChanged: (value) => _updateQuantity(item, value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.green),
                      onPressed: () => _addToCart(item),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

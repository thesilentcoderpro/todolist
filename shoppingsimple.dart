import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductsPage(),
    );
  }
}

List<Map<String, dynamic>> products = [
  {"name": "Shoes", "price": 2000},
  {"name": "Watch", "price": 1500},
  {"name": "Bag", "price": 1000},
  {"name": "Headset", "price": 2500},
];

List<Map<String, dynamic>> cart = [];

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              ).then((_) => setState(() {}));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(products[i]["name"]),
            subtitle: Text("₹ ${products[i]["price"]}"),
            trailing: ElevatedButton(
              onPressed: () {
                setState(() => cart.add(products[i]));
              },
              child: const Text("Add"),
            ),
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int get total =>
      cart.fold(0, (sum, item) => sum + item["price"] as int);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is Empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (_, i) {
                      return ListTile(
                        title: Text(cart[i]["name"]),
                        subtitle: Text("₹ ${cart[i]["price"]}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() => cart.removeAt(i));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Text("Total: ₹ $total",
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PaymentPage(total: total)),
                    );
                  },
                  child: const Text("Proceed to Payment"),
                ),
                const SizedBox(height: 10),
              ],
            ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final int total;
  const PaymentPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total Amount: ₹ $total",
                style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OrderPage(
                            items: List.from(cart),
                            total: total,
                          )),
                  (route) => false,
                );
                cart.clear();
              },
              child: const Text("Pay Now"),
            )
          ],
        ),
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final List items;
  final int total;
  const OrderPage({super.key, required this.items, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Placed")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Order Successful!",
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text("Items:",
                style: TextStyle(fontSize: 18)),
            ...items.map((item) => Text(
                "${item["name"]} - ₹ ${item["price"]}")),
            const SizedBox(height: 20),
            Text("Total Paid: ₹ $total",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ProductsPage()),
                );
              },
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}
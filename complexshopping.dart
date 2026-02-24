import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: loggedIn
          ? HomePage(
              onLogout: () => setState(() => loggedIn = false),
            )
          : LoginPage(
              onLogin: () => setState(() => loggedIn = true),
            ),
    );
  }
}

class Product {
  final String name;
  final String category;
  final double price;
  final String image;

  Product(this.name, this.category, this.price, this.image);
}

List<Product> products = [
  Product("Nike Shoes", "Fashion", 3999,
      "https://picsum.photos/200?1"),
  Product("Smart Watch", "Electronics", 5999,
      "https://picsum.photos/200?2"),
  Product("Backpack", "Fashion", 1999,
      "https://picsum.photos/200?3"),
  Product("Headphones", "Electronics", 2999,
      "https://picsum.photos/200?4"),
  Product("Laptop", "Electronics", 54999,
      "https://picsum.photos/200?5"),
];

Map<Product, int> cart = {};

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Shopping Login",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
                  const SizedBox(height: 10),
                  TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (email.text.isNotEmpty &&
                          password.text.isNotEmpty) {
                        widget.onLogin();
                      }
                    },
                    child: const Text("Login"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final VoidCallback onLogout;
  const HomePage({super.key, required this.onLogout});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All";
  String search = "";

  double get total =>
      cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  @override
  Widget build(BuildContext context) {
    List<Product> filtered = products.where((p) {
      final matchCategory =
          selectedCategory == "All" || p.category == selectedCategory;
      final matchSearch =
          p.name.toLowerCase().contains(search.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("ShopX"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CartPage(
                              total: total,
                              refresh: () => setState(() {}),
                            )),
                  ).then((_) => setState(() {}));
                },
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 9,
                    child: Text(
                      cart.length.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                )
            ],
          ),
          IconButton(
              onPressed: widget.onLogout,
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search products"),
              onChanged: (v) => setState(() => search = v),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ["All", "Fashion", "Electronics"]
                  .map((c) => ChoiceChip(
                        label: Text(c),
                        selected: selectedCategory == c,
                        onSelected: (_) =>
                            setState(() => selectedCategory = c),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: filtered.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .75),
                itemBuilder: (_, i) {
                  final p = filtered[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DetailPage(product: p)),
                      ).then((_) => setState(() {}));
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(p.image,
                                fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(p.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text("₹ ${p.price}"),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      cart[p] =
                                          (cart[p] ?? 0) + 1;
                                    });
                                  },
                                  child: const Text("Add"),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: Image.network(product.image)),
            Text(product.name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("₹ ${product.price}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart[product] = (cart[product] ?? 0) + 1;
                Navigator.pop(context);
              },
              child: const Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final double total;
  final VoidCallback refresh;
  const CartPage(
      {super.key, required this.total, required this.refresh});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get total =>
      cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is Empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: cart.entries.map((e) {
                      return ListTile(
                        leading: Image.network(e.key.image),
                        title: Text(e.key.name),
                        subtitle: Text("₹ ${e.key.price}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (e.value > 1) {
                                      cart[e.key] =
                                          e.value - 1;
                                    } else {
                                      cart.remove(e.key);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                            Text(e.value.toString()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    cart[e.key] =
                                        e.value + 1;
                                  });
                                },
                                icon: const Icon(Icons.add)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Text("Total: ₹ $total",
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              OrderPage(total: total)),
                    );
                    cart.clear();
                    widget.refresh();
                  },
                  child: const Text("Checkout"),
                ),
                const SizedBox(height: 20)
              ],
            ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final double total;
  const OrderPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle,
                    size: 80, color: Colors.green),
                const SizedBox(height: 20),
                const Text("Order Successful!",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Paid ₹ $total"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MyApp()),
                        (route) => false);
                  },
                  child: const Text("Back to Home"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
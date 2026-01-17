import 'package:flutter/material.dart';
import '../classes/item.dart';

class CartScreen extends StatelessWidget {
  final List<Item> cart;

  const CartScreen({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final total = cart.fold<double>(
        0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cart.isEmpty
          ? const Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (_, i) {
                      final item = cart[i];
                      return ListTile(
                        title: Text(item.itemName),
                        subtitle: Text(item.pickupLocation),
                        trailing: Text("Rs. ${item.price}"),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Total Price: Rs. $total",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../classes/item.dart';
import 'item_detail_screen.dart';

class CartScreen extends StatefulWidget {
  final List<Item> cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // Calculates the total price of all items currently in the cart
    final total = widget.cart.fold<double>(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: widget.cart.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (_, i) {
                      final item = widget.cart[i];
                      return ListTile(
                        leading: const Icon(Icons.shopping_bag_outlined),
                        title: Text(item.itemName),
                        subtitle: Text("Location: ${item.pickupLocation}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Rs. ${item.price}", 
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Remove the item and refresh the UI
                                setState(() {
                                  widget.cart.removeAt(i);
                                });
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // Navigate to the full detail page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ItemDetailScreen(
                                item: item,
                                onDelete: () {
                                  setState(() => widget.cart.remove(item));
                                  Navigator.pop(context);
                                },
                                onAddToCart: () {}, // Already in cart
                                onEdit: () => setState(() {}),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Rs. $total",
                        style: const TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Added for Firebase
import '../classes/item.dart';
import 'add_edit_item_screen.dart';
import 'item_detail_screen.dart';
import 'cart_screen.dart';
import '../auth/current_user.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> cart = [];
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey, ${CurrentUser.user?.name ?? ''} 👋"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              CurrentUser.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartScreen(cart: cart)),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditItemScreen()),
          );
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search items",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => searchText = value),
            ),
          ),
          Expanded(
            // StreamBuilder listens to Firestore changes in real-time
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('items').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No items found"));
                }

                // Convert Firebase documents to Item objects [cite: 6, 7]
                final allItems = snapshot.data!.docs.map((doc) {
                  return Item.fromMap(doc.id, doc.data() as Map<String, dynamic>);
                }).toList();

                // Filter items based on search text [cite: 44]
                final filteredItems = allItems
                    .where((item) => item.itemName
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (_, index) {
                    final item = filteredItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ItemDetailScreen(
                              item: item,
                              onDelete: () async {
                                // Delete from Firestore
                                await FirebaseFirestore.instance
                                    .collection('items')
                                    .doc(item.itemId)
                                    .delete();
                                Navigator.pop(context);
                              },
                              onAddToCart: () {
                                if (!cart.contains(item)) {
                                  setState(() => cart.add(item));
                                }
                              },
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddEditItemScreen(item: item),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: item.photoPath.isNotEmpty
                                  ? Image.file(File(item.photoPath),
                                      fit: BoxFit.cover, width: double.infinity)
                                  : const Icon(Icons.image, size: 80),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Column(
                                children: [
                                  Text(item.itemName,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  Text("Rs. ${item.price}"),
                                  Chip(
                                    label: Text(item.status),
                                    backgroundColor: item.status == "Available"
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
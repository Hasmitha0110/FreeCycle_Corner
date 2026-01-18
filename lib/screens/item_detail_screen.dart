import 'dart:io';
import 'package:flutter/material.dart';
import '../classes/item.dart';
import '../auth/current_user.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  final VoidCallback onDelete;
  final VoidCallback onAddToCart;
  final VoidCallback onEdit;

  const ItemDetailScreen({
    super.key,
    required this.item,
    required this.onDelete,
    required this.onAddToCart,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOwner =
        item.ownerEmail == CurrentUser.user!.email;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.itemName),
        actions: [
          // ✏️ EDIT — OWNER ONLY
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),

          // 🗑 DELETE — OWNER ONLY
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🖼 PHOTO
          item.photoPath.isNotEmpty
              ? Image.file(
                  File(item.photoPath),
                  height: 220,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.image, size: 150),

          const SizedBox(height: 12),

          Text(
            item.itemName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text("Condition: ${item.condition}"),
          Text("Description: ${item.description}"),
          Text("Category: ${item.category}"),
          Text("Pickup Location: ${item.pickupLocation}"),
          Text(
            "Status: ${item.status}",
            style: TextStyle(
              color: item.status == "Available"
                  ? Colors.green
                  : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Created At: ${item.createdAt}"),

          const Divider(height: 30),

          // 👤 OWNER INFO (VISIBLE TO ALL)
          Text(
            "Owner Information",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Name: ${item.ownerName}"),
          Text("Contact: ${item.ownerContact}"),
          Text("Email: ${item.ownerEmail}"),

          const SizedBox(height: 20),

          // 🛒 ADD TO CART — EVERYONE
          ElevatedButton.icon(
            onPressed: onAddToCart,
            icon: const Icon(Icons.shopping_cart),
            label: const Text("Add to Cart"),
          ),

          // 🔒 OWNER NOTICE
          if (!isOwner)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                "You can view and claim this item, but only the owner can edit or delete it.",
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
        ],
      ),
    );
  }
}

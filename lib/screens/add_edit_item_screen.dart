import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import '../classes/item.dart';
import '../auth/current_user.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;

  const AddEditItemScreen({super.key, this.item});

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  late TextEditingController name;
  late TextEditingController condition;
  late TextEditingController description;
  late TextEditingController price;
  late TextEditingController category;
  late TextEditingController location;

  String status = "Available";
  String photoPath = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.item?.itemName ?? "");
    condition = TextEditingController(text: widget.item?.condition ?? "");
    description = TextEditingController(text: widget.item?.description ?? "");
    price = TextEditingController(text: widget.item?.price.toString() ?? "");
    category = TextEditingController(text: widget.item?.category ?? "");
    location = TextEditingController(text: widget.item?.pickupLocation ?? "");
    status = widget.item?.status ?? "Available";
    photoPath = widget.item?.photoPath ?? "";
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => photoPath = image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(isEdit ? "Edit Item" : "Post New Item", style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid),
                  ),
                  child: photoPath.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.file(File(photoPath), fit: BoxFit.cover, width: double.infinity),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined, size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 12),
                            Text("Tap to add a photo", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Item Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 16),
                      TextField(controller: name, decoration: const InputDecoration(labelText: "Item Name", prefixIcon: Icon(Icons.title))),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: TextField(controller: category, decoration: const InputDecoration(labelText: "Category", prefixIcon: Icon(Icons.category_outlined)))),
                          const SizedBox(width: 16),
                          Expanded(child: TextField(controller: condition, decoration: const InputDecoration(labelText: "Condition", prefixIcon: Icon(Icons.star_outline)))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: price, 
                        decoration: const InputDecoration(labelText: "Price (Rs.)", prefixIcon: Icon(Icons.attach_money)), 
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: description, 
                        decoration: const InputDecoration(labelText: "Description", prefixIcon: Icon(Icons.description_outlined), alignLabelWithHint: true),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Logistics", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 16),
                      TextField(controller: location, decoration: const InputDecoration(labelText: "Pickup Location", prefixIcon: Icon(Icons.location_on_outlined))),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: status,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        decoration: const InputDecoration(labelText: "Status", prefixIcon: Icon(Icons.info_outline)),
                        items: ["Available", "Sold"]
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) => setState(() => status = v!),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        final double? parsedPrice = double.tryParse(price.text);
                        if (parsedPrice == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter a valid price"))
                          );
                          return;
                        }
                        if (name.text.isEmpty || category.text.isEmpty || location.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill in the required fields"))
                          );
                          return;
                        }

                        setState(() => _isLoading = true);

                        final itemData = {
                          'itemName': name.text,
                          'condition': condition.text,
                          'description': description.text,
                          'price': parsedPrice,
                          'category': category.text,
                          'pickupLocation': location.text,
                          'status': status,
                          'photoPath': photoPath,
                          'ownerName': CurrentUser.user!.name,
                          'ownerContact': CurrentUser.user!.contact,
                          'ownerEmail': CurrentUser.user!.email,
                          'createdAt': Timestamp.now(),
                        };

                        try {
                          if (isEdit) {
                            await FirebaseFirestore.instance
                                .collection('items')
                                .doc(widget.item!.itemId)
                                .update(itemData);
                          } else {
                            await FirebaseFirestore.instance
                                .collection('items')
                                .add(itemData);
                          }
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e"))
                          );
                        } finally {
                          if (mounted) setState(() => _isLoading = false);
                        }
                      },
                child: _isLoading 
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(isEdit ? "Update Item" : "Post Item"),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
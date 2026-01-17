import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.item?.itemName ?? "");
    condition = TextEditingController(text: widget.item?.condition ?? "");
    description = TextEditingController(text: widget.item?.description ?? "");
    price = TextEditingController(
        text: widget.item?.price.toString() ?? "");
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
      appBar: AppBar(
        title: Text(isEdit ? "Edit Item" : "Add Item"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (photoPath.isNotEmpty)
            Image.file(File(photoPath), height: 150, fit: BoxFit.cover),

          TextButton.icon(
            onPressed: pickImage,
            icon: const Icon(Icons.photo),
            label: const Text("Add Photo"),
          ),

          TextField(controller: name, decoration: const InputDecoration(labelText: "Item Name")),
          TextField(controller: condition, decoration: const InputDecoration(labelText: "Condition")),
          TextField(controller: description, decoration: const InputDecoration(labelText: "Description")),
          TextField(controller: price, decoration: const InputDecoration(labelText: "Price")),
          TextField(controller: category, decoration: const InputDecoration(labelText: "Category")),
          TextField(controller: location, decoration: const InputDecoration(labelText: "Pickup Location")),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            value: status,
            items: ["Available", "Sold"]
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => status = v!),
            decoration: const InputDecoration(labelText: "Status"),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              if (isEdit) {
                widget.item!
                  ..itemName = name.text
                  ..condition = condition.text
                  ..description = description.text
                  ..price = double.parse(price.text)
                  ..category = category.text
                  ..pickupLocation = location.text
                  ..status = status
                  ..photoPath = photoPath;

                Navigator.pop(context);
              } else {
                Navigator.pop(
                  context,
                  Item(
                    itemId: DateTime.now().millisecondsSinceEpoch,
                    itemName: name.text,
                    condition: condition.text,
                    description: description.text,
                    price: double.parse(price.text),
                    category: category.text,
                    pickupLocation: location.text,
                    status: status,
                    photoPath: photoPath,
                    ownerName: CurrentUser.user!.name,
ownerContact: CurrentUser.user!.contact,
ownerEmail: CurrentUser.user!.email,

                  ),
                );
              }
            },
            child: Text(isEdit ? "Update Item" : "Add Item"),
          ),
        ],
      ),
    );
  }
}

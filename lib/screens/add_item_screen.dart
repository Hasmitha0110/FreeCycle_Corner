// import 'package:flutter/material.dart';
// import '../classes/item.dart';
// import '../classes/user.dart';

// class AddItemScreen extends StatelessWidget {
//   AddItemScreen({super.key});

//   final nameController = TextEditingController();
//   final locationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     User dummyUser = User(
//       userId: 1,
//       name: "Demo User",
//       studentId: "EG000000",
//       nic: "000000000V",
//       contact: "0710000000",
//       email: "demo@gmail.com",
//       password: "123456",
//     );

//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Item")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Item Name"),
//             ),
//             TextField(
//               controller: locationController,
//               decoration: const InputDecoration(labelText: "Pickup Location"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Item item = Item(
//                   itemId: DateTime.now().millisecondsSinceEpoch,
//                   itemName: nameController.text,
//                   itemCondition: "Good",
//                   itemDescription: "No description",
//                   itemPrice: 0,
//                   itemCategory: ["General"],
//                   pickupLocation: locationController.text,
//                   status: "Available",
//                   owner: dummyUser,
//                   ownercontact: dummyUser.contact,
//                 );

//                 Navigator.pop(context, item);
//               },
//               child: const Text("Save Item"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

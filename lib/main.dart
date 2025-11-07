import 'package:flutter/material.dart';
import 'classes/user.dart';
import 'classes/item.dart';
import 'classes/claim.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    User user = User(
      userId: 1,
      name: "John Doe",
      studentId: "S1234567A",
      nic: "123456789V",
      contact: "12345678",
      email: "john@gmail.com",
      password: "password123",
    );
    user.rejister();

    
    Item item = Item(
      itemId: 1,
      itemName: "Laptop",
      itemCondition: "Good",
      itemDescription: "A used laptop in good condition",
      itemPrice: 300.0,
      itemCategory: ["Electronics", "Computers"],
      pickupLocation: "Library",
      status: "Available",
      ownerId: user.userId,
    );
    item.createItem();

    
    Claimer claimer = Claimer(
      claimId: 1,
      itemId: item.itemId,
      claimerId: 2,
      claimStatus: "Pending",
      claimerContact: "87654321",
    );
    claimer.makeClaim();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Campus Freecycle Corner')),
        body: Center(child: Text('Check console for class outputs!')),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String itemId; 
  String itemName;
  String condition;
  String description;
  double price;
  String category;
  String pickupLocation;
  String status;
  String photoPath; 
  DateTime createdAt;
  String ownerName;
  String ownerContact;
  String ownerEmail;

  Item({
    required this.itemId,
    required this.itemName,
    required this.condition,
    required this.description,
    required this.price,
    required this.category,
    required this.pickupLocation,
    required this.status,
    required this.photoPath,
    required this.ownerName,
    required this.ownerContact,
    required this.ownerEmail,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert Firestore Document to Item Object
  factory Item.fromMap(String id, Map<String, dynamic> data) {
    return Item(
      itemId: id,
      itemName: data['itemName'] ?? '',
      condition: data['condition'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      pickupLocation: data['pickupLocation'] ?? '',
      status: data['status'] ?? 'Available',
      photoPath: data['photoPath'] ?? '',
      ownerName: data['ownerName'] ?? '',
      ownerContact: data['ownerContact'] ?? '',
      ownerEmail: data['ownerEmail'] ?? '',
      // Firebase stores dates as Timestamps
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as Timestamp).toDate() 
          : DateTime.now(),
    );
  }

  // Convert Item Object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'condition': condition,
      'description': description,
      'price': price,
      'category': category,
      'pickupLocation': pickupLocation,
      'status': status,
      'photoPath': photoPath,
      'ownerName': ownerName,
      'ownerContact': ownerContact,
      'ownerEmail': ownerEmail,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
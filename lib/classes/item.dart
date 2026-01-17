class Item {
  int itemId;
  String itemName;
  String condition;        // ✅ THIS EXISTS
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
  }) : createdAt = DateTime.now();
}

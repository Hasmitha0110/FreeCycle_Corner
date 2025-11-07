

class Item{
  int itemId;
  String itemName;
  String itemCondition;
  String itemDescription;
  double itemPrice;
  List<String> itemCategory;
  String pickupLocation;
  String status;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  int ownerId;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemCondition,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemCategory,
    required this.pickupLocation,
    required this.status,
    required this.ownerId
  });


  void createItem(){
    print("Item $itemName Created");
  }

  void updateItem(){
    this.itemId = itemId;
    this.itemName = itemName;
    this.itemCondition = itemCondition;
    this.itemDescription = itemDescription;
    this.itemPrice = itemPrice;
    this.itemCategory = itemCategory;
    this.pickupLocation = pickupLocation;
    this.status = status;
    this.updatedAt = DateTime.now();
    
    print("Item $itemName Updated");
  }

  void deleteItem(){
    print("Item $itemName Deleted");
  }

  void viewItem(){
    print("Item $itemName Viewed");
  }





}
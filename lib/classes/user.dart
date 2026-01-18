class User {
  String userId; // Firebase uses String UIDs
  String name;
  String studentId;
  String nic;
  String contact;
  String email;

  User({
    required this.userId,
    required this.name,
    required this.studentId,
    required this.nic,
    required this.contact,
    required this.email,
  });

  // Convert Firebase Document to User Object
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      userId: data['userId'] ?? '',
      name: data['name'] ?? '',
      studentId: data['studentId'] ?? '',
      nic: data['nic'] ?? '',
      contact: data['contact'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Convert User Object to Map for Firebase Storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'studentId': studentId,
      'nic': nic,
      'contact': contact,
      'email': email,
    };
  }
}
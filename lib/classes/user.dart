

class User{
  int userId;
  String name;
  String studentId;
  String nic;
  String contact;
  String email;
  String password;
  DateTime createdAt = DateTime.now();

  User({
    required this.userId,
    required this.name,
    required this.studentId,
    required this.nic,
    required this.contact,
    required this.email,
    required this.password
  });


  void rejister(){
    print("User $name Rejistered");
  }

  void login(){
    print("User $name Logged In");
  }

  void logout(){
    print("User $name Logged Out");
  }







}
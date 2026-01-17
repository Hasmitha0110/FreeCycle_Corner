import '../classes/user.dart';

class CurrentUser {
  static User? user;

  static bool get isLoggedIn => user != null;

  static void logout() {
    user = null;
  }
}

import 'dart:math';

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? phoneNumber;

  User(
      {this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.avatar,
      this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    phoneNumber = generateRandomPhoneNumber(); // Generate random phoneNumber
  }

  // Method to generate a random 8-digit phoneNumber
  String generateRandomPhoneNumber() {
    var rng = Random();
    var number = '';
    for (var i = 0; i < 8; i++) {
      number += rng.nextInt(10).toString();
    }
    return number;
  }
}

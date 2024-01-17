import 'dart:math';
import 'package:uuid/uuid.dart';

class User {
  late int id;
  late String email;
  late String firstName;
  late String lastName;
  String? avatar;
  String? phoneNumber;

  User(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.avatar,
      this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    phoneNumber = json['phone_number'] ??
        generateRandomPhoneNumber(); // Generate random phone number if not present
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'avatar': avatar,
      'phone_number': phoneNumber,
    };
  }

  var uuid = const Uuid();

  // Method to generate a random 8-digit phoneNumber
  String generateRandomPhoneNumber() {
    var rng = Random();
    var firstDigit = rng.nextBool() ? 8 : 9;
    var number = '$firstDigit';
    for (var i = 0; i < 7; i++) {
      number += rng.nextInt(10).toString();
    }
    return number;
  }
}

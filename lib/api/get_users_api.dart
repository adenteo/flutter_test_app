import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

Future<List<User>> fetchUsers() async {
  // await prefs.remove('users');
  List<User> users = await getUsersFromPrefs(); // No saved users
  if (users.isNotEmpty) {
    return users;
  }
  final response = await dio.get('https://reqres.in/api/users');
  if (response.statusCode == 200) {
    users =
        (response.data['data'] as List).map((e) => User.fromJson(e)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}

Future<List<User>> getUsersFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final String? usersJsonString = prefs.getString('users');
  debugPrint(usersJsonString);
  List<User> users = [];
  if (usersJsonString != null && usersJsonString.isNotEmpty) {
    final List<dynamic> usersMapList = json.decode(usersJsonString);
    users = usersMapList.map((userMap) => User.fromJson(userMap)).toList();
  }
  return users;
}

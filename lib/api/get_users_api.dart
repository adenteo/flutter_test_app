import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<List<User>> fetchUsers() async {
  final response = await dio.get('https://reqres.in/api/users');
  if (response.statusCode == 200) {
    final users =
        (response.data['data'] as List).map((e) => User.fromJson(e)).toList();
    debugPrint('users: $users');
    return users;
  } else {
    debugPrint('ERROR FETCHING USERS');
    throw Exception('Failed to load users');
  }
}

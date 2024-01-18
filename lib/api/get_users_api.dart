import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/blocs/user_bloc.dart';
import 'package:flutter_test_app/src/exceptions/fetch_users_exception.dart';
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio(); // Note to use a singleton next time.

Future<List<User>> fetchUsers() async {
  List<User> users = await getUsersFromPrefs();
  debugPrint("got users from pref");
  if (users.isNotEmpty) {
    return users;
  }
  debugPrint("fetching from api");
  try {
    final response = await dio.get('https://reqres.in/api/users');
    if (response.statusCode == 200) {
      debugPrint("got response");
      users =
          (response.data['data'] as List).map((e) => User.fromJson(e)).toList();
      await storeUsersInLocalStorage(users);
      return users;
    } else {
      throw FetchUsersException(
          errorCode: response.statusCode!,
          errorMessage: "Failed to load users");
    }
  } on DioException catch (e) {
    String errorMessage = e.response?.statusMessage ?? e.message!;
    int errorCode = e.response?.statusCode ?? 0;
    throw FetchUsersException(errorCode: errorCode, errorMessage: errorMessage);
  } catch (e) {
    throw FetchUsersException(
        errorCode: 500, errorMessage: "Unexpected error: $e");
  }
}

Future<List<User>> getUsersFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final String? usersJsonString = prefs.getString('users');
  List<User> users = [];
  if (usersJsonString != null && usersJsonString.isNotEmpty) {
    final List<dynamic> usersMapList = json.decode(usersJsonString);
    debugPrint(usersJsonString);
    users = usersMapList.map((userMap) => User.fromJson(userMap)).toList();
  }
  // for (final user in users) {
  //   debugPrint(user.id.toString());
  // }
  // debugPrint("reached hee");
  return users;
}

Future<void> clearUsersFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('users');
}

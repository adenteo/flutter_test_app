import 'dart:convert';

import "package:flutter/material.dart";
import "package:flutter_test_app/api/get_users_api.dart";
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'states/user_states.dart';
import 'events/user_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//email, upload of image, call functionality, save in localStorage.

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUsers>(
      (event, emit) async {
        emit(UserLoading());
        try {
          final users = await fetchUsers();
          emit(UserLoaded(users));
        } catch (e) {
          emit(UserError());
        }
      },
    );
    on<AddUser>(
      (event, emit) async {
        // Check if the current state has loaded users
        if (state is UserLoaded) {
          // Copy the current list of users
          final List<User> updatedUsers =
              List<User>.from((state as UserLoaded).users);
          // Create a new User object
          final User newUser = User(
            id: updatedUsers.length +
                1, // Will probably use cuid here in production
            firstName: event.fname,
            lastName: event.lname,
            email: event.email,
            avatar: event.image,
          );
          newUser.phoneNumber = newUser
              .generateRandomPhoneNumber(); // Add the new user to the list
          updatedUsers.add(newUser);

          await storeUsersInLocalStorage(updatedUsers);

          // Emit the updated state
          emit(UserLoaded(updatedUsers));
        } else {
          emit(UserError());
        }
      },
    );
    on<EditUser>(
      (event, emit) async {
        if (state is UserLoaded) {
          final List<User> updatedUsers =
              List<User>.from((state as UserLoaded).users);

          final index = updatedUsers.indexWhere((user) => user.id == event.id);
          if (index != -1) {
            updatedUsers[index].firstName = event.fname;
            updatedUsers[index].lastName = event.lname;
            updatedUsers[index].email = event.email;
            updatedUsers[index].avatar = event.image;

            await storeUsersInLocalStorage(updatedUsers);

            emit(UserLoaded(updatedUsers));
          } else {
            // Emit an error or a specific state if the user is not found
            emit(UserError());
          }
        } else {
          emit(UserError());
        }
      },
    );
  }
}

Future<void> storeUsersInLocalStorage(List<User> users) async {
  final usersMapList = users.map((user) => user.toMap()).toList();
  final usersJson = json.encode(usersMapList);
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('users', usersJson);
}

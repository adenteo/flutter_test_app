import "package:flutter/material.dart";
import "package:flutter_test_app/api/get_users_api.dart";
import 'package:flutter_test_app/src/models/request/users_request.dart';

import 'states/user_states.dart';
import 'events/user_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchUsers>(
      (event, emit) async {
        emit(UserLoading());
        try {
          debugPrint('FetchUsers');
          final users = await fetchUsers();
          debugPrint('got users');
          emit(UserLoaded(users));
        } catch (e) {
          debugPrint('$e');
          emit(UserError());
        }
      },
    );
    on<AddUser>(
      (event, emit) async {
        debugPrint('Add User ${event.userName}');
        // Check if the current state has loaded users
        if (state is UserLoaded) {
          // Copy the current list of users
          final List<User> updatedUsers =
              List<User>.from((state as UserLoaded).users);
          debugPrint('updatedUsers: $updatedUsers');
          // Create a new User object (assuming a constructor that takes userName)
          final User newUser = User(firstName: event.userName);

          // Add the new user to the list
          updatedUsers.add(newUser);

          // Emit the updated state
          emit(UserLoaded(updatedUsers));
        } else {
          debugPrint('state is not UserLoaded');
          // Handle the case where users are not yet loaded or there's an error
          // For example, you might want to fetch the users first or emit an error state
        }
      },
    );
  }
}

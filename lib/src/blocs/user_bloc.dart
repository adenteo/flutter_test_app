import "package:flutter/material.dart";
import "package:flutter_test_app/api/get_users_api.dart";

import 'states/user_states.dart';
import 'events/user_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  // UserBloc() : super(UserInitial());

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
    // on<FetchUsers>(
    //   (event, emit) async {
    //     emit(UserLoading());
    //     try {
    //       debugPrint('FetchUsers');
    //       final users = await fetchUsers();
    //       debugPrint('got users');
    //       emit(UserLoaded(users));
    //     } catch (e) {
    //       debugPrint('$e');
    //       emit(UserError());
    //     }
    //   },
    // );
  }
}

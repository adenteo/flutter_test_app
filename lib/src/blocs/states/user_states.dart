import "../../models/request/users_request.dart";

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserError extends UserState {}

import "../../models/request/users_request.dart";

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

class UserError extends UserState {
  final String errorMessage;
  final int errorCode;
  UserError(this.errorCode, this.errorMessage);
}

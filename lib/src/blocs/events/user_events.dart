abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class AddUser extends UserEvent {
  final String userName;

  AddUser(this.userName);
}

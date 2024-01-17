abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class AddUser extends UserEvent {
  final String fname;
  final String lname;
  final String email;
  final String? image;

  AddUser(this.fname, this.lname, this.email, this.image);
}

class EditUser extends UserEvent {
  final String fname;
  final String lname;
  final String email;
  final String? image;

  EditUser(this.fname, this.lname, this.email, this.image);
}

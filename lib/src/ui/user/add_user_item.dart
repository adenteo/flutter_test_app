import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/src/blocs/events/user_events.dart';
import 'package:flutter_test_app/src/blocs/user_bloc.dart';

class AddUserItem extends StatefulWidget {
  const AddUserItem({super.key});

  @override
  AddUserItemState createState() => AddUserItemState();
}

class AddUserItemState extends State<AddUserItem> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _contactNameInput(),
              const SizedBox(height: 50),
              _createContactButton(context) // Updated to pass context
            ],
          ),
        ),
      ),
    );
  }

  Widget _createContactButton(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      onPressed: () {
        debugPrint('Received click');
        var userName = _nameController.text;
        context.read<UserBloc>().add(AddUser(userName));
      },
      child: const Text('Create'),
    );
  }

  Widget _contactNameInput() {
    return Row(
      children: [
        const Text('Name'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _nameController, // Use the text controller here
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

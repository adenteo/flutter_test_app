import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/src/blocs/states/user_states.dart';
import 'package:flutter_test_app/src/blocs/user_bloc.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

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
              _createContactButton()
            ],
          ),
        ),
      ),
    );
  }
}

Widget _createContactButton() {
  return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
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
      },
      child: const Text('Create'),
    );
  });
}

Widget _contactNameInput() {
  return const Row(
    children: [
      // SizedBox(width: 10),
      Text('Name'),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
      ),
    ],
  );
}

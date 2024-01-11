import 'package:flutter/material.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactNameInput(),
              SizedBox(height: 50),
              CreateContactButton()
            ],
          ),
        ),
      ),
    );
  }
}

class CreateContactButton extends StatelessWidget {
  const CreateContactButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}

class ContactNameInput extends StatelessWidget {
  const ContactNameInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

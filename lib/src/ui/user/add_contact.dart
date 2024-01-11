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
        child: Row(
          children: [
            // SizedBox(width: 10),
            Text('Name'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.avatar,
  });

  final String name;
  final String email;
  final String phoneNumber;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _userProfile(avatar, name, email, phoneNumber),
        _userContactButton(),
        const Divider(color: Colors.black),
      ],
    );
  }
}

Widget _userContactButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: () {
          debugPrint('Received Call Click');
        },
        child: const Text('Call'),
      ),
    ],
  );
}

Widget _userProfile(avatar, name, email, phoneNumber) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: avatar == null
              ? const Text('No Image')
              : Image.network(avatar, width: 50, height: 50),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(name), Text(email), Text('+65 $phoneNumber')],
      ),
    ],
  );
}

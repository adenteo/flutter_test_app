import 'dart:ffi';

import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.phoneNumber,
  });

  final String name;
  final String email;
  final String avatarUrl;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _userProfile(avatarUrl, name, email, phoneNumber),
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
          debugPrint('Received click');
        },
        child: const Text('Call'),
      ),
    ],
  );
}

Widget _userProfile(avatarUrl, name, email, phoneNumber) {
  // bool isAvatarUrlNull = avatarUrl == null;
  // debugPrint(isAvatarUrlNull.toString());
  debugPrint(avatarUrl);
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: avatarUrl != null
              ? Image.network(
                  avatarUrl,
                  height: 50.0,
                  width: 50.0,
                  fit: BoxFit.cover,
                )
              : const Text('No Image'),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(name), Text(email), Text('+65 $phoneNumber')],
      ),
    ],
  );
}

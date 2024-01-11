import 'package:flutter/material.dart';

class UserContactItem extends StatelessWidget {
  const UserContactItem({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  final String name;
  final String email;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _UserProfile(avatarUrl: avatarUrl, name: name, email: email),
        _UserContactButton(),
        const Divider(color: Colors.black),
      ],
    );
  }
}

class _UserContactButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}

class _UserProfile extends StatelessWidget {
  const _UserProfile({
    required this.avatarUrl,
    required this.name,
    required this.email,
  });

  final String avatarUrl;
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              avatarUrl,
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            Text(email),
          ],
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:flutter_test_app/src/ui/user/add_edit_user_item.dart';
import 'package:url_launcher/url_launcher.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phoneNumber,
    this.avatar,
  });

  final int id;
  final String fName;
  final String lName;
  final String email;
  final String phoneNumber;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _userProfile(avatar, fName, lName, email, phoneNumber),
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditUserItem(
                                action: "Edit",
                                user: User(
                                  id: id,
                                  firstName: fName,
                                  lastName: lName,
                                  email: email,
                                  avatar: avatar,
                                  phoneNumber: phoneNumber,
                                ))),
                      )
                    },
                icon: const Icon(Icons.edit)),
          ],
        ),
        _userContactButton(phoneNumber),
        const Divider(color: Colors.black),
      ],
    );
  }
}

Widget _userContactButton(String phoneNumber) {
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
        onPressed: () async {
          final Uri phoneLaunchUri = Uri(
            scheme: 'tel',
            path: '+65 $phoneNumber',
          );
          if (await canLaunchUrl(phoneLaunchUri)) {
            await launchUrl(phoneLaunchUri);
          } else {
            throw 'Could not launch $phoneLaunchUri';
          }
        },
        child: const Text('Call'),
      ),
    ],
  );
}

Widget _userProfile(avatar, fName, lName, email, phoneNumber) {
  bool isNetworkImage(String? imagePath) {
    return imagePath != null &&
        (imagePath.startsWith('http://') || imagePath.startsWith('https://'));
  }

  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: avatar == null
              ? const SizedBox(
                  width: 50, height: 50, child: Center(child: Text('No Image')))
              : isNetworkImage(avatar)
                  ? Image.network(avatar,
                      width: 50, height: 50, fit: BoxFit.cover)
                  : Image.file(File(avatar),
                      width: 50, height: 50, fit: BoxFit.cover),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fName + " " + lName),
          Text(email),
          Text('+65 $phoneNumber')
        ],
      ),
    ],
  );
}

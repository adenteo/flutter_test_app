import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/src/blocs/events/user_events.dart';
import 'package:flutter_test_app/src/blocs/user_bloc.dart';
import 'package:flutter_test_app/src/validators/user_validator.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package

class AddUserItem extends StatefulWidget {
  const AddUserItem({super.key});

  @override
  AddUserItemState createState() => AddUserItemState();
}

class AddUserItemState extends State<AddUserItem> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  XFile? _image; // For storing the selected image
  final _formKey = GlobalKey<FormState>();
  static const double inputFieldWidth = 250.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight),
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _contactInput(
                        'First Name*', _fnameController, nameValidator),
                    const SizedBox(height: 10),
                    _contactInput(
                        'Last Name*', _lnameController, nameValidator),
                    const SizedBox(height: 10),
                    _contactInput('Email*', _emailController, emailValidator),
                    const SizedBox(height: 10),
                    _imageUploadSection(),
                    const SizedBox(height: 20),
                    _createContactButton(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageUploadSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [const Text('Image \nUpload'), _imageComponent()],
    );
  }

  Widget _imageComponent() {
    return SizedBox(
      width: inputFieldWidth,
      child: Row(
        children: [
          _image != null
              ? (Image.file(
                  File(_image!.path),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ))
              : const SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(child: Text('No Image'))),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final ImageSource? source = await _showImageSourceDialog(context);
    if (source != null) {
      final XFile? pickedFile = await picker.pickImage(source: source);
      setState(() {
        _image = pickedFile;
      });
    }
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
        if (_formKey.currentState!.validate()) {
          final fName = _fnameController.text;
          final lname = _lnameController.text;
          final email = _emailController.text;

          context
              .read<UserBloc>()
              .add(AddUser(fName, lname, email, _image?.path));
          Navigator.pop(context);
        }
      },
      child: const Text('Create'),
    );
  }

  Widget _contactInput(String label, TextEditingController controller,
      String? Function(String?) validator) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        SizedBox(
          width: inputFieldWidth, // Use the defined width
          child: TextFormField(
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
            ),
          ),
        ),
      ],
    );
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) async {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choose Image Source"),
        actions: [
          TextButton(
            child: const Text("Camera"),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
          TextButton(
            child: const Text("Gallery"),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

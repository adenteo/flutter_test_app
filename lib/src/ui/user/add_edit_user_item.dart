import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/src/blocs/events/user_events.dart';
import 'package:flutter_test_app/src/blocs/user_bloc.dart';
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:flutter_test_app/src/validators/user_validator.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker package

class AddEditUserItem extends StatefulWidget {
  final String action;
  final User? user;

  const AddEditUserItem({super.key, required this.action, this.user});

  @override
  AddEditUserItemState createState() => AddEditUserItemState();
}

class AddEditUserItemState extends State<AddEditUserItem> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _imagePath;
  final _formKey = GlobalKey<FormState>();
  static const double inputFieldWidth = 250.0;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _fnameController.text = widget.user!.firstName!;
      _lnameController.text = widget.user!.lastName!;
      _emailController.text = widget.user!.email!;
      _imagePath = widget.user!.avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.action == 'Add'
            ? 'Add Contact'
            : '${widget.user?.firstName} ${widget.user?.lastName}'),
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
                    _addEditContactButton(context)
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
          _imagePath != null
              ? isNetworkImage(_imagePath)
                  ? Image.network(
                      _imagePath!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(_imagePath!),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
              : const SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(child: Text('No Image')),
                ),
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
        _imagePath = pickedFile?.path;
      });
    }
  }

  Widget _addEditContactButton(BuildContext context) {
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

          context.read<UserBloc>().add(widget.action == "Add"
              ? AddUser(fName, lname, email, _imagePath)
              : EditUser(
                  fName,
                  lname,
                  email,
                  _imagePath,
                ));
          Navigator.pop(context);
        }
      },
      child: Text(widget.action == "Add" ? "Add Contact" : "Save Contact"),
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

bool isNetworkImage(String? imagePath) {
  return imagePath != null &&
      (imagePath.startsWith('http://') || imagePath.startsWith('https://'));
}

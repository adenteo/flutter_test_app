import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      child: const Drawer(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Contact'),
                ],
              ),
            ),
          )),
    );
  }
}

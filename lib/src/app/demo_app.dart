import 'package:flutter/material.dart';
import 'package:flutter_test_app/src/ui/user/add_contact.dart';
import 'package:flutter_test_app/src/ui/user/user_contact_item.dart';

import '../ui/side_panel/side_panel.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Demo App'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip);
        })),
        drawer: const SidePanel(),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContact()),
            );
          },
          tooltip: 'Add Contact',
          child: const Icon(Icons.add),
        ),
        body: const CustomScrollView(slivers: [
          SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                  UserContactItem(
                      name: 'aden',
                      email: 'adenteo@gmail.com',
                      avatarUrl: 'https://picsum.photos/250?image=9'),
                ],
              ))
        ]));
  }
}

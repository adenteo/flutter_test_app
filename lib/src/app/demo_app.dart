import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app/src/blocs/events/user_events.dart';
import 'package:flutter_test_app/src/blocs/user_bloc.dart';
import 'package:flutter_test_app/src/blocs/states/user_states.dart';
import 'package:flutter_test_app/src/models/request/users_request.dart';
import 'package:flutter_test_app/src/ui/user/add_user_item.dart';
import 'package:flutter_test_app/src/ui/user/user_item.dart';
// import 'package:flutter_test_app/api/get_users_api.dart';

import '../ui/side_panel/side_panel_item.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()..add(FetchUsers()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const HomePage(title: 'Demo App'),
      ),
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
              MaterialPageRoute(builder: (context) => const AddUserItem()),
            );
          },
          tooltip: 'Add Contact',
          child: const Icon(Icons.add),
        ),
        body: _blocBody());
  }
}

Widget _blocBody() {
  return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
    if (state is UserInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is UserLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is UserLoaded) {
      return _userScrollList(state.users);
    } else if (state is UserError) {
      return const Center(child: Text('Error'));
    }
    return Container();
  });
}

Widget _userScrollList(List<User> users) {
  return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserItem(
            name: '${users[index].firstName} ${users[index].lastName}',
            email: '${users[index].email}',
            avatarUrl: '${users[index].avatar}',
            phoneNumber: '${users[index].phoneNumber}');
      });
}

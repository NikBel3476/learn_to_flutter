import 'package:flutter/material.dart';
import 'package:flutter_learning/widgets/lazy_users_list.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: const LazyUsersList()
    );
  }
}
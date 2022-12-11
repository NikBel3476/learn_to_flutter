import 'package:flutter/material.dart';
import 'package:flutter_learning/widgets/LazyAlbumList.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users page'),
      ),
      body: const LazyAlbumList()
    );
  }
}
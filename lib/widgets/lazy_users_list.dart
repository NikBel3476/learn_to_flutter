import 'package:flutter/material.dart';
import 'package:flutter_learning/models/user.dart';
import 'package:flutter_learning/widgets/user_list_item.dart';

import '../utils/services/api/api_user_service.dart';

class LazyUsersList extends StatefulWidget {
  const LazyUsersList({ super.key });

  @override
  State<LazyUsersList> createState() => _LazyUsersListState();
}

class _LazyUsersListState extends State<LazyUsersList> {
  final ScrollController _controller = ScrollController();

  final _users = <User>[];
  int _page = 1;
  bool _isLoading = true;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
    _fetchUsers();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onScroll() {
    if (
    _controller.offset >= _controller.position.maxScrollExtent
        && !_controller.position.outOfRange
    ) {
      setState(() {
        _isLoading = true;
      });
      _fetchUsers();
    }
  }

  void _fetchUsers() async {
    final users = await fetchUsers(page: _page);
    setState(() {
      if (users.isNotEmpty) {
        _page++;
      }
      _users.addAll(users);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        itemCount: _isLoading ? _users.length + 1 : _users.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i == _users.length) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }

          return Container(
              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: UserListItem(user: _users[i])
          );
        }
    );
  }
}
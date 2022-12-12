import 'dart:convert';

import '../../../constants/api_path.dart';
import '../../../models/user.dart';

import 'package:http/http.dart' as http;

Future<User> fetchUser(int id) async {
  final response = await http.get(Uri.parse('$host/users/$id'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

Future<List<User>> fetchUsers({ int page = 1, int limit = 5 }) async {
  final response = await http.get(Uri.parse('$host/users?_page=$page&_limit=$limit'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((user) => User.fromJson(user))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}
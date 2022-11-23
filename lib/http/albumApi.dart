import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Album.dart';

const host = 'https://jsonplaceholder.typicode.com';

Future<Album> fetchAlbum(int id) async {
  final response = await http
      .get(Uri.parse('$host/albums/$id'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<Album>> fetchAlbums({ int page = 1, int limit = 20 }) async {
  final response = await http
      .get(Uri.parse('$host/albums?_page=1&_limit=20'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((album) => Album.fromJson(album))
        .toList();
  } else {
    throw Exception('Failed to load albums');
  }
}
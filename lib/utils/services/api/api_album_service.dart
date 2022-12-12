import 'dart:convert';

import '../../../constants/api_path.dart';
import '../../../models/album.dart';

import 'package:http/http.dart' as http;

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
      .get(Uri.parse('$host/albums?_page=$page&_limit=$limit'));

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
        .map((album) => Album.fromJson(album))
        .toList();
  } else {
    throw Exception('Failed to load albums');
  }
}
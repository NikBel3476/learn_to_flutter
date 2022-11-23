import 'package:flutter/material.dart';

import '../http/albumApi.dart';
import '../models/Album.dart';

class AlbumList extends StatefulWidget {
  const AlbumList({ super.key });

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  late Future<List<Album>> _albums;

  final int _page = 1;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _albums = fetchAlbums(page: _page, limit: _limit);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
      future: _albums,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, i) {
                return Container(
                    margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(
                        title: Text(
                          snapshot.data![i].title,
                          style: const TextStyle(fontSize: 18.0),
                        ),
                        trailing: const Icon(
                          Icons.add_chart,
                          color: Colors.black38,
                          semanticLabel: 'Label',
                        )
                    )
                );
              }
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(
            child: CircularProgressIndicator()
        );
      },
    );
  }
}
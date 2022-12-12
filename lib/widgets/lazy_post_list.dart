import 'package:flutter/material.dart';

import '../utils/services/api/api_album_service.dart';
import '../models/album.dart';

class LazyAlbumList extends StatefulWidget {
  const LazyAlbumList({ super.key });

  @override
  State<LazyAlbumList> createState() => _LazyAlbumListState();
}

class _LazyAlbumListState extends State<LazyAlbumList> {
  final ScrollController _controller = ScrollController();

  final _albums = <Album>[];
  int _page = 1;
  bool _isLoading = true;

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
    _fetchAlbums();
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
      _fetchAlbums();
    }
  }

  void _fetchAlbums() async {
    final albums = await fetchAlbums(page: _page);
    setState(() {
      if (albums.isNotEmpty) {
        _page++;
      }
      _albums.addAll(albums);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        itemCount: _isLoading ? _albums.length + 1 : _albums.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i == _albums.length) {
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
              child: ListTile(
                  title: Text(
                    _albums[i].title,
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
  }
}
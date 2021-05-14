import 'package:flutter/material.dart';
import 'package:flutter_gallery/provider/gallery_provider.dart';
import 'package:provider/provider.dart';

class ConnectionIndicator extends StatefulWidget {
  @override
  _ConnectionIndicatorState createState() => _ConnectionIndicatorState();
}

class _ConnectionIndicatorState extends State<ConnectionIndicator> {
  @override
  Widget build(BuildContext context) {
    final _connection = Provider.of<GalleryProvider>(context).internetConnection;
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Icon(Icons.signal_cellular_connected_no_internet_4_bar_sharp,
      color: Colors.red.withAlpha(_connection ? 0 : 250)),
    );
  }
}

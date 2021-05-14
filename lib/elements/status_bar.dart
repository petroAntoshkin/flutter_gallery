import 'package:flutter/material.dart';
import 'package:flutter_gallery/provider/gallery_provider.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatefulWidget {
  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
          child: Text(
            Provider.of<GalleryProvider>(context).statusText,
          ),
      ),
    );
  }
}

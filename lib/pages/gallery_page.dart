import 'package:flutter/material.dart';
import 'package:flutter_gallery/elements/connection_indicator.dart';
import 'package:flutter_gallery/elements/images_grid.dart';
import 'package:flutter_gallery/elements/status_bar.dart';
import 'package:flutter_gallery/provider/gallery_provider.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> _pictures =
        Provider.of<GalleryProvider>(context).allPictures;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              ConnectionIndicator(),
              Expanded(child: Container(child: Center(child: Text('Gallery test app')))),
              ConnectionIndicator(),
            ],
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: _pictures == null || _pictures.length == 0
              ? CircularProgressIndicator()
              : ImagesGrid(pictures: _pictures),
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //   height: 40.0,
      //   width: MediaQuery.of(context).size.width,
      //   child: StatusBar(),
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gallery/components/net_image_viewer.dart';
import 'package:flutter_gallery/pages/image_view_page.dart';
import 'package:flutter_gallery/provider/gallery_provider.dart';
import 'package:provider/provider.dart';

class OneImageBox extends StatelessWidget {
  final String url;

  OneImageBox({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      margin: EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => url.isNotEmpty
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ImageViewPage(
                        url: url,
                        manager:
                            Provider.of<GalleryProvider>(context).cashManager)))
            : null,
        child: url.isNotEmpty ? NetImageViewer(
          url: url,
          manager:
              Provider.of<GalleryProvider>(context, listen: false).cashManager,
        )
        : Image.asset('assets/empty.png'),
      ),
    );
  }
}

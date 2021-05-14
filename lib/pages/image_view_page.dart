import 'package:flutter/material.dart';
import 'package:flutter_gallery/components/net_image_viewer.dart';
import 'package:flutter_gallery/managers/cash_manager.dart';
import 'package:share_plus/share_plus.dart';

class ImageViewPage extends StatelessWidget {
  final String url;
  final CashManager manager;

  ImageViewPage({@required this.url, @required this.manager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(manager.getFileNameFromUrl(url))),
        actions: [
          TextButton(
            onPressed: () => Share.shareFiles([manager.getCashedFilePathFromUrl(url)]),
            child: Icon(
                Icons.share,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: NetImageViewer(
          url: url,
          manager: manager,
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gallery/managers/cash_manager.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class NetImageViewer extends StatelessWidget {

  final String url;
  final CashManager manager;
  NetImageViewer({@required this.url, @required this.manager});

  @override
  Widget build(BuildContext context) {
    bool _fileCashed = manager.isFileExist(url);
    return Container(
      child: _fileCashed
          ? Stack(
        children: [
          Image.file(manager.getCashFileFromUrl(url)),
          Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.check,color: Colors.green,size: 12.0,)
          ),
        ],
      )
          : Image(
        fit: BoxFit.cover,
        image: NetworkToFileImage(
            url: url,
            file: manager.getCashFileFromUrl(url),
            debug: false),
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          else if (loadingProgress.cumulativeBytesLoaded ==
              loadingProgress.expectedTotalBytes)
            manager.addFileToCashList(url);
          return Center(
            child: LinearProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }
}

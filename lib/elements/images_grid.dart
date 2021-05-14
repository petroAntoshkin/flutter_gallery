import 'package:flutter/material.dart';
import 'one_image_box.dart';

class ImagesGrid extends StatelessWidget {

  ImagesGrid({@required this.pictures});
  final List<String> pictures;
  final _columnsCount = 2;
  final _rowsCount = 5;

  @override
  Widget build(BuildContext context) {
    const PADDING = 4.0;
    final _gridItemHeight = (MediaQuery.of(context).size.height - Scaffold.of(context).appBarMaxHeight) /
        _rowsCount;
    final _gridItemWidth = MediaQuery.of(context).size.width / _columnsCount - PADDING;
    return Padding(
      padding: const EdgeInsets.all(PADDING),
      child: ListView(
        children: [
          for (int i = 0; i < pictures.length; i += 2)
            Row(
              children: [
                SizedBox(
                  width: _gridItemWidth,
                  height: _gridItemHeight,
                  child: OneImageBox(
                    url: pictures[i],
                  ),
                ),
                SizedBox(
                  width: _gridItemWidth,
                  height: _gridItemHeight,
                  child: OneImageBox(
                    url: pictures[i + 1],
                  ),
                ),
              ],
            ),
          Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('end of story :('),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

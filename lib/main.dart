import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/gallery_page.dart';
import 'provider/gallery_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GalleryProvider(),
      child: Consumer<GalleryProvider>(
          builder: (context, GalleryProvider notifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: GalleryPage(),
            );
          }),
    );
  }
}

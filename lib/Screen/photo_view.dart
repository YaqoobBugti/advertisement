import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
class PhotoViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    child: PhotoViewGallery.builder(
      itemCount: 2,
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage('images/yaqoob.jpg'),
          initialScale: PhotoViewComputedScale.contained * 0.8,
        );
      },
    )
  );
  }
}
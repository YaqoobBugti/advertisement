import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class HeroImage extends StatelessWidget {
  final String image;
  final bool imageType;
 
  HeroImage({@required  this.image,@required  this.imageType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Hero(
            tag: "image",
            child: Container(
              width: double.infinity,
              height: 400.0,
              alignment: Alignment.topCenter,
              child: PhotoView(
                imageProvider:imageType?NetworkImage(image):AssetImage(image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

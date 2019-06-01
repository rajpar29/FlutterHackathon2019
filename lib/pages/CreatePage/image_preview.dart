import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  File photoImage;
  BuildContext context;

  ImagePreview({@required this.photoImage, @required this.context});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.white,
            title: Text(
              'Image Preview',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                width: double.infinity,
                child: PhotoView(
                  imageProvider: FileImage(photoImage),
                ),
              ),
//              IconButton(
//                  icon: Icon(Icons.clear),
//                  iconSize: 30.0,
//                  color: Colors.white,
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  })
            ],
          ),
        ));
  }
}

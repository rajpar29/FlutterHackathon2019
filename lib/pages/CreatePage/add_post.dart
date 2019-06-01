import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import './image_preview.dart';
import './utils.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
    final databaseReference = FirebaseDatabase.instance.reference();

  @override
  State<StatefulWidget> createState() {
    return AddPostState();
  }
}

class AddPostState extends State<AddPost> with AutomaticKeepAliveClientMixin {
  TextEditingController _messageController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  List<File> imageList = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: CachedNetworkImage(
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          imageUrl:
                              'https://image.flaticon.com/icons/png/512/149/149071.png' ??
                                  '',
                          placeholder: (BuildContext context, String str) {
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/icons/Avatar_male.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Hiral Pancholi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   'Title:',
                        //   style: TextStyle(
                        //       fontSize: 16.0,
                        //       color: Colors.blue,
                        //       fontStyle: FontStyle.normal,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter title";
                            }
                          },
                          controller: _titleController,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey.shade800),
                          textAlign: TextAlign.justify,
                          enableInteractiveSelection: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          maxLengthEnforced: true,
                          maxLength: 100,
                          decoration: InputDecoration(
                            hintText: 'Write Title here..',
                            counterText: '',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   'Description:',
                        //   style: TextStyle(
                        //       fontSize: 16.0,
                        //       color: Colors.blue,
                        //       fontStyle: FontStyle.normal,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter description";
                            }
                          },
                          controller: _messageController,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey.shade800),
                          textAlign: TextAlign.justify,
                          enableInteractiveSelection: false,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Write description here.. \n\n\n\n\n',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Text(
                        //   'Link:',
                        //   style: TextStyle(
                        //       fontSize: 16.0,
                        //       color: Colors.blue,
                        //       fontStyle: FontStyle.normal,
                        //       fontWeight: FontWeight.w500),
                        // ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter link";
                            }
                          },
                          controller: _linkController,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.grey.shade800),
                          textAlign: TextAlign.justify,
                          enableInteractiveSelection: false,
                          keyboardType: TextInputType.multiline,
                          maxLengthEnforced: true,
                          decoration: InputDecoration(
                            hintText: 'Add link here..',
                            counterText: '',
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildGridView())
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          loadImagesCamera().then((onValue) {
                            setState(() {
                              imageList.add(onValue);
                            });
                            if (!mounted) return;
                          });
                        },
                        child: Icon(
                          Icons.photo_camera,
                          size: 28,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          loadImagesGallery().then((onValue) {
                            setState(() {
                              imageList.add(onValue);
                            });
                            if (!mounted) return;
                          });
                        },
                        icon: Icon(
                          Icons.image,
                          size: 28,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    publish();
                  },
                  child: Icon(
                    Icons.send,
                    size: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(imageList.length, (index) {
        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ImagePreview(
                    photoImage: imageList[index],
                    context: context,
                  );
                }));
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(0.0),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white)),
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(style: BorderStyle.none)),
                  child: Image.file(
                    imageList[index],
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              child: IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.redAccent,
                  ),
                  onPressed: () async {
                    setState(() {
                      imageList.removeAt(index);
                    });
                  }),
            ),
          ],
        );
      }
    ));
  }
  publish(){
     widget.databaseReference.child('feeds').push().set({
      "title": _titleController.text.trim(),
      "description": _messageController.text.trim(),
      "link":_linkController.text.trim()
    }).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  bool get wantKeepAlive => true;
}

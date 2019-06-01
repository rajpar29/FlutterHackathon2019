import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_hack/pages/CreatePage/add_post.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FeedPage extends StatefulWidget {
  List feeds;
  final databaseReference =
      FirebaseDatabase.instance.reference().child("feeds");
  int count = 0;

  FeedPage() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print('${snapshot.value}');
    });
  }
  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feeds"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPost()));
            },
          )
        ],
      ),
      body: FirebaseAnimatedList(
          query: widget.databaseReference,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return _buildItem(snapshot.value);
          }),
    );
  }

  _buildItem(data) {
    return Card(
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
              aspectRatio: (16.0 / 9.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        data["imageLink"]
                      ),
                      alignment: Alignment.center),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: CachedNetworkImage(
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                        imageUrl:
                            'https://image.flaticon.com/icons/png/512/149/149071.png' ??
                                '',
                        placeholder: (BuildContext context, String str) {
                          return Container(
                            width: 35,
                            height: 35,
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
                            fontSize: 14.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                Text('2 mins ago',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
            child: Text(data["title"],
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(data["description"],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.thumb_up,
                        color: widget.count > 0 ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.count++;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                        '${widget.count} ${widget.count > 0 ? 'Likes' : 'Like'}'),
                  ),
                ],
              ),
              IconButton(
                  icon: Icon(
                    Icons.insert_comment,
                    color: Colors.blue,
                  ),
                  onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}

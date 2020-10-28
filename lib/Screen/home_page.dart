import 'package:advertisement/Screen/edit_post.dart';
import 'package:advertisement/Screen/hero_image.dart';
import 'package:advertisement/modles/post_file_modle.dart';
import 'package:advertisement/providers/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;
  List<PostFileModle> postFileList = [];
  Widget postFunction({
    @required context,
    @required Function edit,
    @required Function delete,
    @required String image,
    String tag,
    String tag2,
    @required String title,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[500],
              offset: Offset(1.0, 1.0),
              blurRadius: 5.0,
              spreadRadius: 1.0),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-1.0, -1.0),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroImage(
                              imageType: false,
                              image: "images/yaqoob.jpg",
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: tag2,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black38,
                          backgroundImage: AssetImage('images/yaqoob.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Admin",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('1 minute ago'),
                      ],
                    ),
                  ],
                ),
                user != null
                    ? PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            child: InkWell(
                              child: Text("Edit"),
                              onTap: edit,
                            ),
                          ),
                          PopupMenuItem(
                            child:
                                InkWell(child: Text("Delete"), onTap: delete),
                          ),
                        ],
                      )
                    : Text(""),
              ],
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 19, color: Colors.black),
          ),
          SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HeroImage(
                    imageType: true,
                    image: image,
                  ),
                ),
              );
            },
            child: Hero(
              tag: tag,
              child: Container(
                height: 290,
                color: Colors.blueGrey,
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getPostData();
    postFileList = provider.throwPostData;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
                children: postFileList
                    .map(
                      (e) => postFunction(
                        edit: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => EditPost(
                                productId: e.productId,
                              ),
                            ),
                          );
                        },
                        delete: () {
                          provider.deleteFunction(
                            productId: e.productId,
                          );
                        },
                        context: context,
                        image: e.image,
                        title: e.massage,
                        tag: e.massage,
                        tag2: e.image,
                      ),
                    )
                    .toList()),
          ],
        ),
      ),
    );
  }
}

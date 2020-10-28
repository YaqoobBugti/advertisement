import 'dart:io';
import 'package:advertisement/Screen/tab_bars.dart';
import 'package:advertisement/providers/my_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;

class EditPost extends StatefulWidget {
  final String productId;
  EditPost({@required this.productId});
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController title = TextEditingController();
  File _image;
  bool delete = false;
  bool imagetrue = true;
  String imageUrl;
  Future<String> uploadImage(File _image) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot task = await uploadTask.onComplete;
    final String _imageUrl = await task.ref.getDownloadURL();
    return _imageUrl;
  }

  Future<void> getimage(ImageSource imageSource) async {
    var saveImage = await ImagePicker().getImage(source: imageSource);
    setState(() {
      _image = File(saveImage.path);
      imagetrue = false;
    });
  }

  Future<void> aleart() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    getimage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: Text("Gallery"),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  onTap: () {
                    getimage(ImageSource.camera);
                  },
                  child: Text("Camera"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: KeyboardDismisser(
        gestures: [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection,
        ],
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Material(
                      elevation: 3.0,
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                      child: TextField(
                        controller: title,
                        maxLines: 10,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          height: 360,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imagetrue
                                  ? NetworkImage(
                                      'https://www.polytec.com.au/img/products/140-140/white-magnetic.jpg')
                                  : _image == null
                                      ? NetworkImage(
                                          'https://www.polytec.com.au/img/products/140-140/white-magnetic.jpg')
                                      : FileImage(_image),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 3),
                                color: Colors.grey,
                              )
                            ],
                          ),
                          child: imagetrue
                              ? IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 100,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    aleart();
                                  },
                                )
                              : Text('')),
                      imagetrue
                          ? Text("")
                          : PopupMenuButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              itemBuilder: (_) => [
                                PopupMenuItem(
                                  child: InkWell(
                                    child: Text("Edit"),
                                    onTap: () {
                                      aleart();
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: InkWell(
                                    child: Text("Delete"),
                                    onTap: () {
                                      setState(() {
                                        imagetrue = true;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      imageUrl = await uploadImage(_image);
                      var navigator = myProvider.editFunction(
                        image: imageUrl,
                        title: title,
                        context: context,
                        productId: widget.productId,
                      );
                      if (navigator != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => TabBars(),
                          ),
                        );
                      }
                    },
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.send,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

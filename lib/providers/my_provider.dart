import 'package:advertisement/modles/post_file_modle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  var user = FirebaseAuth.instance.currentUser;

  Future mailFuction({
    @required TextEditingController title,
    context,
    @required String image,
  }) async {
    try {
      var queay = FirebaseFirestore.instance.collection('Post').doc();
      queay.set({
        'productId': queay.id,
        'userId': user.uid,
        'Massage': title.text,
        'Image': image,
      });
    } catch (error) {
      throw error;
    }
  }

    Future editFunction({
    @required TextEditingController title,
    context,
    @required String image,
    @required String productId,
  }) async {
    try {
      var queay = FirebaseFirestore.instance.collection('Post').doc(productId);
      queay.update({
        'productId': queay.id,
        'userId': user.uid,
        'Massage': title.text,
        'Image': image,
      });
    } catch (error) {
      throw error;
    }
  }
  // Future editFunction({
  //   @required TextEditingController title,
  //   context,
  //   @required String image,
  // }) async {
  //   try {
  //     var queay = FirebaseFirestore.instance.collection('Post').doc();
  //     queay.update({
  //       'productId': queay.id,
  //       'userId': user.uid,
  //       'Massage': title.text,
  //       'Image': image,
  //     });
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<void> deleteFunction({String productId}) async {
    await FirebaseFirestore.instance.collection('Post').doc(productId).delete();
  }

////////////////////////get Firebase Data ///////////////////////////////
  UserCredential authResult;

  List<PostFileModle> postFileModleList = [];

  PostFileModle postFileModle;

  Future<void> getPostData() async {
    List<PostFileModle> postFileModleNewList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Post').get();
    querySnapshot.docs.forEach(
      (element) {
        postFileModle = PostFileModle(
          productId: element.data()['productId'],
          image: element.data()['Image'],
          userId: element.data()['userId'],
          massage: element.data()['Massage'],
        );
        postFileModleNewList.add(postFileModle);
      },
    );
    postFileModleList = postFileModleNewList;
    notifyListeners();
  }

  get throwPostData {
    return postFileModleList;
  }

////////////////////////////////// geted ////////////////////////////////////////

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);

  get throwGlobleKey {
    return globalKey;
  }

  Future loginAuth({
    @required TextEditingController email,
    @required TextEditingController password,
    @required context,
  }) async {
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Wrong password provided for that user.'),
          ),
        );
      }
    }
  }

  void loginValidation({
    @required TextEditingController email,
    @required TextEditingController password,
    @required context,
  }) {
    if (email.text.trim().isEmpty ||
        email.text.trim() == null && password.text.trim().isEmpty ||
        password.text.trim() == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('All Fields is Empty'),
        ),
      );
      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('email is Empty'),
        ),
      );
      return;
    } else if (!regex.hasMatch(email.text)) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please Enter Valid Email'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is Empty'),
        ),
      );
      return;
    } else if (password.text.length < 8) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is too short'),
        ),
      );
    } else {
      loginAuth(
        context: context,
        email: email,
        password: password,
      );
    }
  }
}

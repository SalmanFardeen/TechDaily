import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techdaily/services/firebase_signin.dart';

class ContentDetailsWebview extends StatefulWidget {
  final String url;
  final int id;
  ContentDetailsWebview({this.url, this.id});

  @override
  _ContentDetailsWebviewState createState() => _ContentDetailsWebviewState();
}

class _ContentDetailsWebviewState extends State<ContentDetailsWebview> {
  String email = 'no user';
  // ? FirebaseAuth.instance.currentUser.email
  //  "no user";
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseSignIn>(context, listen: false);

    // if (FirebaseAuth.instance.currentUser?.uid != null) {
    //   email = FirebaseAuth.instance.currentUser.email;
    // }

    print('email:' + email);
    return Scaffold(
      appBar: AppBar(
        title: Text('TechDaily'),
        backgroundColor: Colors.black,
        actions: [
          email == 'no user'
              ? IconButton(
                  onPressed: () {
                    provider.googleLogin().then((value) {
                      if (FirebaseAuth.instance.currentUser?.uid != null) {
                        setState(() {
                          email = FirebaseAuth.instance.currentUser.email;
                        });
                      }
                    });
                  },
                  icon: Icon(Icons.favorite_border))
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users-favorite-news')
                      .doc(FirebaseAuth.instance.currentUser.email)
                      .collection('cid')
                      .where('content-id', isEqualTo: widget.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Text('');
                    }
                    return IconButton(
                      onPressed: () {
                        snapshot.data.docs.length == 0
                            ? addToFavorites()
                            : removeFromFavorites();
                      },
                      icon: snapshot.data.docs.length == 0
                          ? Icon(Icons.favorite_border_outlined)
                          : Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                    );
                  }),
          IconButton(
              onPressed: () => Share.share(widget.url), icon: Icon(Icons.share))
        ],
      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: true,
        resizeToAvoidBottomInset: true,
        useWideViewPort: true,
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Please Wait.....'),
          ),
        ),
      ),
    );
  }

  Future addToFavorites() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favorite-news");
    return _collectionRef
        .doc(currentUser.email)
        .collection('cid')
        .doc(widget.id.toString())
        .set({
      "content-id": widget.id,
    }).then((value) => print("Added to favorite"));
  }

  Future removeFromFavorites() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-favorite-news");
    return _collectionRef
        .doc(currentUser.email)
        .collection('cid')
        .doc(widget.id.toString())
        .delete()
        .then((value) => print("Added to favorite"));
  }

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      email = FirebaseAuth.instance.currentUser.email;
    }
  }
}

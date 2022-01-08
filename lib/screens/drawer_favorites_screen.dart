import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techdaily/models/TechDailyContent.dart';
import 'package:techdaily/widgets/content_list_widget.dart';
import 'package:http/http.dart' as http;

class FavoritesScreen extends StatelessWidget {
  ScrollController _fullController = ScrollController();
  Object redrawObject;
  List favoritesId = [];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshFavorites,
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: SafeArea(
            child: CustomScrollView(
              controller: _fullController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  title: GestureDetector(
                    onTap: () => _scrollToTop(),
                    child: Text(
                      'Favorites',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    // child: ListView.builder(
                    //     key: ValueKey<Object>(redrawObject),
                    //     itemCount: favorites.length,
                    //     itemBuilder: (context,index){
                    //       return ContentList(
                    //         title: favorites[index].title,
                    //       );
                    //
                    // }),
                    child: Text('Users Favorites'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshFavorites() async {}

  void _scrollToTop() {
    _fullController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    // _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }



  Future<List<dynamic>> getFavoritesId() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favorite-news");
    await _collectionRef
        .doc(currentUser.email)
        .collection("cid")
        .get()
        .then((value) {
      print('value: ' + value.docs.toString());
      value.docs.forEach((element) {
        print('element ' + element.data()['search']);
        favoritesId.add(element.data()['content-id']);
      });
    });

    return favoritesId;
  }


  // Future<List<TechDailyContent>> getFavorites(String queryTitle) async
  //   var client = http.Client();
  //   try {
  //     var response = await client.get(Uri.parse(
  //         'https://techdailyapi.herokuapp.com/contents/search/title/' +
  //             favoritesId.single));
  //
  //     if (response.statusCode == 200) {
  //       print("'/contents' endpoint statusCode: 200");
  //       var jsonString = response.body;
  //
  //       Map<String, dynamic> jsonMap = json.decode(jsonString);
  //       // print(jsonMap['results']);
  //
  //       List results = jsonMap['results'];
  //       // print(results);
  //       //print("fetched 'contents' list length: " + results.length.toString());
  //
  //       // print('this is the result:'+results.toString()+results.length.toString());
  //       return results
  //           .map((content) => TechDailyContent.fromJson(content))
  //           .toList();
  //
  //     }
  //     else
  //       print('error no response');
  //   } catch (e) {
  //     print('error:' + e.toString());
  //     return null;
  //   }
  //
  // }


}

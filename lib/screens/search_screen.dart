import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techdaily/models/TechDailyContent.dart';
import 'package:techdaily/services/firebase_manager.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends SearchDelegate<String> {
  List<TechDailyContent> contentTitles;

  SearchScreen(this.contentTitles);

  // AnimationController controller;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black45),
        hintColor: Colors.white,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.white30,
          cursorColor: Colors.white,
        ),
        textTheme: TextTheme(headline6: TextStyle(color: Colors.white)));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  // @override
  // void initState() {
  //   controller = AnimationController(duration: Duration(microseconds: 1000));
  //   controller.forward();
  // }

  @override
  Widget buildLeading(BuildContext context) {
    // return IconButton(onPressed: () => close(context, null), icon: AnimatedIcon(
    //   icon: AnimatedIcons.menu_arrow,
    //   progress: controller,
    // ));
    return IconButton(
        onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) addToRecentSearches();
    return Container(
      child: Center(child: Text(query)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      Future<List<dynamic>> getRecentSearches() async {
        List recentSearches = [];
        var currentUser = FirebaseAuth.instance.currentUser;

        CollectionReference _collectionRef =
            FirebaseFirestore.instance.collection("users-recent-searches");
        await _collectionRef
            .doc(currentUser.email)
            .collection("recent-searches")
            .get()
            .then((value) {
          print('value: '+value.docs.toString());
          value.docs.forEach((element) {
            print('element '+element.data()['search']);
            recentSearches.add(element.data()['search']);
          });
           print(recentSearches.length);
        });

        return recentSearches;

      }

      return FutureBuilder(
          future: getRecentSearches(),
          builder: (context, snapshot) {
            print('snapshot '+snapshot.data.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Failed to Load Data'));
            }

            final suggestionList = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                onTap: () => showResults(context),
                leading: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                title: Text(suggestionList[index]),
              ),
              itemCount: suggestionList.length,
            );
          });
    }

    else{
      Future<List<TechDailyContent>> getContentTitles(String queryTitle) async {
        var client = http.Client();
        try {
          var response = await client
              .get(Uri.parse('https://techdailyapi.herokuapp.com/contents/search/title/'+queryTitle));

          if (response.statusCode == 200) {
            print("'/contents' endpoint statusCode: 200");
            var jsonString = response.body;

            Map<String, dynamic> jsonMap = json.decode(jsonString);
            // print(jsonMap['results']);

            List results = jsonMap['results'];
            print(results);
            //print("fetched 'contents' list length: " + results.length.toString());

            return results
                .map((content) => TechDailyContent.fromJson(content))
                .toList();
          }
        } catch (e) {
          print('error:' + e.toString());
        }
        return null;
      }

      return FutureBuilder(
          future: getContentTitles(query),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Failed to Load Data'));
            }

            final List<TechDailyContent> suggestionList = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                onTap: () => showResults(context),
                leading: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                title: Text(suggestionList[index].title),
              ),
              itemCount: suggestionList.length,
            );
          });
    }
  }

  Future addToRecentSearches() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-recent-searches");
    return _collectionRef
        .doc(currentUser.email)
        .collection('recent-searches')
        .doc()
        .set({"search": query}).then(
            (value) => print("Added to recent search"));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:techdaily/models/TechDailyContent.dart';
import 'package:techdaily/models/api_owner_model.dart';
import 'package:techdaily/models/content.dart';
import 'package:techdaily/services/api_manager.dart';
import 'package:techdaily/services/api_owner_manager.dart';
import 'package:techdaily/widgets/chips_filter_widget.dart';
import 'package:techdaily/widgets/content_list_widget.dart';
import '../data/dummy_content.dart';
import 'package:intl/intl.dart';

class ContentListScreen extends StatefulWidget {
  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  Future<List<TechDailyContent>> _techDailyApi;
  Future<List<TechDailyOwner>> _techDailyOwner;
  List<Content> contents = [];
  bool isSorted = true;
  List<String> chipsLabels = [];
  List<Content> allContents = DUMMY_CONTENTS.toList();

  @override
  Widget build(BuildContext context) {
    print('Widget building');
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: FutureBuilder<List<TechDailyOwner>>(
                  future: _techDailyOwner,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ChipFilter(
                            owner: snapshot.data[index].name,
                            onSelect: () {
                              print('onSelect'+index.toString());
                              // handleOnselect(index);
                            },
                            onUnselect: () {
                              print('onUnSelect'+index.toString());
                             // handleUnselect(index);
                            },
                          );
                        },
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              FutureBuilder<List<TechDailyContent>>(
                  future: _techDailyApi,
                  builder: (context, snapshot) {
                    print("snapshot owner: "+snapshot.toString());
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ContentList(
                            title: snapshot.data[index].title,
                            img: snapshot.data[index].imgUrl,
                            uploadTime: snapshot.data[index].pubDate,
                            owner: snapshot.data[index].owner.toString(),
                            url: snapshot.data[index].url,
                          );
                        },
                      );
                    } else
                      return Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Center(child: CircularProgressIndicator()),
                      );
                  })
              // ListView.builder(
              //   physics: NeverScrollableScrollPhysics(),
              //   padding: EdgeInsets.only(top: 10),
              //   shrinkWrap: true,
              //   itemCount: contents.length,
              //   itemBuilder: (context, index) {
              //     return ContentList(
              //       title: contents[index].title,
              //       img: contents[index].img,
              //       uploadTime: contents[index].uploadTime,
              //       owner: contents[index].owner,
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void listViewBuilders() {}

  void handleOnselect(int index) {
    setState(() {
      if (contents.length == allContents.length) {
        contents = [];
      }
      contents.addAll(allContents.where((Content content) {
        return content.owner == chipsLabels[index];
      }));
      print(contents.length);
    });
  }

  void handleUnselect(int index) {
    setState(() {
      contents.removeWhere((Content content) {
        return content.owner == chipsLabels[index];
      });
      if (contents.length == 0) {
        contents = allContents;
      }

      print(contents.length);
    });
  }

  @override
  void initState() {
    _techDailyApi = ApiManager().getContents();
    _techDailyOwner = ApiOwnerManager().getContents();
    allContents.forEach((Content content) {
      chipsLabels.add(content.owner);
    });

    contents = allContents;
    super.initState();
  }
}

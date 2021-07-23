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
  List<TechDailyContent> contents = [];
  bool isSorted = true;
  List<String> chipsLabels = [];

  bool shouldSort = false;
  List<TechDailyContent> allContents = [];
  List<TechDailyContent> sortedContents = [];

  List<TechDailyOwner> owners = [];
  Map<int, String> ownersMap = {};

  @override
  Widget build(BuildContext context) {
    print('Widget building');
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  padding: EdgeInsets.only(left: 6),
                  // child: FutureBuilder<List<TechDailyOwner>>(
                  //   future: _techDailyOwner,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       // setState(() {
                  //       //   owners = snapshot.data;
                  //       // });
                  //       return ListView.builder(
                  //         shrinkWrap: true,
                  //         itemCount: snapshot.data.length,
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (context, index) {
                  //           return ChipFilter(
                  //             ownerName: snapshot.data[index].name,
                  //             onSelect: () {
                  //               print('onSelect'+index.toString());
                  //               // handleOnselect(index);
                  //             },
                  //             onUnselect: () {
                  //               print('onUnSelect'+index.toString());
                  //              // handleUnselect(index);
                  //             },
                  //           );
                  //         },
                  //       );
                  //     } else
                  //       return Center(child: CircularProgressIndicator());
                  //   },
                  // ),
                  child:ListView.builder(
            shrinkWrap: true,
            itemCount: owners.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ChipFilter(
                ownerId: owners[index].id,
                ownerName: owners[index].name,
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
          ),
                ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: allContents.length,
            itemBuilder: (context, index) {
              return ContentList(
                title: allContents[index].title,
                img: allContents[index].imgUrl,
                uploadTime: allContents[index].pubDate,
                owner: ownersMap[allContents[index].owner] ?? allContents[index].owner.toString(),
                url: allContents[index].url,
              );
            },
          )
                // FutureBuilder<List<TechDailyContent>>(
                //     future: _techDailyApi,
                //     builder: (context, snapshot) {
                //       print("snapshot owner: "+snapshot.toString());
                //       if (snapshot.hasData) {
                //         // setState(() {
                //         //   allContents = snapshot.data;
                //         // });
                //         return ListView.builder(
                //           physics: NeverScrollableScrollPhysics(),
                //           padding: EdgeInsets.only(top: 10),
                //           shrinkWrap: true,
                //           itemCount: snapshot.data.length,
                //           itemBuilder: (context, index) {
                //             return ContentList(
                //               title: snapshot.data[index].title,
                //               img: snapshot.data[index].imgUrl,
                //               uploadTime: snapshot.data[index].pubDate,
                //               owner: ownersMap[snapshot.data[index].owner] ?? snapshot.data[index].owner.toString(),
                //               url: snapshot.data[index].url,
                //             );
                //           },
                //         );
                //       } else
                //         return Padding(
                //           padding: const EdgeInsets.only(top: 200),
                //           child: Center(child: CircularProgressIndicator()),
                //         );
                //     }),
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
      contents.addAll(allContents.where((TechDailyContent content) {
        return content.owner == chipsLabels[index];
      }));
      print(contents.length);
    });
  }

  void handleUnselect(int index) {
    setState(() {
      contents.removeWhere((TechDailyContent content) {
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

    ApiManager().getContents().then((List<TechDailyContent> value) {
      setState(() {
        allContents = value;
      });
    });

    ApiOwnerManager().getContents().then((List<TechDailyOwner> value) {
      Map<int, String> map = {};
      for(TechDailyOwner owner in value){
        map[owner.id] = owner.name;
      }
      setState(() {
        ownersMap = map;
        owners = value;
      });
    });

    // allContents.forEach((TechDailyContent content) {
    //   chipsLabels.add(content.owner);
    // });

    contents = allContents;
    super.initState();
  }
}

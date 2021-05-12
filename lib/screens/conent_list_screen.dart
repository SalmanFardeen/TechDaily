import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:techdaily/data/chip_data.dart';
import 'package:techdaily/models/content.dart';
import 'package:techdaily/widgets/chips_filter_widget.dart';
import 'package:techdaily/widgets/content_list_widget.dart';
import '../data/dummy_content.dart';

class ContentListScreen extends StatefulWidget {
  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  List<Content> contents = [];
  bool isSorted = true;
  List <String> chipsLabels = [];
  List<Content> allContents = DUMMY_CONTENTS.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 60),
                shrinkWrap: true,
                itemCount: chipsLabels.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChipFilter(
                    owner: chipsLabels[index],
                    onSelect: () {
                      handleOnselect(index);
                    },
                    onUnselect: () {
                      handleUnselect(index);
                    },
                  );
                },
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: contents.length,
              itemBuilder: (context, index) {
                return ContentList(
                  title: contents[index].title,
                  img: contents[index].img,
                  uploadTime: contents[index].uploadTime,
                  owner: contents[index].owner,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

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
    allContents.forEach((Content content) {
     chipsLabels.add(content.owner);
    });
    contents = allContents;
    super.initState();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:techdaily/data/chip_data.dart';
import 'package:techdaily/widgets/chips_choice_widget.dart';
import 'package:techdaily/widgets/content_list_widget.dart';
import '../data/dummy_content.dart';

class ContentListScreen extends StatelessWidget {
  final contents = DUMMY_CONTENTS.toList();
  final chips = CHIP_DATA.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 60),
                shrinkWrap: true,
                itemCount: chips.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChipsChoice(chips[index].owner);
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
}

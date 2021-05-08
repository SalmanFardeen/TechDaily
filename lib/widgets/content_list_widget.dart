import 'package:flutter/material.dart';
import 'package:techdaily/screens/content_details_screen.dart';

class ContentList extends StatelessWidget {
  final String id;
  final String title;
  final String img;
  final String uploadTime;
  final String owner;
  ContentList({this.title, this.img, this.uploadTime, this.id, this.owner});

  void selectContent(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ContentDetails();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      width: 398,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 34, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
      child: GestureDetector(
        onTap: () => selectContent(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 18),
          child: Row(
            children: [
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 201,
                    height: 86,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    owner,
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(img,
                        height: 95, width: 116, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 20),
                  Text(
                    uploadTime,
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ), //Upload Time
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

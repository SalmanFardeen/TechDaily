import 'package:flutter/material.dart';
import 'package:techdaily/screens/content_details_screen.dart';
import 'package:intl/intl.dart';

class ContentList extends StatelessWidget {
  final String id;
  final String title;
  final String img;
  final DateTime uploadTime;
  final String owner;
  final String url;
  ContentList({this.title, this.img, this.uploadTime, this.id, this.owner, this.url});

  void selectContent(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ContentDetails(url:url);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width*1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 34, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
      child: GestureDetector(
        onTap: () => selectContent(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*.46,
                    height: 86,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    owner,
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(img,
                        height: 95, width: 116, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 30),
                  uploadTime != null
                      ? Text(
                          DateFormat.yMMMEd().format(uploadTime).toString(),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )
                      : Text(
                          uploadTime.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

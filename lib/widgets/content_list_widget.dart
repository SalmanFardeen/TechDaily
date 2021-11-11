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
  ContentList(
      {this.title, this.img, this.uploadTime, this.id, this.owner, this.url});

  void selectContent(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ContentDetails(url: url);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('Width:' + MediaQuery.of(context).size.width.toString());
    return Container(
      height: 172,
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        color: Color.fromRGBO(35, 34, 34, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 20),
      child: GestureDetector(
        onTap: () => selectContent(context),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    height: 100,
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 5),
                  uploadTime != null
                      ? Text(
                          DateFormat.MMMd().format(uploadTime).toString() +
                              ', ' +
                              DateFormat.jm().format(uploadTime)
                          + DateFormat.m().format(uploadTime),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )
                      : Text(
                          uploadTime.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                ],
              ),
            ),
            SizedBox(width: 38, height: 0),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  child: Image.network(img,
                      height: 171, width: 150, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(35, 34, 34, .6),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            owner,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

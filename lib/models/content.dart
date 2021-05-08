import 'package:flutter/material.dart';

class Content {
  final String id;
  final String title;
  final String img;
  final String owner;
  final String uploadTime;

  const Content(
      {@required this.id,
      @required this.title,
      @required this.img,
      @required this.uploadTime,
      @required this.owner});
}

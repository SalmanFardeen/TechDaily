import 'package:flutter/material.dart';

class ChipsChoice extends StatefulWidget {
  final String owner;
  ChipsChoice(this.owner);

  @override
  _ChipsChoiceState createState() => _ChipsChoiceState();
}

class _ChipsChoiceState extends State<ChipsChoice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Container(
        child: Chip(
          label: Text(widget.owner,style: TextStyle(fontSize: 14),),
        ),
      ),
    );
  }
}

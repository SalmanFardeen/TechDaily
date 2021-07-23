import 'package:flutter/material.dart';

class ChipFilter extends StatefulWidget {
  final String ownerName;
  final String color;
  final bool selectState;
  final Function onSelect, onUnselect;
  final int ownerId;

  ChipFilter({this.ownerName, this.color, this.selectState,this.onSelect,this.onUnselect,this.ownerId});

  @override
  _ChipFilterState createState() => _ChipFilterState();
}

class _ChipFilterState extends State<ChipFilter> {
  bool _isSelected = false;
  Function sortedList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Container(
        child: FilterChip(
            label: Text(
              widget.ownerName,
              style: TextStyle(fontSize: 14,color: _isSelected? Color.fromRGBO(35, 35, 35, 1):Color.fromRGBO(206, 206, 206, 1)),
            ),
            backgroundColor: Color.fromRGBO(34, 35, 34, 1),
            selected: _isSelected,
            selectedColor: Colors.black12,
            onSelected: (isSelected) {
              // print(widget.owner);
              setState(() {
                _isSelected = isSelected;
              });
              _isSelected ? widget.onSelect() : widget.onUnselect();
            }),
      ),
    );
  }
}

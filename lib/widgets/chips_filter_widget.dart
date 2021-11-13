import 'package:flutter/material.dart';

class ChipFilter extends StatelessWidget {
  ChipFilter({Key key, this.shouldSelect,this.ownerName,this.onSelect,this.onUnselect})
                : super(key: key);

  final String ownerName;
  final Function onSelect, onUnselect;
  final bool shouldSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Container(
        child: FilterChip(
            label: Text(
              ownerName,
              style: TextStyle(fontSize: 14,color: shouldSelect? Color.fromRGBO(35, 35, 35, 1)
                          :Color.fromRGBO(206, 206, 206, 1)),
            ),
            backgroundColor: Color.fromRGBO(34, 35, 34, 1),
            selected: shouldSelect,
            selectedColor: Colors.black12,
            onSelected: (isSelected) {
              isSelected ? onSelect() : onUnselect();
            }),
      ),
    );
  }
}

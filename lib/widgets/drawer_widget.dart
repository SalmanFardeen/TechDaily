import 'package:flutter/material.dart';
import 'package:techdaily/screens/favorites_screen.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(canvasColor: Color.fromRGBO(35, 34, 34, 1)),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        child: Drawer(
          child: Center(
            child: Material(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  buildMenuItem(
                    itemLabel: 'Favorites',
                    iconData: Icons.favorite,
                    onClicked: () {
                      selectedItem(context, 0);
                    },
                  ),
                  buildMenuItem(
                      itemLabel: 'About Us', iconData: Icons.open_in_new_sharp),
                  buildMenuItem(
                      itemLabel: 'Send Feedback',
                      iconData: Icons.feedback_sharp),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.white70,
                        ),
                        SizedBox(width: 25),
                        Text(
                          'Lite Mode',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(width: 25),
                        Switch(
                            activeTrackColor: Colors.blueAccent,
                            activeColor: Colors.cyan,
                            value: _isSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem({
   final String itemLabel,
   final IconData iconData,
   final Function onClicked,
  }) {
    final color = Colors.white70;
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(iconData, color: color),
      ),
      title: Text(
        itemLabel,
        style: TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  Future <void> selectedItem(BuildContext context, int index) async {
    switch (index) {
      case 0:
        print('favorites'+index.toString());
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavoritesScreen(),
        ));
        break;
      default:
        print(index);
        break;
    }
  }
}

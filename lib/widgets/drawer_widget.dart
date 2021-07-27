import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techdaily/screens/drawer_about_us_screen.dart';
import 'package:techdaily/screens/drawer_favorites_screen.dart';

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
            child: ListView(
              children: [
                buildHeader(name:'Log In',imageUrl:'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                buildMenuItem(
                  itemLabel: 'Favorites',
                  iconData: Icons.favorite,
                  onClicked: () {
                    selectedItem(context, 0);
                  },
                ),
                buildMenuItem(
                    itemLabel: 'About Us', iconData: Icons.open_in_new_sharp,
                onClicked: ()=>selectedItem(context, 1)),
                buildMenuItem(
                    itemLabel: 'Send Suggestions', iconData: Icons.feedback_sharp),
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

  Widget buildHeader({String imageUrl,String name,String userName,Function onClicked}){
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(radius: 30,backgroundImage: NetworkImage(imageUrl),),
            SizedBox(width: 20),
            Text(name,style: TextStyle(fontSize: 22,color: Colors.white70),),
          ],
        ),
      ),
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    switch (index) {
      case 0:
        print('favorites' + index.toString());
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavoritesScreen(),
        ));
        break;
      case 1:
        print('favorites' + index.toString());
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AboutUsScreen(),
        ));
        break;
      default:
        print(index);
        break;
    }
  }
}

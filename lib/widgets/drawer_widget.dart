import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techdaily/screens/drawer_about_us_screen.dart';
import 'package:techdaily/screens/drawer_favorites_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:techdaily/services/firebase_signin.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _isSwitched = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Color.fromRGBO(35, 34, 34, 1)),
            child: Container(
              width: MediaQuery.of(context).size.width * .6,
              child: Drawer(
                child: Center(
                  child: ListView(
                    children: [
                      buildHeader(
                          login: snapshot.hasData ? true : false,
                          name: snapshot.hasData ? user.displayName : 'Log In',
                          imageUrl: snapshot.hasData
                              ? user.photoURL
                              : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                      buildMenuItem(
                        itemLabel: 'Favorites',
                        iconData: Icons.favorite,
                        onClicked: () {
                          selectedItem(context, 0);
                        },
                      ),
                      buildMenuItem(
                          itemLabel: 'About Us',
                          iconData: Icons.open_in_new_sharp,
                          onClicked: () => selectedItem(context, 1)),
                      buildMenuItem(
                          itemLabel: 'Send Suggestions',
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
          );
        });
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

  Widget buildHeader(
      {String imageUrl,
      String name,
      String userName,
      Function onClicked,
      bool login}) {
    return InkWell(
      onTap: () {
        // final provider = context.read<FirebaseSignIn>();
        final provider = Provider.of<FirebaseSignIn>(context, listen: false);
        login ? openDialog() : provider.googleLogin();
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: login
              ? Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(height: 20),
                    Text(
                      name,
                      style: TextStyle(fontSize: 22, color: Colors.white70),
                    ),
                  ],
                )
              : Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(width: 20),
                    Text(
                      name,
                      style: TextStyle(fontSize: 22, color: Colors.white70),
                    ),
                  ],
                )),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          backgroundColor: Color.fromRGBO(40, 40, 40, 1),
          elevation: 3,
          title: Text(
            'Logout?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context)),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                final provider =
                    Provider.of<FirebaseSignIn>(context, listen: false);
                provider.googleLogout();
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

  Future<void> selectedItem(BuildContext context, int index) async {
    switch (index) {
      case 0:
        print('Selected drawer item: ' +
            index.toString() +
            " - 'Favourites' page");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavoritesScreen(),
        ));
        break;
      case 1:
        print(
            'Selected drawer item:' + index.toString() + " - 'About Us' page");
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

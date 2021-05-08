import 'package:flutter/material.dart';

class ContentDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(41, 40, 40,.41),
        elevation: 4,
        foregroundColor: Colors.white,
        title: Text('News'),
      ),
      backgroundColor: Colors.black54,
      body: Center(child: Container(child: Text('New Page',style: TextStyle(color: Colors.white),),)),
    );
  }
}

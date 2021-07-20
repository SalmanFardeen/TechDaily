// import 'package:flutter/material.dart';
//
// class ContentDetails extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(41, 40, 40, .41),
//         elevation: 4,
//         foregroundColor: Colors.white,
//         title: Text('News'),
//       ),
//       backgroundColor: Colors.black54,
//       body: Center(
//         child: Container(
//           child: Text(
//             'New Page',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ContentDetails extends StatefulWidget {
  final String url;
  ContentDetails({this.url});

  @override
  _ContentDetailsState createState() => _ContentDetailsState();
}

class _ContentDetailsState extends State<ContentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TechDaily'),backgroundColor: Colors.black),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: true,
        resizeToAvoidBottomInset: true,
        useWideViewPort: true,
        initialChild: Container(
          color: Colors.white,
          child: const Center(
            child: Text('Please Wait.....'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share_plus/share_plus.dart';

class ContentDetailsWebview extends StatefulWidget {
  final String url;
  ContentDetailsWebview({this.url});

  @override
  _ContentDetailsWebviewState createState() => _ContentDetailsWebviewState();
}

class _ContentDetailsWebviewState extends State<ContentDetailsWebview> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TechDaily'),
        backgroundColor: Colors.black,
        actions: [
          StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    _isSelected = !_isSelected;
                  });
                },
                icon: Icon(
                  Icons.favorite,

                ),
              );
            }
          ),
          IconButton(
              onPressed: () => Share.share(widget.url), icon: Icon(Icons.share))
        ],
      ),
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

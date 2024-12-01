import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  final String? title;
  final String? url;

  ArticlePage({this.title, this.url});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Article'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finished) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(child: CircularProgressIndicator()), // Show a loading indicator until the page loads
        ],
      ),
    );
  }
}

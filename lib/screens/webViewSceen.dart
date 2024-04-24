import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  final link;
  const WebViewScreen({super.key,required this.link});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late bool _isLoading;
  late InAppWebViewController webView;
  double _progress = 0;
   @override
  void initState() {
    super.initState();
    _isLoading = true;
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBody: true,
      appBar: AppBar(title: Text("RSS NEWS"),backgroundColor: Colors.orangeAccent,),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
            widget.link,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          setState(() {
            _progress = progress / 100;
          });
        },
      ),
    );
  }
}
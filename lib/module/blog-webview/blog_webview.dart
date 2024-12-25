import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogWebview extends StatefulWidget {
  const BlogWebview({super.key, required this.url});

  final String url;

  @override
  State<BlogWebview> createState() => _BlogWebviewState();
}

class _BlogWebviewState extends State<BlogWebview> {
  late final WebViewController _controller;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  void initState() {
    // TODO: implement initState

    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.grey,
              BlendMode.saturation,
            ),
            child: WebViewWidget(
              controller: _controller
                ..setNavigationDelegate(NavigationDelegate(
                  onPageStarted: (url) {
                    isLoading.value = true;
                  },
                  onPageFinished: (url) {
                    isLoading.value = false;
                  },
                ))
                ..runJavaScript('''
                        (function() {
                      var script = document.createElement('script');
                      script.src = 'https://cdn.jsdelivr.net/npm/@mozilla/readability@0.4.0/dist/readability.min.js';
                      document.head.appendChild(script);
                      script.onload = function() {
                        // After script loads, call your custom function to extract content
                        window.extractReadabilityContent = function() {
                        const doc = new Readability();
                        const articleContent = doc.parse(document);  
                        // Send the extracted content back to Flutter using postMessage
                        window.postMessage(articleContent);
                      }
                  window.extractReadabilityContent();
                  };
                })();
                      ''')
                ..addJavaScriptChannel(
                  "web",
                  onMessageReceived: (p0) {
                    print(p0.message);
                  },
                )
                ..loadRequest(Uri.parse(widget.url)),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, child) {
              return value ? const LinearProgressIndicator() : Container();
            },
          )
        ],
      ),
    );
  }
}

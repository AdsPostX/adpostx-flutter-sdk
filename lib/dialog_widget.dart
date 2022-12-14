import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({
    Key? key,
    this.customView = const SizedBox(),
  });

  /// [customView] a widget to display a custom widget instead of the animation view.
  final Widget customView;

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 0.8,
      height: MediaQuery.of(context).size.height / 1.2,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 0.8,
            height: MediaQuery.of(context).size.height / 1.2,
            child: WebView(
              initialUrl:
                  "https://cdn.adspostx.com/embed.html?accountId=6&email=&firstname=&lastname=&mobile=&confirmationref=&amount=&currency=&paymenttype=&ccbin=&zipcode=&country=&language=&close=1",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: {
                JavascriptChannel(
                    name: "Flutter",
                    onMessageReceived: (JavascriptMessage message) {
                      print("response from webview");
                      Navigator.pop(context, true);
                    })
              },
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}

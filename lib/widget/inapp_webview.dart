// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_field

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ivorypay_flutter/widget/checkout_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebView extends StatefulWidget {
  final String? url;
  final bool? showHome;

  final String? from;
  final Widget? childWidget;
  final Function(bool, Object) onError;
  final Function(String) onCancel;

  InAppWebView({
    this.url,
    this.from,
    this.showHome = false,
    this.childWidget,
    required this.onError,
    required this.onCancel,
  });

  @override
  _InAppWebViewState createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final int _value = 0;
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  late final WebViewController controllerGlobal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: Uri.encodeFull(widget.url ?? 'https://ivorypay.io'),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                  controllerGlobal = webViewController;
                },
                onPageStarted: (String url) {
                  _isLoading.value = true;
                },
                onProgress: (value) {
                  if (value == 100) {
                    _isLoading.value = false;
                  }
                },
                onPageFinished: (String url) {
                  _isLoading.value = false;

                  // setState(() => _isLoading = false);
                },
                gestureNavigationEnabled: true,
                navigationDelegate: (action) {
                  if (action.url.toString().contains('payment-status')) {
                    _handleNavigation('payment_completed');

                    return NavigationDecision.navigate;
                  }
                  if (action.url.toString().contains('https://ivorypay.io')) {
                    return NavigationDecision.navigate;
                  }

                  return NavigationDecision.navigate;
                },
              );
            }),
          ),
          Container(
            height: 75,
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            width: double.infinity,
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    // await controllerGlobal.canGoBack().then((canGo) {
                    //   if (canGo) {
                    //     controllerGlobal.goBack();
                    //   } else {
                    //     Navigator.of(context).pop();
                    //   }
                    // });
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.transparent,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _handleNavigation('');
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _isLoading,
              builder: (context, value, child) {
                return Visibility(
                  visible: value,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.purple,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  _handleNavigation(String url) {
    if (url == 'payment_completed') {}
    widget.onCancel('Success');
  }
}

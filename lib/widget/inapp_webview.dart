// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_field

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
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
  InAppWebViewState createState() => InAppWebViewState();
}

class InAppWebViewState extends State<InAppWebView> {
  doneLoading(_) async {
    _isLoading.value = false;
    setState(() {});
  }

  late WebViewController webViewController = WebViewController();

  startLoading(_) {
    _isLoading.value = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            if (value == 100) {
              _isLoading.value = false;
            }
          },
          onPageStarted: startLoading,
          onPageFinished: doneLoading,
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.toString().contains('payment-status')) {
              _handleNavigation('payment_completed');

              return NavigationDecision.navigate;
            }
            if (request.url.toString().contains('https://ivorypay.io')) {
              return NavigationDecision.navigate;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? ''));
  }

  /// These are instance variables declared in the `_InAppWebViewState` class.
  /// These are instance variables declared in the `_InAppWebViewState` class.
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);
  final int _value = 0;
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();
  late final WebViewController controllerGlobal;

  /// This function returns a Scaffold with a WebView and a cancel button, and shows
  /// a loading indicator while the WebView is loading.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is a required parameter in the
  /// build method of a widget in Flutter. It represents the location of the widget
  /// in the widget tree and is used to obtain information about the current theme,
  /// media query, and other contextual information. It is typically used to build
  /// child widgets or to access services such
  ///
  /// Returns:
  ///   A `Scaffold` widget with a `Stack` as its body, containing a `WebView`
  /// widget, a `Container` widget with a `Row` of `InkWell` widgets, and a
  /// `Visibility` widget with a `CircularProgressIndicator`.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Builder(builder: (BuildContext context) {
              return WebViewWidget(
                controller: webViewController,
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
                  child: const Icon(
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

  /// This function handles navigation for a given URL.
  ///
  /// Args:
  ///   url (String): The `url` parameter is a string that represents the URL that
  /// the function will handle for navigation purposes.
  _handleNavigation(String url) {
    if (url == 'payment_completed') {}
    widget.onCancel('Success');
  }
}

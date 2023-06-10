import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebView extends StatefulWidget {
  /// [final String? url;[ is declaring an optional instance variable [url of type
  /// [String[. The [?[ after the type [String[ indicates that the variable can be
  /// [null[. This variable can be used to pass a URL string to the [InAppWebView[
  /// widget, which can be loaded in the [WebView[. If no URL is provided, the
  /// [WebView[ will not load any page.
  final String? url;

  /// [final bool? showHome;[ is declaring an optional instance variable [showHome[
  /// of type [bool[. The [?[ after the type [bool[ indicates that the variable can
  /// be [null[. This variable can be used to determine whether to show a home page
  /// or not in the [InAppWebView[ widget. However, it is not being used in the code
  /// provided and can be removed if not needed.
  final bool? showHome;

  /// [final String? from;[ is declaring an optional instance variable [from[ of
  /// type [String[. The [?[ after the type [String[ indicates that the variable can
  /// be [null[. This variable can be used to pass a string value to the
  /// [InAppWebView[ widget, which can be used to identify the source of the web
  /// page being loaded in the [WebView[. It is not being used in the code provided
  /// and can be removed if not needed.
  final String? from;

  /// [final Widget? childWidget;[ is declaring an optional instance variable
  /// [childWidget[ of type [Widget[. This variable can be used to pass a child
  /// widget to the [InAppWebView[ widget, which can be displayed alongside the
  /// [WebView[ widget. The [?[ after the type [Widget[ indicates that the variable
  /// can be [null[.
  final Widget? childWidget;

  /// [final Function(bool, Object) onError;[ is declaring an instance variable
  /// [onError[ of type [Function[ that takes two parameters: a [bool[ and an
  /// [Object[. This variable is used to pass a callback function to the
  /// [InAppWebView[ widget that will be called when an error occurs during the
  /// loading of a web page in the WebView. The [bool[ parameter indicates whether
  /// the error is a network error or not, and the [Object[ parameter contains
  /// additional information about the error. The callback function can be used to
  /// handle the error in a custom way, such as displaying an error message to the
  /// user or logging the error for debugging purposes.
  final Function(bool, Object) onError;

  /// [final Function(String) onCancel;[ is declaring an instance variable
  /// [onCancel[ of type [Function[ that takes a single argument of type [String[.
  /// This variable is passed as a required parameter to the [InAppWebView[
  /// constructor and is used to handle the cancellation of the WebView. When the
  /// cancel button is pressed, the [_handleNavigation[ function is called with an
  /// empty string as the argument, which in turn calls the [onCancel[ function
  /// passed to the constructor with the argument ['Success'[. This allows the
  /// parent widget to handle the cancellation event and perform any necessary
  /// actions.
  final Function(String) onCancel;

  const InAppWebView({
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
  /// [late WebViewController webViewController = WebViewController();[ is declaring
  /// a [WebViewController[ variable named [webViewController[ as a final instance
  /// variable. The [late[ keyword is used to indicate that the variable will be
  /// initialized at a later time, before it is used. This is useful when a variable
  /// needs to be declared as final, but its value cannot be determined at the time
  /// of declaration. In this case, the [WebViewController[ instance is initialized
  /// in the [initState()[ method of the [InAppWebViewState[ class.
  late WebViewController webViewController = WebViewController();

  /// The function "doneLoading" is an asynchronous function in Dart that takes in
  /// an underscore (_) as a parameter.
  ///
  /// Args:
  ///   _: The underscore symbol (_) is a placeholder for a parameter that is not
  /// used in the function. In this case, it is used as a placeholder for a
  /// parameter that represents the result of the loading process.
  doneLoading(_) async {
    _isLoading.value = false;
    setState(() {});
  }

  /// The function "startLoading" takes an argument (_) and does not have any code
  /// implemented yet.
  ///
  /// Args:
  ///   _: The underscore symbol (_) is often used as a placeholder for a variable
  /// or parameter that is not needed or used in a particular context. In this case,
  /// it is being used as a placeholder for a parameter that is not needed for the
  /// startLoading function.
  startLoading(_) {
    _isLoading.value = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    /// The below code is setting up a WebViewController for a web view in a Dart
    /// application. It sets the JavaScript mode to unrestricted, sets the
    /// background color to transparent, and sets a NavigationDelegate to handle
    /// various events during web navigation. The NavigationDelegate includes
    /// functions to handle progress updates, page start and finish events, web
    /// resource errors, and navigation requests. The navigation request function
    /// checks the URL of the requested page and decides whether to allow navigation
    /// or not based on certain conditions.
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

  /// These are instance variables declared in the [_InAppWebViewState[ class.
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  /// [_isLoading] = ValueNotifier(true); is declaring an
  /// instance variable [_isLoading[ of type [ValueNotifier<bool>[ and initializing
  /// it with a value of [true[. [ValueNotifier[ is a class in Flutter that provides
  /// a way to listen for changes to a value and rebuild the UI when the value
  /// changes. In this case, [_isLoading[ is used to track whether the WebView is
  /// currently loading a page or not, and the UI is updated to show a loading
  /// indicator when [_isLoading[ is [true[.

  /// [final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();[ is creating a
  /// [GlobalKey[ object that is used to uniquely identify a [FormState[ object.
  /// This is typically used when working with forms in Flutter, where the
  /// [GlobalKey[ is used to access the [FormState[ object and perform operations
  /// such as validation or resetting the form. In this specific code, it is not
  /// being used and can be removed.
  final GlobalKey<FormState> dialogKey = GlobalKey<FormState>();

  /// [late final WebViewController controllerGlobal;[ is declaring a
  /// [WebViewController[ variable named [controllerGlobal[ as a final instance
  /// variable. The [late[ keyword is used to indicate that the variable will be
  /// initialized at a later time, before it is used. This is useful when a variable
  /// needs to be declared as final, but its value cannot be determined at the time
  /// of declaration. In this case, the [WebViewController[ instance is initialized
  /// in the [initState()[ method of the [InAppWebViewState[ class.
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
  ///   A [Scaffold[ widget with a [Stack[ as its body, containing a [WebView[
  /// widget, a [Container[ widget with a [Row[ of [InkWell[ widgets, and a
  /// [Visibility[ widget with a [CircularProgressIndicator[.
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
  ///   url (String): The [url[ parameter is a string that represents the URL that
  /// the function will handle for navigation purposes.
  _handleNavigation(String url) {
    if (url == 'payment_completed') {}
    widget.onCancel('Success');
  }
}

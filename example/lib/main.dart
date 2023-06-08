import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ivorypay_flutter/ivorypay_flutter.dart';
import 'package:ivorypay_flutter/model/Initiate_ivorypay_transaction.dart';
import 'package:ivorypay_flutter/widget/checkout_service.dart';
import 'package:ivorypay_flutter/widget/inapp_webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _ivorypayFlutterPlugin = IvorypayFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _ivorypayFlutterPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return Stack(
            children: [
              InkWell(
                onTap: () async {
                  final serviceee = IvoryCheckoutService(
                    context: context,
                    data: InitiateIvorypayTransaction(
                      baseFiat: "NGN",
                      amount: 40,
                      crypto: "USDC",
                      email: "nwakasistephenifeanyi@gmail.com",
                      authorization:
                          'pk_Q0ka44CHNFHtrwfvzGwqYLrRRlqQoyfmLL6mZ1vqkHJV4P1WhgArKPDlJrwy1DQ6',
                    ),
                    onError: (value, e) {
                      print('object');
                    },
                    onSuccess: (res) {},
                    onLoading: (valueLoading) {
                      setState(() {
                        isLoading = valueLoading;
                      });
                    },
                  );

                  serviceee.run();
                },
                child: Center(
                  child: Text('Pay with Ivory'),
                ),
              ),
              if (isLoading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

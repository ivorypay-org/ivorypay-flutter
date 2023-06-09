import 'package:flutter/material.dart';
import 'package:ivorypay_flutter/ivorypay_flutter.dart';
import 'package:ivorypay_flutter/model/Initiate_ivorypay_transaction.dart';

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

  @override
  void initState() {
    super.initState();
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
                  final serviceee = IvorypayFlutter(
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

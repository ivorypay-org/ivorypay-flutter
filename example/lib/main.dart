import 'package:flutter/material.dart';
import 'package:ivorypay_flutter/ivorypay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;

  final amountCtrl = TextEditingController();
  final baseFiat = TextEditingController();
  final crypto = TextEditingController();
  final email = TextEditingController();
  final authCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    authCtrl.text =
        'pk_Q0ka44CHNFHtrwfvzGwqYLrRRlqQoyfmLL6mZ1vqkHJV4P1WhgArKPDlJrwy1DQ6';
    email.text = 'jams@mailinator.com';
    crypto.text = 'USDT';
    baseFiat.text = 'NGN';
    // amountCtrl.text = '10';
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextField(
                  controller: baseFiat,
                  decoration: const InputDecoration(
                    hintText: "BaseFiat(eg. NGN, GHS)",
                    hintStyle: TextStyle(color: Colors.purpleAccent),
                    //<-- SEE HERE
                    labelStyle:
                        TextStyle(color: Colors.purpleAccent), //<-- SEE HERE
                  ),
                ),
                TextField(
                  controller: amountCtrl,
                  decoration: const InputDecoration(
                    hintText: "Amount",
                    hintStyle: TextStyle(color: Colors.purpleAccent),
                    //<-- SEE HERE
                    labelStyle:
                        TextStyle(color: Colors.purpleAccent), //<-- SEE HERE
                  ),
                ),
                TextField(
                  controller: crypto,
                  decoration: const InputDecoration(
                    hintText: "Crypto(eg USDT,USDC)",
                    hintStyle: TextStyle(color: Colors.purpleAccent),
                    //<-- SEE HERE
                    labelStyle:
                        TextStyle(color: Colors.purpleAccent), //<-- SEE HERE
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.purpleAccent),
                    //<-- SEE HERE
                    labelStyle:
                        TextStyle(color: Colors.purpleAccent), //<-- SEE HERE
                  ),
                ),
                TextField(
                  controller: authCtrl,
                  decoration: const InputDecoration(
                    hintText: "Authorization",
                    hintStyle: TextStyle(color: Colors.purpleAccent),
                    //<-- SEE HERE
                    labelStyle:
                        TextStyle(color: Colors.purpleAccent), //<-- SEE HERE
                  ),
                ),
                const SizedBox(height: 45),
                Stack(
                  children: [
                    IvorypayButton(
                      option: IvorypayButtonOption.two,
                      onTap: () async {
                        final ivoryService = IvorypayFlutter(
                          context: context,
                          data: InitiateIvorypayTransaction(
                            baseFiat: "NGN",
                            amount: int.tryParse(amountCtrl.text.trim()),
                            crypto: crypto.text,
                            email: email.text,
                            authorization: authCtrl.text,
                          ),
                          onError: (value, e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          },
                          onSuccess: (res) {
                            // Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(res.toString())));
                          },
                          onLoading: (valueLoading) {
                            setState(() {
                              isLoading = valueLoading;
                            });
                          },
                        );

                        ivoryService.run();
                      },
                    ),
                    // InkWell(

                    //   child: const Center(
                    //     child: Text(
                    //       'Pay with Ivory',
                    //       style: TextStyle(fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                    if (isLoading)
                      const Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

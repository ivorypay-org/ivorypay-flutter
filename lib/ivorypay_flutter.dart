import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ivorypay_flutter/constants/constants.dart';
import 'package:ivorypay_flutter/model/transaction_response_dto.dart';
import 'package:ivorypay_flutter/model/verify_transaction_res.dart';
import 'package:ivorypay_flutter/widget/inapp_webview.dart';

class IvorypayFlutter {
  /// These are instance variables of the `IvorypayFlutter` class in Dart.
  final bool isDev;

  final BuildContext context;
  final InitiateIvorypayTransaction data;
  final Function(bool, Object)? onError;
  final Function(VerifyTransactionRes)? onSuccess;
  final Function(bool)? onLoading;

  IvorypayFlutter({
    required this.context,
    this.isDev = true,
    required this.data,
    this.onError,
    this.onSuccess,
    this.onLoading,
  });

  /// This code defines two private functions, a boolean value notifier, and a
  /// nullable timer variable in Dart.
  String _baseUrl() => isDev == true ? Constants.devURL : Constants.prodURL;

  String _paymentLinkBaseUrl() => isDev == true
      ? Constants.paymentLinkDevURL
      : Constants.paymentLinkProdURL;

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Timer? timer;

  /// This function sends a POST request to a server with specific data and returns
  /// a payment link if successful.
  ///
  /// Returns:
  ///   The method `run()` returns a `Future<String>`.
  Future<String> run() async {
    final baseUrl = _baseUrl();
    final paymentLinkBaseUrl = _paymentLinkBaseUrl();

    onLoading!(true);
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode({
          "baseFiat": data.baseFiat,
          "amount": data.amount,
          "crypto": data.crypto,
          "email": data.email,
          "metadata": null
        }),
        headers: {
          'Content-Type': ' application/json',
          'Authorization': data.authorization ?? ''
        },
      );

      if (response.statusCode == 201) {
        final data = TransactionResponseDto.fromJson(
          jsonDecode(response.body),
        );

        final link = "$paymentLinkBaseUrl/${data.data?.reference}";

        Future.delayed(Duration.zero, () {
          closeAfterTimer(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Stack(
                children: [
                  InAppWebView(
                    url: link,
                    onError: (value, error) {
                      onError!(true, error);
                    },
                    onCancel: (msg) async {
                      final status =
                          await verifyStatus(data.data?.reference ?? '');

                      if (status != 'success') {
                        Future.delayed(Duration.zero, () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                      'Are you sure you want to cancel? '),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Your transaction status is ${status?.toUpperCase().replaceAll('_', ' ')}',
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              timer?.cancel();

                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('No'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        });
                      }
                    },
                  ),
                  ValueListenableBuilder(
                      valueListenable: isLoading,
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
            ),
          );
        });

        return link;
      } else {
        onError!(true, response.body);

        return response.body.toString();
      }
    } catch (e) {
      onError!(true, e);
      return e.toString();
    } finally {
      onLoading!(false);
    }
  }

  /// This function verifies the status of a transaction and returns the status
  /// string.
  ///
  /// Args:
  ///   ref (String): The parameter "ref" is a string that represents a reference ID
  /// for a transaction that needs to be verified.
  ///
  /// Returns:
  ///   a `Future<String?>`.
  Future<String?> verifyStatus(String ref) async {
    final baseUrl = _baseUrl();

    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse("$baseUrl/$ref/verify"),
        headers: {
          'Content-Type': ' application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = VerifyTransactionRes.fromJson(
          jsonDecode(response.body),
        );

        Future.delayed(Duration.zero, () {
          if (data.data?.status == 'success') {
            timer?.cancel();
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  data.data?.status?.toUpperCase().replaceAll('_', ' ') ??
                      '')));
        });

        return data.data?.status;
      } else {
        onError!(true, response.body);
      }
    } catch (e) {
      onError!(true, e);
    } finally {
      isLoading.value = false;
    }

    return null;
  }

  /// This function sets a timer for 10 seconds and closes the current screen while
  /// showing a snackbar with an error message.
  ///
  /// Args:
  ///   context (BuildContext): The BuildContext is an object that provides
  /// information about the location of a widget within the widget tree. It is used
  /// to obtain information about the current state of the widget tree, such as the
  /// theme, the size and position of the widget, and the state of any ancestor
  /// widgets. In this case,
  void closeAfterTimer(BuildContext context) {
    timer = Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Timed Out!!!, Please try agian'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}

/// baseFiat : "NGN"
/// amount : 40
/// crypto : "USDC"
/// email : "nwakasistephenifeanyi@gmail.com"
/// metadata : null

/// The InitiateIvorypayTransaction class represents a transaction object with
/// properties such as baseFiat, amount, crypto, email, authorization, and metadata,
/// and includes methods for JSON serialization and copying.
///
///

///To initiate a  transaction, a email address must be specified in the body of the request.
///This email address will be used to create an entry in the Business Customer list of your business if it does not already exist.
///So, typically, the email of the person making the payment is to be provided.
///Every newly initiated transaction is only valid for 5 mins unless payment is received and a verification request is made to the IvoryPay API

class InitiateIvorypayTransaction {
  InitiateIvorypayTransaction({
    this.baseFiat,
    this.amount,
    this.crypto,
    this.email,
    this.authorization,
    this.metadata,
  });

  InitiateIvorypayTransaction.fromJson(dynamic json) {
    baseFiat = json['baseFiat'];
    amount = json['amount'];
    crypto = json['crypto'];
    email = json['email'];
    authorization = json['authorization'];
    metadata = json['metadata'];
  }

  /// These are instance variables of the `InitiateIvorypayTransaction` class in
  /// Dart, each with a nullable type (`String?`, `num?`, `dynamic?`). They
  /// represent properties of a transaction object, such as the base fiat currency,
  /// amount, cryptocurrency, email, authorization, and metadata. The `?` indicates
  /// that these variables can be null, meaning they may or may not have a value
  /// assigned to them.

  String? baseFiat;
  num? amount;
  String? crypto;
  String? email;
  String? authorization;
  dynamic metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['baseFiat'] = baseFiat;
    map['amount'] = amount;
    map['crypto'] = crypto;
    map['email'] = email;
    map['authorization'] = authorization;
    map['metadata'] = metadata;
    return map;
  }
}

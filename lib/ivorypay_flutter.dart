import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ivorypay_flutter/constants/constants.dart';
import 'package:ivorypay_flutter/model/Initiate_ivorypay_transaction.dart';
import 'package:ivorypay_flutter/model/verify_transaction_res.dart';
import 'package:ivorypay_flutter/widget/inapp_webview.dart';

import '../model/transaction_response_dto.dart';

class IvorypayFlutter {
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

        print(data.data?.reference);

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
                                      SizedBox(
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
                                            child: Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('No'),
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
        if (kDebugMode) {
          print(response.statusCode.toString());
          print(response.body.toString());
        }

        onError!(true, response.body);

        return response.body.toString();
      }
    } catch (e) {
      final value = e;

      onError!(true, e);
      print(e.toString());
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

        print(data.data?.status);
        print(data.data?.failureReason);
        onSuccess!(data);
      } else {
        if (kDebugMode) {
          print(response.statusCode.toString());
          print(response.body.toString());
        }

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
    timer = Timer(Duration(seconds: 10), () {
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

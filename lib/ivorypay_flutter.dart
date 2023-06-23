import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ivorypay_flutter/constants/constants.dart';
import 'package:ivorypay_flutter/model/transaction_response_dto.dart';
import 'package:ivorypay_flutter/model/verify_transaction_res.dart';
import 'package:ivorypay_flutter/widget/inapp_webview.dart';

/// The above code is defining a constructor for a class called `IvorypayFlutter`.
/// The constructor takes in several parameters including a required
/// `BuildContext` object, a boolean `isDev` flag with a default value of `true`,
/// a required `data` object, and optional callback functions for `onError`,
/// `onSuccess`, and `onLoading`

class IvorypayFlutter {
  /// These are instance variables of the [IvorypayFlutter[ class in Dart.
  final bool isDev;

  /// The above code is declaring a final variable named [context[ of type
  /// [BuildContext[. It is not doing anything else as it is just a declaration and
  /// not an executable code.
  final BuildContext context;

  /// The above code is declaring a final variable named "data" of type
  /// "InitiateIvorypayTransaction". The type "InitiateIvorypayTransaction" is
  /// likely a custom class or data structure defined elsewhere in the code.
  final InitiateIvorypayTransaction data;

  /// [final Function(bool, Object)? onError;[ is a nullable instance variable of
  /// the [IvorypayFlutter[ class in Dart. It represents a function that takes in
  /// two arguments: a boolean value and an object. The [?[ indicates that this
  /// variable can be null, meaning it may or may not have a function assigned to
  /// it. This function is called when an error occurs during the execution of the
  /// [run()[ or [verifyStatus()[ functions. The boolean value indicates whether the
  /// error is critical or not, and the object contains information about the error.
  final Function(bool, Object)? onError;

  /// [final Function(VerifyTransactionRes)? onSuccess;[ is a nullable instance
  /// variable of the [IvorypayFlutter[ class in Dart. It represents a function that
  /// takes in a [VerifyTransactionRes[ object as an argument and returns nothing
  /// ([void[). The [?[ indicates that this variable can be null, meaning it may or
  /// may not have a function assigned to it. This function is called when the
  /// [verifyStatus()[ function is successful and returns a [VerifyTransactionRes[
  /// object. It allows the user of the [IvorypayFlutter[ class to define their own
  /// custom behavior when a transaction is successfully verified.
  final Function(VerifyTransactionRes)? onSuccess;

  /// [final Function(bool)? onLoading;[ is a nullable instance variable of the
  /// [IvorypayFlutter[ class in Dart. It represents a function that takes in a
  /// boolean value as an argument and returns nothing ([void[). The [?[ indicates
  /// that this variable can be null, meaning it may or may not have a function
  /// assigned to it. This function is called when the [run()[ function is executed
  /// and the loading state changes. It allows the user of the [IvorypayFlutter[
  /// class to define their own custom behavior when the loading state changes.
  final Function(bool)? onLoading;

  IvorypayFlutter({
    required this.context,
    this.isDev = true,
    required this.data,
    required this.onError,
    required this.onSuccess,
    required this.onLoading,
  });

  /// This code defines two private functions, a boolean value notifier, and a
  /// nullable timer variable in Dart.
  String _baseUrl() => isDev == true ? Constants.devURL : Constants.prodURL;

  /// This is a private function in Dart that returns a payment link base URL if the
  /// environment is set to development.
  String _paymentLinkBaseUrl() => isDev == true
      ? Constants.paymentLinkDevURL
      : Constants.paymentLinkProdURL;

  /// The above code is declaring a [ValueNotifier[ object named [isLoading[ with a
  /// boolean value of [false[. [ValueNotifier[ is a class in Dart that provides a
  /// way to listen to changes to a value and notify listeners when the value
  /// changes. In this case, [isLoading[ is likely being used to track whether a
  /// certain process or operation is currently in progress (i.e. [isLoading[ is
  /// [true[ when the process is running and [false[ when it is not).
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// The above code is declaring a nullable variable [timer[ of type [Timer[ in
  /// Dart. The [Timer[ class is used to create a timer that runs a callback
  /// function after a specified duration. The [?[ after the type [Timer[ indicates
  /// that the variable can be null.
  Timer? timer;

  /// This function sends a POST request to a server with specific data and returns
  /// a payment link if successful.
  ///
  /// Returns:
  ///   The method [run()[ returns a [Future<String>[.
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

        /// The below code is creating a string variable called [link[ that
        /// concatenates a base payment link URL with a reference ID obtained from
        /// [data.data[. The [?.[ operator is used to safely access the [reference[
        /// property of [data.data[ without causing a null reference exception if
        /// [data.data[ is null.
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
                          await verifyStatus(data.data?.reference ?? '', msg);

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

                                              onError!(true,
                                                  'Transaction Cancelled');

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
                      } else {
                        if (msg.isEmpty) {
                          Future.delayed(Duration.zero, () {
                            Navigator.of(context).pop();
                          });
                        }
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
  ///   a [Future<String?>[.
  Future<String?> verifyStatus(String ref, String msg) async {
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

        if (data.data?.status == 'success') {
          timer?.cancel();
          isLoading.value = false;
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
            onSuccess!(data);
          });
        }

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
    timer = Timer(const Duration(minutes: 10), () {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Timed Out!!!, Please try again'),
          backgroundColor: Colors.red,
        ),
      );

      onError!(true, 'Timed Out!!!, Please try again');
    });
  }
}

/// The [InitiateIvorypayTransaction] class represents a transaction object with
/// properties such as baseFiat, amount, crypto, email, authorization, and metadata,
/// and includes methods for JSON serialization and copying.
///
///

/// To initiate a  transaction, a email address must be specified in the body of the request.
/// This [email] address will be used to create an entry in the Business Customer list of your business if it does not already exist.
/// So, typically, the [email] of the person making the payment is to be provided.
/// Every newly initiated transaction is only valid for 5 mins unless payment is received and a verification request is made to the IvoryPay API

/// Represents an Ivorypay transaction object used for initiating a payment.
class InitiateIvorypayTransaction {
  /// Creates an [InitiateIvorypayTransaction] object.
  ///
  /// The [baseFiat], [amount], [crypto], [email], [authorization], and [metadata]
  /// parameters are optional and can be null. These properties represent
  /// different attributes of a transaction, such as the base fiat currency,
  /// amount, cryptocurrency, email, authorization, and metadata.
  InitiateIvorypayTransaction({
    this.baseFiat,
    this.amount,
    this.crypto,
    this.email,
    this.authorization,
    this.metadata,
  });

  /// Creates an [InitiateIvorypayTransaction] object from a JSON dynamic data.
  ///
  /// This constructor is used to create an instance of [InitiateIvorypayTransaction]
  /// from JSON data. The [json] parameter should be a dynamic object containing
  /// the transaction data in JSON format.
  InitiateIvorypayTransaction.fromJson(dynamic json) {
    baseFiat = json['baseFiat'];
    amount = json['amount'];
    crypto = json['crypto'];
    email = json['email'];
    authorization = json['authorization'];
    metadata = json['metadata'];
  }

  /// The cryptocurrency in which the amount is to be charged.
  ///
  /// Supported currencies are USDT, USDC, and SOL.
  ///
  /// Can be null.
  String? crypto;

  /// The fiat currency of the amount to be charged.
  ///
  /// Supported fiats are NGN, GHS, ZAR, and KES.
  ///
  /// Can be null.
  String? baseFiat;

  /// The amount in the fiat currency which is to be charged.
  ///
  /// Can be null.
  num? amount;

  /// The email of the person making the payment.
  ///
  /// Typically provided.
  ///
  /// Can be null.
  String? email;

  /// The authorization string for the transaction.
  ///
  /// Can be null.
  String? authorization;

  /// Additional metadata associated with the transaction.
  ///
  /// Can be null.
  dynamic metadata;

  /// Converts the [InitiateIvorypayTransaction] object to a JSON map.
  ///
  /// Returns a map representation of the transaction object in JSON format.
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

/// The IvorypayButton class is a stateless widget that displays an image button with two options and
/// executes a callback function when tapped.

/// A customizable button widget for Ivorypay integration.
///
/// This widget allows you to display a button with different options and
/// specify an [onTap] callback function to handle the button tap event.
class IvorypayButton extends StatelessWidget {
  /// Creates an [IvorypayButton] widget.
  ///
  /// The [option] parameter specifies the button style option to use,
  /// and the [onTap] parameter is the callback function to be called
  /// when the button is tapped.
  const IvorypayButton({
    Key? key,
    this.option = IvorypayButtonOption.one,
    required this.onTap,
  }) : super(key: key);

  /// The style option for the Ivorypay button.
  ///
  /// Use [IvorypayButtonOption.one] for the first style option,
  /// and [IvorypayButtonOption.two] for the second style option.
  final IvorypayButtonOption option;

  /// The callback function to be called when the button is tapped.
  final VoidCallback onTap;

  static const optionOne =
      'https://res.cloudinary.com/dxfwzjz4k/image/upload/f_auto,q_auto/v1/ivorypay_flutter/ivqluefmzqeotiwzevfo';
  static const optionTwo =
      'https://res.cloudinary.com/dxfwzjz4k/image/upload/f_auto,q_auto/v1/ivorypay_flutter/pmxsqpcjgkfsu0lpv5f0';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Builder(builder: (context) {
        if (option == IvorypayButtonOption.one) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              optionOne,
              width: double.maxFinite,
              height: 60,
              fit: BoxFit.fitWidth,
            ),
          );
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              optionTwo,
              width: double.maxFinite,
              height: 60,
              fit: BoxFit.fitWidth,
            ),
          );
        }
      }),
    );
  }
}

/// The available options for the Ivorypay button.
///
/// Use [IvorypayButtonOption.one] or [IvorypayButtonOption.two]
/// to specify the desired button style.
enum IvorypayButtonOption {
  /// The first style option.
  one,

  /// The second style option.
  two,
}

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:ivorypay_flutter/constants/constants.dart';
import 'package:ivorypay_flutter/ivorypay_flutter.dart';
import 'package:ivorypay_flutter/model/transaction_response_dto.dart';
import 'package:ivorypay_flutter/model/verify_transaction_res.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ivorypay_flutter_alt_platform_interface.dart';

/// A web implementation of the IvorypayFlutterAltPlatform of the IvorypayFlutterAlt plugin.
class IvorypayFlutterWeb extends IvorypayFlutterAltPlatform {
  /// Constructs a IvorypayFlutterAltWeb
  IvorypayFlutterWeb();

  static void registerWith(Registrar registrar) {
    IvorypayFlutterAltPlatform.instance = IvorypayFlutterWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

  String ref = '';

  Future<String> run({
    required BuildContext context,
    required bool isDev,
    required InitiateIvorypayTransaction data,
    required Function(bool, Object)? onError,
    required Function(VerifyTransactionRes)? onSuccess,
    required Function(bool)? onLoading,
  }) async {
    final baseUrl = isDev ? Constants.devURL : Constants.prodURL;
    final paymentLinkBaseUrl =
        isDev ? Constants.paymentLinkDevURL : Constants.paymentLinkProdURL;

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

        await launchUrl(Uri.parse(link), mode: LaunchMode.inAppWebView);
        ref = data.data?.reference ?? '';
        return link;
      } else {
        onError!(true, response.body);

        return response.body.toString();
      }
    } catch (e) {
      onError!(true, e);
      return e.toString();
    } finally {
      onLoading(false);
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
  Future<VerifyTransactionRes?> verifyStatus({
    required bool isDev,
    required Function(bool, Object)? onError,
    required Function(VerifyTransactionRes)? onSuccess,
  }) async {
    final baseUrl = isDev ? Constants.devURL : Constants.prodURL;

    try {
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
          // isLoading.value = false;
          Future.delayed(const Duration(seconds: 2), () {
            onSuccess!(data);
          });
        }

        return data;
      } else {
        onError!(true, response.body);
      }
    } catch (e) {
      onError!(true, e);
    } finally {
      // isLoading.value = false;
    }

    return null;
  }
}

/// This is a private function in Dart that returns a payment link base URL if the
/// environment is set to development.

/// The above code is declaring a [ValueNotifier[ object named [isLoading[ with a
/// boolean value of [false[. [ValueNotifier[ is a class in Dart that provides a
/// way to listen to changes to a value and notify listeners when the value
/// changes. In this case, [isLoading[ is likely being used to track whether a
/// certain process or operation is currently in progress (i.e. [isLoading[ is
/// [true[ when the process is running and [false[ when it is not).
// ValueNotifier<bool> isLoading = ValueNotifier(false);

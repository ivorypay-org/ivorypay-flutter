# ivorypay_flutter_example

Demonstrates how to use the ivorypay_flutter plugin.

## Getting Started

///To initiate a transaction, a email address must be specified in the body of the request. ///This
email address will be used to create an entry in the Business Customer list of your business if it
does not already exist. ///So, typically, the email of the person making the payment is to be
provided. ///Every newly initiated transaction is only valid for 5 mins unless payment is received
and a verification request is made to the IvoryPay API

### Public Key

In order to use this library you are required to use your ivorypay public key and not the secret
key. See how to get your API
Keys [here](https://ivory-pay.gitbook.io/ivorypay-api-documentation/authorization/using-your-api-key)

## Usage

Below are a few examples showcasing how you can use the library to implement payment in your Flutter
app.

## Getting Started

To install, add it to your `pubspec.yaml` file:

```
dependencies:
    ivorypay_flutter: <latest>

```

## How to use it

```dart
import 'package:ivorypay_flutter/ivorypay_flutter.dart';
```

```dart

final ivoryService = IvorypayFlutter(
  context: context,
  data: InitiateIvorypayTransaction(
    baseFiat: "NGN",
    amount: 4000,
    crypto: "USDC",
    email: 'EMAIL',
    authorization: 'PUBLIC_API_KEY',
  ),
  onError: (value, e) {},
  onSuccess: (res) {},
  onLoading: (valueLoading) {
    setState(() {
      isLoading = valueLoading;
    });
  },
);

ivoryService.run();

```

## Parameters

```dart
[crypto*]

The cryptocurrency in which the amount is to be charged. Supported currencies are USDT, USDC and SOL

[baseFiat*]
The fiat currency of the amount to be charged. Supported fiats are NGN, GHS, ZAR and KES

[amount*]
The amount in the fiat currency which is to be charged in the specified.

[email*]
Typically, the email of the person making the payment is to be
provided
.

```





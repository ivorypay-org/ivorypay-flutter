# ivorypay_flutter_example

Demonstrates how to use the ivorypay_flutter plugin.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


///To initiate a  transaction, a email address must be specified in the body of the request.
///This email address will be used to create an entry in the Business Customer list of your business if it does not already exist.
///So, typically, the email of the person making the payment is to be provided.
///Every newly initiated transaction is only valid for 5 mins unless payment is received and a verification request is made to the IvoryPay API


### Public Key
In order to use this library you are required to use your ivorypay public key and not the secret key. See how to get your API Keys [here](https://ivory-pay.gitbook.io/ivorypay-api-documentation/authorization/using-your-api-key)


## Usage
Below are a few examples showcasing how you can use the library to implement payment in your Flutter app.

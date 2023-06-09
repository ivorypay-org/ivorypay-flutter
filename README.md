# ivorypay_flutter

Ivorypay Flutter SDK
## Getting Started
///To initiate a  transaction, a email address must be specified in the body of the request.
///This email address will be used to create an entry in the Business Customer list of your business if it does not already exist.
///So, typically, the email of the person making the payment is to be provided.
///Every newly initiated transaction is only valid for 5 mins unless payment is received and a verification request is made to the IvoryPay API


### Public Key
In order to use this library you are required to use your ivorypay public key and not the secret key. See how to get your API Keys [here](https://ivory-pay.gitbook.io/ivorypay-api-documentation/authorization/using-your-api-key)


## Usage
Below are a few examples showcasing how you can use the library to implement payment in your Flutter app.

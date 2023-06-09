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
  ///
  ///
  ///
  String? baseFiat;

  num? amount;
  String? crypto;
  String? email;
  String? authorization;
  dynamic metadata;

  InitiateIvorypayTransaction copyWith({
    String? baseFiat,
    num? amount,
    String? crypto,
    String? email,
    String? authorization,
    dynamic metadata,
  }) =>
      InitiateIvorypayTransaction(
        baseFiat: baseFiat ?? this.baseFiat,
        amount: amount ?? this.amount,
        crypto: crypto ?? this.crypto,
        email: email ?? this.email,
        authorization: authorization ?? this.authorization,
        metadata: metadata ?? this.metadata,
      );

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

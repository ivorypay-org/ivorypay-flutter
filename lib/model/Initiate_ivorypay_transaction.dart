/// baseFiat : "NGN"
/// amount : 40
/// crypto : "USDC"
/// email : "nwakasistephenifeanyi@gmail.com"
/// metadata : null

/// The InitiateIvorypayTransaction class represents a transaction object with
/// properties such as baseFiat, amount, crypto, email, authorization, and metadata,
/// and includes methods for JSON serialization and copying.
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

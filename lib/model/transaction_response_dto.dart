/// The TransactionResponseDto class is a data transfer object that represents a
/// response from a transaction, including success status, message, and data.
class TransactionResponseDto {
  TransactionResponseDto({
    this.success,
    this.message,
    this.data,
  });

  TransactionResponseDto.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  TransactionResponseDto copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      TransactionResponseDto(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// The above class defines a data model for a transaction with various properties
/// such as ID, email, address, expected amount in USD and crypto, fees, and
/// exchange rates.
class Data {
  Data({
    this.id,
    this.email,
    this.address,
    this.reference,
    this.expectedAmountInUSD,
    this.expectedAmountInCrypto,
    this.feeInCrypto,
    this.feeInUSD,
    this.expectedAmountWithFeeInCrypto,
    this.crypto,
    this.baseFiat,
    this.baseFiatToUSDRate,
    this.usdToCryptoRate,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    address = json['address'];
    reference = json['reference'];
    expectedAmountInUSD = json['expectedAmountInUSD'];
    expectedAmountInCrypto = json['expectedAmountInCrypto'];
    feeInCrypto = json['feeInCrypto'];
    feeInUSD = json['feeInUSD'];
    expectedAmountWithFeeInCrypto = json['expectedAmountWithFeeInCrypto'];
    crypto = json['crypto'];
    baseFiat = json['baseFiat'];
    baseFiatToUSDRate = json['baseFiatToUSDRate'];
    usdToCryptoRate = json['usdToCryptoRate'];
  }

  String? id;
  String? email;
  String? address;
  String? reference;
  num? expectedAmountInUSD;
  num? expectedAmountInCrypto;
  num? feeInCrypto;
  num? feeInUSD;
  num? expectedAmountWithFeeInCrypto;
  String? crypto;
  String? baseFiat;
  num? baseFiatToUSDRate;
  num? usdToCryptoRate;

  Data copyWith({
    String? id,
    String? email,
    String? address,
    String? reference,
    num? expectedAmountInUSD,
    num? expectedAmountInCrypto,
    num? feeInCrypto,
    num? feeInUSD,
    num? expectedAmountWithFeeInCrypto,
    String? crypto,
    String? baseFiat,
    num? baseFiatToUSDRate,
    num? usdToCryptoRate,
  }) =>
      Data(
        id: id ?? this.id,
        email: email ?? this.email,
        address: address ?? this.address,
        reference: reference ?? this.reference,
        expectedAmountInUSD: expectedAmountInUSD ?? this.expectedAmountInUSD,
        expectedAmountInCrypto:
            expectedAmountInCrypto ?? this.expectedAmountInCrypto,
        feeInCrypto: feeInCrypto ?? this.feeInCrypto,
        feeInUSD: feeInUSD ?? this.feeInUSD,
        expectedAmountWithFeeInCrypto:
            expectedAmountWithFeeInCrypto ?? this.expectedAmountWithFeeInCrypto,
        crypto: crypto ?? this.crypto,
        baseFiat: baseFiat ?? this.baseFiat,
        baseFiatToUSDRate: baseFiatToUSDRate ?? this.baseFiatToUSDRate,
        usdToCryptoRate: usdToCryptoRate ?? this.usdToCryptoRate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['address'] = address;
    map['reference'] = reference;
    map['expectedAmountInUSD'] = expectedAmountInUSD;
    map['expectedAmountInCrypto'] = expectedAmountInCrypto;
    map['feeInCrypto'] = feeInCrypto;
    map['feeInUSD'] = feeInUSD;
    map['expectedAmountWithFeeInCrypto'] = expectedAmountWithFeeInCrypto;
    map['crypto'] = crypto;
    map['baseFiat'] = baseFiat;
    map['baseFiatToUSDRate'] = baseFiatToUSDRate;
    map['usdToCryptoRate'] = usdToCryptoRate;
    return map;
  }
}

/// success : true
/// message : "Transaction was initiated successfully"
/// data : {"id":"43cf7729-9eda-4664-97c3-54cb277addad","email":"nwakasistephenifeanyi@gmail.com","address":"EzkKJVw91CgZnpBms5KHwh5RRyqfoAorHuQXLSyeb4wN","reference":"4yp7ye8vsea3gKio4A4g7pajPZvbS0wi","expectedAmountInUSD":0.0556,"expectedAmountInCrypto":0.0556,"feeInCrypto":0.0006,"feeInUSD":0.000556,"expectedAmountWithFeeInCrypto":0.0562,"crypto":"USDC","baseFiat":"NGN","baseFiatToUSDRate":720,"usdToCryptoRate":1.000166817166604}

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

/// id : "43cf7729-9eda-4664-97c3-54cb277addad"
/// email : "nwakasistephenifeanyi@gmail.com"
/// address : "EzkKJVw91CgZnpBms5KHwh5RRyqfoAorHuQXLSyeb4wN"
/// reference : "4yp7ye8vsea3gKio4A4g7pajPZvbS0wi"
/// expectedAmountInUSD : 0.0556
/// expectedAmountInCrypto : 0.0556
/// feeInCrypto : 0.0006
/// feeInUSD : 0.000556
/// expectedAmountWithFeeInCrypto : 0.0562
/// crypto : "USDC"
/// baseFiat : "NGN"
/// baseFiatToUSDRate : 720
/// usdToCryptoRate : 1.000166817166604

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

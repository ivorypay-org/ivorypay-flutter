/// The [VerifyTransactionRes[ class is a model for a response object that contains
/// information about a transaction verification, including success status, message,
/// and data.
class VerifyTransactionRes {
  VerifyTransactionRes({
    this.success,
    this.message,
    this.data,
  });

  VerifyTransactionRes.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  VerifyTransactionRes copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      VerifyTransactionRes(
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

/// The class "Data" has not been defined yet, so it cannot be summarized.
class Data {
  Data({
    this.uuid,
    this.reference,
    this.cryptoTransactionHash,
    this.expectedAmountInCrypto,
    this.expectedAmountInUSD,
    this.expectedAmountInBaseFiat,
    this.expectedAmountInBusinessPrimaryFiat,
    this.receivedAmountInCrypto,
    this.receivedAmountInUSD,
    this.receivedAmountInBaseFiat,
    this.receivedAmountInBusinessPrimaryFiat,
    this.excessAmountReceivedInCrypto,
    this.feeInCrypto,
    this.expectedAmountInCryptoPlusFee,
    this.crypto,
    this.baseFiat,
    this.businessPrimaryFiat,
    this.baseFiatToUSDRate,
    this.baseFiatToBusinessPrimaryFiatRate,
    this.usdToCryptoRate,
    this.address,
    this.metadata,
    this.environment,
    this.origin,
    this.businessId,
    this.userId,
    this.customerId,
    this.expiresAt,
    this.completedAt,
    this.status,
    this.failureReason,
    this.createdAtDateOnly,
    this.createdAt,
    this.customer,
  });

  Data.fromJson(dynamic json) {
    uuid = json['uuid'];
    reference = json['reference'];
    cryptoTransactionHash = json['cryptoTransactionHash'];
    expectedAmountInCrypto = json['expectedAmountInCrypto'];
    expectedAmountInUSD = json['expectedAmountInUSD'];
    expectedAmountInBaseFiat = json['expectedAmountInBaseFiat'];
    expectedAmountInBusinessPrimaryFiat =
        json['expectedAmountInBusinessPrimaryFiat'];
    receivedAmountInCrypto = json['receivedAmountInCrypto'];
    receivedAmountInUSD = json['receivedAmountInUSD'];
    receivedAmountInBaseFiat = json['receivedAmountInBaseFiat'];
    receivedAmountInBusinessPrimaryFiat =
        json['receivedAmountInBusinessPrimaryFiat'];
    excessAmountReceivedInCrypto = json['excessAmountReceivedInCrypto'];
    feeInCrypto = json['feeInCrypto'];
    expectedAmountInCryptoPlusFee = json['expectedAmountInCryptoPlusFee'];
    crypto = json['crypto'];
    baseFiat = json['baseFiat'];
    businessPrimaryFiat = json['businessPrimaryFiat'];
    baseFiatToUSDRate = json['baseFiatToUSDRate'];
    baseFiatToBusinessPrimaryFiatRate =
        json['baseFiatToBusinessPrimaryFiatRate'];
    usdToCryptoRate = json['usdToCryptoRate'];
    address = json['address'];
    metadata = json['metadata'];
    environment = json['environment'];
    origin = json['origin'];
    businessId = json['businessId'];
    userId = json['userId'];
    customerId = json['customerId'];
    expiresAt = json['expiresAt'];
    completedAt = json['completedAt'];
    status = json['status'];
    failureReason = json['failureReason'];
    createdAtDateOnly = json['createdAtDateOnly'];
    createdAt = json['createdAt'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  String? uuid;
  String? reference;
  String? cryptoTransactionHash;
  num? expectedAmountInCrypto;
  num? expectedAmountInUSD;
  num? expectedAmountInBaseFiat;
  num? expectedAmountInBusinessPrimaryFiat;
  num? receivedAmountInCrypto;
  num? receivedAmountInUSD;
  num? receivedAmountInBaseFiat;
  num? receivedAmountInBusinessPrimaryFiat;
  num? excessAmountReceivedInCrypto;
  num? feeInCrypto;
  num? expectedAmountInCryptoPlusFee;
  String? crypto;
  String? baseFiat;
  String? businessPrimaryFiat;
  num? baseFiatToUSDRate;
  num? baseFiatToBusinessPrimaryFiatRate;
  num? usdToCryptoRate;
  String? address;
  dynamic metadata;
  String? environment;
  String? origin;
  String? businessId;
  String? userId;
  String? customerId;
  String? expiresAt;
  String? completedAt;
  String? status;
  String? failureReason;
  String? createdAtDateOnly;
  String? createdAt;
  Customer? customer;

  Data copyWith({
    String? uuid,
    String? reference,
    String? cryptoTransactionHash,
    num? expectedAmountInCrypto,
    num? expectedAmountInUSD,
    num? expectedAmountInBaseFiat,
    num? expectedAmountInBusinessPrimaryFiat,
    num? receivedAmountInCrypto,
    num? receivedAmountInUSD,
    num? receivedAmountInBaseFiat,
    num? receivedAmountInBusinessPrimaryFiat,
    num? excessAmountReceivedInCrypto,
    num? feeInCrypto,
    num? expectedAmountInCryptoPlusFee,
    String? crypto,
    String? baseFiat,
    String? businessPrimaryFiat,
    num? baseFiatToUSDRate,
    num? baseFiatToBusinessPrimaryFiatRate,
    num? usdToCryptoRate,
    String? address,
    dynamic metadata,
    String? environment,
    String? origin,
    String? businessId,
    String? userId,
    String? customerId,
    String? expiresAt,
    String? completedAt,
    String? status,
    String? failureReason,
    String? createdAtDateOnly,
    String? createdAt,
    Customer? customer,
  }) =>
      Data(
        uuid: uuid ?? this.uuid,
        reference: reference ?? this.reference,
        cryptoTransactionHash:
            cryptoTransactionHash ?? this.cryptoTransactionHash,
        expectedAmountInCrypto:
            expectedAmountInCrypto ?? this.expectedAmountInCrypto,
        expectedAmountInUSD: expectedAmountInUSD ?? this.expectedAmountInUSD,
        expectedAmountInBaseFiat:
            expectedAmountInBaseFiat ?? this.expectedAmountInBaseFiat,
        expectedAmountInBusinessPrimaryFiat:
            expectedAmountInBusinessPrimaryFiat ??
                this.expectedAmountInBusinessPrimaryFiat,
        receivedAmountInCrypto:
            receivedAmountInCrypto ?? this.receivedAmountInCrypto,
        receivedAmountInUSD: receivedAmountInUSD ?? this.receivedAmountInUSD,
        receivedAmountInBaseFiat:
            receivedAmountInBaseFiat ?? this.receivedAmountInBaseFiat,
        receivedAmountInBusinessPrimaryFiat:
            receivedAmountInBusinessPrimaryFiat ??
                this.receivedAmountInBusinessPrimaryFiat,
        excessAmountReceivedInCrypto:
            excessAmountReceivedInCrypto ?? this.excessAmountReceivedInCrypto,
        feeInCrypto: feeInCrypto ?? this.feeInCrypto,
        expectedAmountInCryptoPlusFee:
            expectedAmountInCryptoPlusFee ?? this.expectedAmountInCryptoPlusFee,
        crypto: crypto ?? this.crypto,
        baseFiat: baseFiat ?? this.baseFiat,
        businessPrimaryFiat: businessPrimaryFiat ?? this.businessPrimaryFiat,
        baseFiatToUSDRate: baseFiatToUSDRate ?? this.baseFiatToUSDRate,
        baseFiatToBusinessPrimaryFiatRate: baseFiatToBusinessPrimaryFiatRate ??
            this.baseFiatToBusinessPrimaryFiatRate,
        usdToCryptoRate: usdToCryptoRate ?? this.usdToCryptoRate,
        address: address ?? this.address,
        metadata: metadata ?? this.metadata,
        environment: environment ?? this.environment,
        origin: origin ?? this.origin,
        businessId: businessId ?? this.businessId,
        userId: userId ?? this.userId,
        customerId: customerId ?? this.customerId,
        expiresAt: expiresAt ?? this.expiresAt,
        completedAt: completedAt ?? this.completedAt,
        status: status ?? this.status,
        failureReason: failureReason ?? this.failureReason,
        createdAtDateOnly: createdAtDateOnly ?? this.createdAtDateOnly,
        createdAt: createdAt ?? this.createdAt,
        customer: customer ?? this.customer,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = uuid;
    map['reference'] = reference;
    map['cryptoTransactionHash'] = cryptoTransactionHash;
    map['expectedAmountInCrypto'] = expectedAmountInCrypto;
    map['expectedAmountInUSD'] = expectedAmountInUSD;
    map['expectedAmountInBaseFiat'] = expectedAmountInBaseFiat;
    map['expectedAmountInBusinessPrimaryFiat'] =
        expectedAmountInBusinessPrimaryFiat;
    map['receivedAmountInCrypto'] = receivedAmountInCrypto;
    map['receivedAmountInUSD'] = receivedAmountInUSD;
    map['receivedAmountInBaseFiat'] = receivedAmountInBaseFiat;
    map['receivedAmountInBusinessPrimaryFiat'] =
        receivedAmountInBusinessPrimaryFiat;
    map['excessAmountReceivedInCrypto'] = excessAmountReceivedInCrypto;
    map['feeInCrypto'] = feeInCrypto;
    map['expectedAmountInCryptoPlusFee'] = expectedAmountInCryptoPlusFee;
    map['crypto'] = crypto;
    map['baseFiat'] = baseFiat;
    map['businessPrimaryFiat'] = businessPrimaryFiat;
    map['baseFiatToUSDRate'] = baseFiatToUSDRate;
    map['baseFiatToBusinessPrimaryFiatRate'] =
        baseFiatToBusinessPrimaryFiatRate;
    map['usdToCryptoRate'] = usdToCryptoRate;
    map['address'] = address;
    map['metadata'] = metadata;
    map['environment'] = environment;
    map['origin'] = origin;
    map['businessId'] = businessId;
    map['userId'] = userId;
    map['customerId'] = customerId;
    map['expiresAt'] = expiresAt;
    map['completedAt'] = completedAt;
    map['status'] = status;
    map['failureReason'] = failureReason;
    map['createdAtDateOnly'] = createdAtDateOnly;
    map['createdAt'] = createdAt;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    return map;
  }
}

class Customer {
  Customer({
    this.uuid,
    this.refCode,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.totalSpendInUSD,
    this.businessId,
    this.userId,
    this.context,
    this.createdAtDateOnly,
    this.createdAt,
  });

  Customer.fromJson(dynamic json) {
    uuid = json['uuid'];
    refCode = json['refCode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    totalSpendInUSD = json['totalSpendInUSD'];
    businessId = json['businessId'];
    userId = json['userId'];
    context = json['context'];
    createdAtDateOnly = json['createdAtDateOnly'];
    createdAt = json['createdAt'];
  }

  String? uuid;
  String? refCode;
  dynamic firstName;
  dynamic lastName;
  String? email;
  dynamic phoneNumber;
  num? totalSpendInUSD;
  String? businessId;
  String? userId;
  String? context;
  String? createdAtDateOnly;
  String? createdAt;

  Customer copyWith({
    String? uuid,
    String? refCode,
    dynamic firstName,
    dynamic lastName,
    String? email,
    dynamic phoneNumber,
    num? totalSpendInUSD,
    String? businessId,
    String? userId,
    String? context,
    String? createdAtDateOnly,
    String? createdAt,
  }) =>
      Customer(
        uuid: uuid ?? this.uuid,
        refCode: refCode ?? this.refCode,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        totalSpendInUSD: totalSpendInUSD ?? this.totalSpendInUSD,
        businessId: businessId ?? this.businessId,
        userId: userId ?? this.userId,
        context: context ?? this.context,
        createdAtDateOnly: createdAtDateOnly ?? this.createdAtDateOnly,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uuid'] = uuid;
    map['refCode'] = refCode;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['totalSpendInUSD'] = totalSpendInUSD;
    map['businessId'] = businessId;
    map['userId'] = userId;
    map['context'] = context;
    map['createdAtDateOnly'] = createdAtDateOnly;
    map['createdAt'] = createdAt;
    return map;
  }
}

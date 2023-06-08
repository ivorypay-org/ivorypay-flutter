/// success : false
/// message : "Transaction not found"
/// statusCode : 404
/// errors : ["",""]
/// timestamp : "6/8/2023, 4:24:44 AM"
/// path : "/v1/transactions/2RQUugQxy8TsdZjAXEEmeBGOo8sbQam/verify"
/// method : "GET"

class IvoryErrorResponse {
  IvoryErrorResponse({
      this.success, 
      this.message, 
      this.statusCode, 
      this.errors, 
      this.timestamp, 
      this.path, 
      this.method,});

  IvoryErrorResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    errors = json['errors'] != null ? json['errors'].cast<String>() : [];
    timestamp = json['timestamp'];
    path = json['path'];
    method = json['method'];
  }
  bool? success;
  String? message;
  num? statusCode;
  List<String>? errors;
  String? timestamp;
  String? path;
  String? method;
IvoryErrorResponse copyWith({  bool? success,
  String? message,
  num? statusCode,
  List<String>? errors,
  String? timestamp,
  String? path,
  String? method,
}) => IvoryErrorResponse(  success: success ?? this.success,
  message: message ?? this.message,
  statusCode: statusCode ?? this.statusCode,
  errors: errors ?? this.errors,
  timestamp: timestamp ?? this.timestamp,
  path: path ?? this.path,
  method: method ?? this.method,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['statusCode'] = statusCode;
    map['errors'] = errors;
    map['timestamp'] = timestamp;
    map['path'] = path;
    map['method'] = method;
    return map;
  }

}
/// The [IvoryErrorResponse] class is a Dart class that represents an error response
/// with properties such as success, message, statusCode, errors, timestamp, path,
/// and method.
///
///

class IvoryErrorResponse {
  IvoryErrorResponse({
    this.success,
    this.message,
    this.statusCode,
    this.errors,
    this.timestamp,
    this.path,
    this.method,
  });

  IvoryErrorResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    errors = json['errors'] != null ? json['errors'].cast<String>() : [];
    timestamp = json['timestamp'];
    path = json['path'];
    method = json['method'];
  }

  /// [bool? success;[ is declaring a nullable boolean variable named [success[ in
  bool? success;

  /// [String? message;[ is declaring a nullable String variable named [message[ as
  /// a property of the [IvoryErrorResponse[ class. The [?[ after the [String[ type
  /// indicates that the variable can be null. This means that the [message[
  /// property may or may not have a value assigned to it.
  String? message;

  /// [num? statusCode;[ is declaring a nullable numeric variable named [statusCode[
  /// in the [IvoryErrorResponse[ class. The [?[ after the type [num[ indicates that
  /// the variable can be assigned a value of [null[. This variable is used to store
  /// the HTTP status code of the error response.
  /// the [IvoryErrorResponse[ class. The [?[ after the type [bool[ indicates that
  /// the variable can be assigned a value of [null[.
  num? statusCode;

  /// [List<String>? errors;[ is declaring a nullable list of strings named [errors[
  /// the [errors] property may or may not have a value assigned to it. It is used
  /// to store any error messages associated with the error response.

  List<String>? errors;

  /// [timestamp] is declaring a nullable String variable named [timestamp[
  /// as a property of the [IvoryErrorResponse[ class. The [?[ after the [String[
  /// type indicates that the variable can be null. This means that the [timestamp[
  /// property may or may not have a value assigned to it. It is used to store the
  /// timestamp of the error response.
  String? timestamp;

  /// as a property of the [IvoryErrorResponse[ class. The [?[ after the
  /// [path] is declaring a nullable string variable named [path[ as a
  /// property of the [IvoryErrorResponse[ class. The [?[ after the [String[ type
  /// indicates that the variable can be null. This means that the [path[ property
  /// may or may not have a value assigned to it. It is used to store the path of
  /// the API endpoint that returned the error response.
  String? path;

  /// [List<String>] type indicates that the variable can be null. This means that
  /// [String? method;[ is declaring a nullable String variable named [method[ as a
  /// property of the [IvoryErrorResponse[ class. The [?[ after the [String[ type
  /// indicates that the variable can be null. This means that the [method[ property
  /// may or may not have a value assigned to it. It is used to store the HTTP
  /// method used in the request that generated the error response.
  String? method;

  IvoryErrorResponse copyWith({
    bool? success,
    String? message,
    num? statusCode,
    List<String>? errors,
    String? timestamp,
    String? path,
    String? method,
  }) =>
      IvoryErrorResponse(
        success: success ?? this.success,
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

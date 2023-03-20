import 'dart:convert';

class ErrorModel {
  Error? error;

  ErrorModel({this.error});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (error != null) {
      data['error'] = error!.toJson();
    }
    return data;
  }
}

class Error {
  String? code;
  String? message;
  String? details;

  Error({this.code, this.message, this.details});

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['details'] = details;
    return data;
  }
}

ErrorResponse? errorResponseFromJson(String str) =>
    ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    String? error,
    String? errorDescription,
  }) {
    _error = error;
    _errorDescription = errorDescription;
  }

  ErrorResponse.fromJson(dynamic json) {
    _error = json['error'] ?? '';
    _errorDescription = json['error_description'] ?? '';
  }

  String? _error;
  String? _errorDescription;

  String? get error => _error;

  String? get errorDescription => _errorDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['error_description'] = _errorDescription;
    return map;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombd/core/data/model/error_model.dart';
import 'package:ombd/core/error/exception.dart';

String handleException(Exception exception) {
  String? message = "An Exception has occurred";
  if (exception is ServerException) {
    return handleDioError(exception.dioError, exception.payByAPI ?? false);
  } else if (exception is NoInternetException) {
    message = "No internet connection available";
  } else if (exception is CubitException) {
    message = exception.message ?? message;
  }
  debugPrint("Cubit response_model.fold left: " + message);
  return message;
}

handleDioError(DioError dioError, bool payByAPI) {
  String message = "";
  switch (dioError.type) {
    case DioErrorType.cancel:
      message = "Request was cancelled";
      break;
    case DioErrorType.connectTimeout:
      message = "Connection timeout";
      break;

    case DioErrorType.other:
      message = "Failed to connect with server";
      break;
    case DioErrorType.receiveTimeout:
      message = "Receive timeout in connection";
      break;
    case DioErrorType.response:
      {
        ErrorModel? responseModel;
        try {
          responseModel = ErrorModel.fromJson(dioError.response?.data);
        } catch (e) {
          var error = ErrorResponse.fromJson(dioError.response?.data);
          if (error.error != null) {
            responseModel = ErrorModel(
                error: Error(
                    message: error.errorDescription ?? "", code: error.error));
          } else {
            responseModel = ErrorModel(
                error: Error(
              message: "An error has occurred!",
              code: "-100",
            ));
          }
        }

        if (dioError.response?.statusCode == 204) {
        } else if (dioError.response?.statusCode == 400) {
          // BadRequestException
          message = responseModel.error?.message ?? "BadRequestException";
        } else if (dioError.response?.statusCode == 401) {
          // UnauthorisedException
          message = responseModel.error?.message ?? "UnauthorisedException";
        } else if (dioError.response?.statusCode == 403) {
          // ForbiddenException
          message = responseModel.error?.message ?? "ForbiddenException";
        } else if (dioError.response?.statusCode == 500) {
          // ServerException
          message = responseModel.error?.message ?? "ServerException";
        } else {
          message =
              "Received invalid status code: ${dioError.response?.statusCode}";
        }
      }
      break;
    case DioErrorType.sendTimeout:
      message = "Receive timeout in send request";
      break;
  }
  return message;
}

abstract class BaseCubit<State> extends BlocBase<State> {
  /// {@macro cubit}
  BaseCubit(State initialState) : super(initialState);
}

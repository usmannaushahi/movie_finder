import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ombd/core/error/exception.dart';

import 'network_constants.dart';

class NetworkClient {
  final Dio dio;

  NetworkClient({
    required this.dio,
  });

  Future<Response> invoke(String? url, RequestType requestType,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      dynamic requestBody}) async {
    Response? response;

    //print request body
    debugPrint(
        "Request Parameter or Request Body is ${queryParameters ?? jsonEncode(requestBody.toString())}");

    dio.options.baseUrl = kBaseUrl;

    try {
      switch (requestType) {
        case RequestType.get:
          response = await dio.get(url ?? '',
              queryParameters: queryParameters,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.post:
          response = await dio.post(url ?? '',
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.put:
          response = await dio.put(url ?? '',
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.delete:
          response = await dio.delete(url ?? '',
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.patch:
          response = await dio.patch(url ?? '',
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
      }
      debugPrint('Response is: ${response.data}');
      return response;
    } on DioError catch (dioError) {
      throw ServerException(dioError: dioError);
    }
  }
}

// Types used by invoke API.
enum RequestType { get, post, put, delete, patch }

import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:ombd/core/network/network_client.dart';
import 'package:ombd/core/network/network_constants.dart';
import 'package:ombd/core/network/network_info.dart';

import 'domain_container.dart';
import 'presentation_container.dart';
import 'remote_container.dart';

final serviceLocator = GetIt.I;

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

Future<void> initDI() async {
  serviceLocator.allowReassignment = true;

  await initDIO();
  initPresentationDI();
  initRemoteDI();
  initDomainDI();

  // Network Client.
  serviceLocator
      .registerLazySingleton(() => NetworkClient(dio: serviceLocator()));

  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
}

Future<void> initDIO() async {
  Dio _dio = Dio();
  BaseOptions baseOptions = BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
      baseUrl: kBaseUrl,
      contentType: 'application/json',
      headers: {'Content-Type': 'application/json'},
      maxRedirects: 2);

  _dio.options = baseOptions;

  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  _dio.interceptors.clear();

  (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

  _dio.interceptors.add(InterceptorsWrapper(onError: (DioError error, handler) {
    return handler.next(error);
  }, onRequest: (RequestOptions requestOptions, handler) async {
    return handler.next(requestOptions);
  }, onResponse: (response, handler) async {
    return handler.next(response);
  }));

  if (serviceLocator.isRegistered<Dio>()) {
    await serviceLocator.unregister<Dio>();
  }

  serviceLocator.registerLazySingleton(() => _dio);
}
